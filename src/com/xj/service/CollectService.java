package com.xj.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;

import com.xj.entity.Collect;
import com.xj.iservice.ICollectService;
import com.xj.mapper.ICollect;
import com.xj.util.SystemUtils;

/**
 * 收藏信息实现类
 * 
 * @author Darren
 * @Date 2018年4月27日 下午7:14:52
 */
@Scope("prototype")
public class CollectService implements ICollectService {
	@Autowired
	private ICollect iCollect;

	// 添加收藏
	@Override
	public int addCollect(Collect collect) {
		List<Collect> allCollect = iCollect.getAllCollect();
		for (Collect collect2 : allCollect) {
			if (collect.getProductId().equals(collect2.getProductId())
					&& collect.getCollectioner().equals(collect2.getCollectioner())) {
				// 该用户已经收藏该商品
				return 2;
			}
		}
		collect.setId(SystemUtils.createUuid());
		collect.setCreateTime(new Date());
		boolean addCollect = iCollect.addCollect(collect);
		if (addCollect) {
			// 收藏成功
			return 1;
		}
		return 0;
	}

	// 获取全部收藏
	@Override
	public List<Collect> getAllCollect() {
		return iCollect.getAllCollect();
	}

	// 根据用户ID获取收藏
	@Override
	public List<Collect> getCollectByUserId(String collectioner) {
		return iCollect.getCollectByUserId(collectioner);
	}

	// 根据用户ID删除收藏
	@Override
	public boolean deleteCollectByProductId(String id) {
		return iCollect.deleteCollectByProductId(id);
	}

}
