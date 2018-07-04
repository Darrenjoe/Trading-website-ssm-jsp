package com.xj.mapper;

import java.util.List;

import com.xj.entity.Collect;

/**
 * 收藏信息Mapper
 * @author Darren
 * @Date 2018年4月27日 下午7:14:26
 */
public interface ICollect {

	// 添加收藏
	boolean addCollect(Collect collect);

	// 获取全部收藏
	public List<Collect> getAllCollect();

	// 根据用户ID获取收藏
	public List<Collect> getCollectByUserId(String collectioner);

	// 根据用户ID删除收藏
	public boolean deleteCollectByProductId(String id);

}
