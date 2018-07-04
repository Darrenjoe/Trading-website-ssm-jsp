package com.xj.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import com.xj.exception.DtpException;



/**
 * 日期工具类
 * author JieChen
 * createTime 11/19/15 4:58 PM
 */
public class DateUtils {
    /**
     * 时间格式
     */
    public static final String HH_MM_SS_S = "HH:mm:ss.S";

    /**
     * 时间格式
     */
    public static final String HH_MM_SS = "HH:mm:ss";


    /**
     * 时间格式
     */
    public static final String YYYY_MM_DD_HH_MM_SS_S = "yyyy-MM-dd HH:mm:ss.S";

    /**
     * 时间格式
     */
    public static final String YYYY_MM_DD = "yyyy-MM-dd";

    /**
     * 时间格式
     */
    public static final String YYYY_MM = "yyyy-MM";
    
    /**
     * 时间格式
     */
    public static final String MM_DD = "MM-dd";
    
    /***
     * 时间格式
     * 24小时制
     */
    public static final String HH ="HH";

    /**
     * 时间格式
     */
    public static final String YYYYMMDDHHMMSS = "yyyyMMddHHmmss";

    /**
     * 时间格式
     */
    public static final String YYYYMMDDHHMMSSS = "yyyyMMddHHmmssS";

    /**
     * 时间格式
     */
    public static final String YYYYNMMYDDR = "yyyy年MM月dd日";

    /**
     * 时间格式
     */
    public static final String YYYYMMDD_HHMMSSS = "yyyyMMdd-HHmmssS";

    /**
     * 时间格式
     */
    public static final String YYYY_MM_DD_HH_MM_SS = "yyyy-MM-dd HH:mm:ss";

    /**
     * 凌晨时间点
     */
    public static final String DATE_START_TIME = " 00:00:00";

    /**
     * 最晚时间
     */
    public static final String DATE_END_TIME = " 23:59:59";

    private DateUtils() {

    }

    /**
     * 格式化时间
     *
     * @param strDate 字符串日期
     * @param format  转换格式
     * @return Timestamp
     */
    public static Date formatDate(final String strDate, final String format) throws ParseException {
        return new SimpleDateFormat(format).parse(strDate);
    }

    /**
     * 转换日期为字符串
     *
     * @param date   日期
     * @param format 格式
     * @return String
     */
    public static String formatDateToString(final Date date, final String format) {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(format);
        return simpleDateFormat.format(date);
    }

    /**
     * 获取指定日期的Time Millis
     *
     * @param date 日期
     * @return long
     */
    public static long getDateTimeMillis(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        return calendar.getTimeInMillis();
    }


    /**
     * 计算下一天凌晨时间点
     * @param date 当前时间
     * @return Date
     * @throws ParseException
     */
    public static Date getNextDate(Date date) throws ParseException {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.add(Calendar.DATE, 1);
        String tempDate = formatDateToString(calendar.getTime(),YYYY_MM_DD);
        return formatDate(tempDate + " " + DATE_START_TIME, YYYY_MM_DD_HH_MM_SS);
    }
    
    /**
     * 计算上一天凌晨时间点
     * @param date 当前时间
     * @return Date
     * @throws ParseException
     */
    public static Date getBeforeDate(Date date) throws ParseException {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.add(Calendar.DATE, -1);
        String tempDate = formatDateToString(calendar.getTime(),YYYY_MM_DD);
        return formatDate(tempDate + " " + DATE_START_TIME, YYYY_MM_DD_HH_MM_SS);
    }
    
    /**
     * 当前时间所在周
     * @param mdate
     * @return List<Date>    返回类型
     */
    @SuppressWarnings("deprecation")
    public static List<Date> dateToWeek(Date mdate) {
        int b = mdate.getDay();
        if(b == 0){ 
            b = 7;
        }
        Date fdate;
        List<Date> list = new ArrayList<Date>();
        Long fTime = mdate.getTime() - b * 24 * 3600000;
        for (int a = 1; a <= 7; a++) {
            fdate = new Date();
            fdate.setTime(fTime + (a * 24 * 3600000));
            list.add(a-1, fdate);
        }
        return list;
    }
    
    public static boolean largerTime(String t1, String t2) {
        Date date1, date2;
        SimpleDateFormat formart = new SimpleDateFormat("hh:mm");
        try {
            date1 = formart.parse(t1);
            date2 = formart.parse(t2);
            return !(date1.compareTo(date2) < 0);
        } catch (ParseException e) {
            return false;
        }

    }
    
    /**
     * 根据 一个时间向前或者向后获取另一个时间
     * @param inTime 传过来的时间
     * @param timeUnit 时间单位  Calendar.MINUTE Calendar.DATE Calendar.HOUR
     * @param timeNumber 时间数 
     * @param beforeOrAfter 向前或者向后推 -1向前，1向后
     * @return Date
     * @throws DtpException 
     */
    public static Date acquireTimeByTime(Date inTime,int timeUnit,int timeNumber,int beforeOrAfter) throws DtpException{
        if(null == inTime){
            throw new DtpException("paramter is null");
        }
        Calendar cal = Calendar.getInstance();
        cal.setTime(inTime);
        cal.set(timeUnit, cal.get(timeUnit) + beforeOrAfter*timeNumber); 
        return cal.getTime();
    }
}
