package com.xj.iservice;

import java.util.List;

import com.xj.entity.Affiche;
import com.xj.entity.param.QueryConditionData;
import com.xj.entity.view.AfficheView;
import com.xj.util.Page;

/**
 * 公告栏信息服务接口
 * 
 * @author Darren
 * @Date 2018年4月27日 下午7:00:24
 */
public interface IAfficheService {

	// 添加公告栏
	public boolean addAffiche(Affiche affiche);

	// 获取全部公告栏信息
	public List<AfficheView> getAllAffiche();

	// 获取部分公告栏信息
	public List<Affiche> querySomeAffice();

	// 根据用户ID获取公告栏
	public List<AfficheView> getAfficheByUserId(String userId);

	// 根据ID删除公告栏
	public boolean deleteAfficheById(String id);

	// 根据内容搜索公告栏
	public List<Affiche> getAfficheByContent(String content);

	// 分页查询公共
	public List<Affiche> queryMoreAffiche(QueryConditionData queryConditionData, Page page);

}
