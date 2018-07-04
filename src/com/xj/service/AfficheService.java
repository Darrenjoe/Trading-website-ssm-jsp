package com.xj.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;

import com.xj.entity.Affiche;
import com.xj.entity.User;
import com.xj.entity.param.QueryConditionData;
import com.xj.entity.view.AfficheView;
import com.xj.iservice.IAfficheService;
import com.xj.mapper.IAffiche;
import com.xj.mapper.IUser;
import com.xj.util.DateUtils;
import com.xj.util.Page;

/**
 * 公告栏信息实现类
 * 
 * @author Darren
 * @Date 2018年4月27日 下午7:00:49
 */
@Scope("prototype")
public class AfficheService implements IAfficheService {
	@Autowired
	private IAffiche iAffiche;
	@Autowired
	private IUser iUser;

	// 添加公告栏
	@Override
	public boolean addAffiche(Affiche affiche) {
		int num = (int) (Math.random() * 1000000000);
		affiche.setId(num + "");
		User userById = iUser.getUserById(affiche.getUserId());
		affiche.setPublisher(userById.getUserName());
		affiche.setCreateTime(new Date());
		return iAffiche.addAffiche(affiche);
	}

	// 获取全部公告栏信息
	@Override
	public List<AfficheView> getAllAffiche() {
		List<AfficheView> list = new ArrayList<>();
		List<Affiche> allAffiche = iAffiche.getAllAffiche();
		for (Affiche affiche : allAffiche) {
			AfficheView afficheView = new AfficheView();
			afficheView.setId(affiche.getId());
			afficheView.setContent(affiche.getContent());
			afficheView.setPublisher(affiche.getPublisher());
			afficheView.setUserId(affiche.getUserId());
			afficheView.setTitle(affiche.getTitle());
			Date createTime = affiche.getCreateTime();
			String time = DateUtils.formatDateToString(createTime, DateUtils.YYYY_MM_DD_HH_MM_SS);
			afficheView.setCreateTime(time);
			list.add(afficheView);
		}
		return list;
	}

	// 获取部分公告栏信息
	@Override
	public List<Affiche> querySomeAffice() {
		return iAffiche.querySomeAffice();
	}

	// 根据用户ID获取公告栏
	@Override
	public List<AfficheView> getAfficheByUserId(String userId) {
		List<AfficheView> list = new ArrayList<>();
		List<Affiche> affiche = iAffiche.getAfficheByUserId(userId);
		for (Affiche affiche2 : affiche) {
			AfficheView afficheView = new AfficheView();
			afficheView.setId(affiche2.getId());
			afficheView.setContent(affiche2.getContent());
			afficheView.setPublisher(affiche2.getPublisher());
			afficheView.setUserId(affiche2.getUserId());
			afficheView.setTitle(affiche2.getTitle());
			Date createTime = affiche2.getCreateTime();
			String time = DateUtils.formatDateToString(createTime, DateUtils.YYYY_MM_DD_HH_MM_SS);
			afficheView.setCreateTime(time);
			list.add(afficheView);
		}
		return list;
		//return iAffiche.getAfficheByUserId(userId);
	}

	// 根据ID删除公告栏
	@Override
	public boolean deleteAfficheById(String id) {
		return iAffiche.deleteAfficheById(id);
	}

	// 根据内容搜索公告
	@Override
	public List<Affiche> getAfficheByContent(String content) {
		return iAffiche.getAfficheByContent(content);
	}

	// 分页查询公告
	@Override
	public List<Affiche> queryMoreAffiche(QueryConditionData queryConditionData, Page page) {
		return iAffiche.queryMoreAffiche(queryConditionData, page);
	}

}
