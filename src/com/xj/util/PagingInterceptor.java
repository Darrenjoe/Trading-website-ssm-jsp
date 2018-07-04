package com.xj.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.builder.StaticSqlSource;
import org.apache.ibatis.executor.Executor;
import org.apache.ibatis.executor.parameter.ParameterHandler;
import org.apache.ibatis.logging.Log;
import org.apache.ibatis.logging.jdbc.ConnectionLogger;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.mapping.SqlCommandType;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.plugin.Plugin;
import org.apache.ibatis.plugin.Signature;
import org.apache.ibatis.session.Configuration;
import org.apache.ibatis.session.ResultHandler;
import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.transaction.Transaction;

import com.xj.exception.DtpException;


/**
 * 分页查询时把List放入参数page中并返回
 */
@Intercepts({ @Signature(type = Executor.class, method = "query", args = { MappedStatement.class, Object.class,
        RowBounds.class, ResultHandler.class }) })
public class PagingInterceptor implements Interceptor {
    // 存储所有语句名称
    Map<String, String> mapStatement = new HashMap<String, String>();
    // 用户提供分页计算条数后缀
    static final String COUNT_ID = "_count";

    /**
     * 获取所有statement语句的名称
     * <p/>
     *
     * @param configuration
     */
    protected synchronized void initStatementMap(Configuration configuration) {
        if (!mapStatement.isEmpty()) {
            return;
        }
        Collection<String> statements = configuration.getMappedStatementNames();
        for (Iterator<String> iter = statements.iterator(); iter.hasNext();) {
            String element = iter.next();
            mapStatement.put(element, element);
        }
    }

    /**
     * 获取数据库连接
     * <p/>
     *
     * @param transaction
     * @param statementLog
     * @return
     * @throws SQLException
     */
    protected Connection getConnection(Transaction transaction, Log statementLog) throws SQLException {
        Connection connection = transaction.getConnection();
        if (statementLog.isDebugEnabled()) {
            return ConnectionLogger.newInstance(connection, statementLog, 1);
        } else {
            return connection;
        }
    }

    @Override
    public Object intercept(Invocation invocation) throws Throwable {
        Object parameter = invocation.getArgs()[1];
        Page page = seekPage(parameter);
        if (page == null) {
            return invocation.proceed();
        } else {
            return handlePaging(invocation, parameter, page);
        }

    }

    /**
     * 处理分页的情况
     * <p/>
     *
     * @param invocation
     * @param parameter
     * @param page
     * @throws SQLException
     */
    @SuppressWarnings("rawtypes")
    protected List handlePaging(Invocation invocation, Object parameter, Page page) throws DtpException {
        MappedStatement mappedStatement = (MappedStatement) invocation.getArgs()[0];
        Configuration configuration = mappedStatement.getConfiguration();
        if (mapStatement.isEmpty()) {
            initStatementMap(configuration);
        }
        BoundSql boundSql = mappedStatement.getBoundSql(parameter);
        // 查询结果集
        StaticSqlSource sqlsource = new StaticSqlSource(configuration, getLimitString(boundSql.getSql(), page),
                boundSql.getParameterMappings());
        MappedStatement.Builder builder = new MappedStatement.Builder(configuration, "id_temp_result", sqlsource,
                SqlCommandType.SELECT);
        builder.resultMaps(mappedStatement.getResultMaps()).resultSetType(mappedStatement.getResultSetType())
                .statementType(mappedStatement.getStatementType());
        MappedStatement queryStatement = builder.build();

        List data = (List) exeQuery(invocation, queryStatement);
        // 设置到page对象
        page.setRecords(data);
        page.setCount(getTotalSize(invocation, configuration, mappedStatement, boundSql, parameter));

        return data;
    }

    /**
     * 根据提供的语句执行查询操作
     * <p/>
     *
     * @param invocation
     * @param query_statement
     * @return
     * @throws Exception
     */
    protected Object exeQuery(Invocation invocation, MappedStatement query_statement) throws DtpException {
        Object[] args = invocation.getArgs();
        try {
            return invocation.getMethod().invoke(invocation.getTarget(),
                    new Object[] { query_statement, args[1], args[2], args[3] });
        } catch (Exception e) {
            throw new DtpException(e);
        }
    }

