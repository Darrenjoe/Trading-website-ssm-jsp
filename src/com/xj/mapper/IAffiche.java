package com.xj.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.xj.entity.Affiche;
import com.xj.entity.param.QueryConditionData;
import com.xj.util.Page;

/**
 * 公告栏信息Mapper
 * 
 * @author Darren
 * @Date 2018年4月27日 下午7:01:36
 */
public interface IAffiche {

	// 添加公告栏
	boolean addAffiche(Affiche affiche);

	// 获取全部公告栏信息
	public List<Affiche> getAllAffiche();

	// 获取部分公告栏信息
	public List<Affiche> querySomeAffice();

	// 根据用户ID获取公告栏
	public List<Affiche> getAfficheByUserId(String userId);

	// 根据ID删除公告栏
	public boolean deleteAfficheById(String id);

	// 根据内容搜索公告
	public List<Affiche> getAfficheByContent(@Param("content") String content);

	// 分页查询公告
	public List<Affiche> queryMoreAffiche(@Param("queryConditionData") QueryConditionData queryConditionData,
			Page page);
}