    /**
     * 获取总记录数量
     * <p/>
     *
     * @param configuration
     * @param mappedStatement
     * @param sql
     * @param parameter
     * @return
     * @throws SQLException
     */
    @SuppressWarnings("rawtypes")
    protected int getTotalSize(Invocation invocation, Configuration configuration, MappedStatement mappedStatement,
            BoundSql boundSql, Object parameter) throws DtpException {

        String countId = mappedStatement.getId() + COUNT_ID;
        int totalSize = 0;
        if (mapStatement.containsKey(countId)) {
            // 优先查找能统计条数的sql
            List data = (List) exeQuery(invocation, mappedStatement.getConfiguration().getMappedStatement(countId));
            if (data != null && !data.isEmpty()) {
                totalSize = Integer.parseInt(data.get(0).toString());
            }
        } else {
            try {
                Executor exe = (Executor) invocation.getTarget();
                Connection connection = getConnection(exe.getTransaction(), mappedStatement.getStatementLog());
                String countSql = getCountSql(boundSql.getSql());
                totalSize = getTotalSize(configuration, mappedStatement, boundSql, countSql, connection, parameter);
            } catch (SQLException e) {
                throw new DtpException(e);
            }
        }

        return totalSize;
    }

    /**
     * 拼接查询sql,加入limit
     * <p/>
     *
     * @param sql
     * @param page
     */
    protected String getLimitString(String sql, Page page) {
        StringBuilder sb = new StringBuilder(sql.length() + 100);
        sb.append(sql);
        sb.append(" limit ").append(page.getStartNo() - 1).append(",").append(page.getPageSize());
        return sb.toString();
    }

    /**
     * 拼接获取条数的sql语句
     * <p/>
     *
     * @param sqlPrimary
     * @throws DtpException 
     */
    protected String getCountSql(String sqlPrimary) throws DtpException {
        String sqlUse = sqlPrimary.replaceAll("[\\s]+", " ");
        String upperString = sqlUse.toUpperCase();
        int orderBy = upperString.lastIndexOf(" ORDER BY ");
        if (orderBy > -1) {
            sqlUse = sqlUse.substring(0, orderBy);
        }
        String[] paramsAndMethod = sqlUse.split("\\s");
        int count = 0;
        int index = 0;
        for (int i = 0; i < paramsAndMethod.length; i++) {
            String upper = paramsAndMethod[i].toUpperCase();
            if(StringUtils.isNotBlank(upper)){
                if (upper.contains("SELECT")) {
                    count++;
                } else if (upper.contains("FROM")) {
                    count--;
                }
                if (count == 0) {
                    index = i;
                    break;
                }
            }
        }
        StringBuilder return_sql = new StringBuilder("SELECT COUNT(1) AS cnt ");
        StringBuilder commonCount = new StringBuilder();
        for (int j = index; j < paramsAndMethod.length; j++) {
            commonCount.append(" ");
            commonCount.append(paramsAndMethod[j]);
        }
        if (upperString.contains(" GROUP BY ")) {
            throw new DtpException("不支持group by 分页,请自行提供sql语句以 查询语句+_count结尾.");
        }
        return return_sql.append(commonCount).toString();
    }

    /**
     * 计算总条数
     * <p/>
     *
     * @param parameterObj
     * @param countSql
     * @param connection
     * @return
     */
    protected int getTotalSize(Configuration configuration, MappedStatement mappedStatement, BoundSql boundSql,
            String countSql, Connection connection, Object parameter) throws SQLException {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        int totalSize = 0;
        try {
            ParameterHandler handler = configuration.newParameterHandler(mappedStatement, parameter, boundSql);
            stmt = connection.prepareStatement(countSql);
            handler.setParameters(stmt);
            rs = stmt.executeQuery();
            if (rs.next()) {
                totalSize = rs.getInt(1);
            }
        } catch (SQLException e) {
            throw e;
        } finally {
            if (rs != null) {
                rs.close();
                rs = null;
            }
            if (stmt != null) {
                stmt.close();
                stmt = null;
            }
        }
        return totalSize;
    }

    /**
     * 寻找page对象
     * <p/>
     *
     * @param parameter
     */
    @SuppressWarnings("rawtypes")
    protected Page seekPage(Object parameter) {
        Page page = null;
        if (parameter == null) {
            return null;
        }
        if (parameter instanceof Page) {
            page = (Page) parameter;
        } else if (parameter instanceof Map) {
            Map map = (Map) parameter;
            for (Object arg : map.values()) {
                if (arg instanceof Page) {
                    page = (Page) arg;
                }
            }
        }
        return page;
    }

    @Override
    public Object plugin(Object target) {
        return Plugin.wrap(target, this);
    }

    @Override
    public void setProperties(Properties properties) {
        // nothing to do
    }
}