package com.xj.entity;

import java.util.Date;

/**
 * 收藏栏实体类
 * @author Darren
 * @Date 2018年4月1日 下午3:46:20
 */
public class Collect {
	
	/**
	 * 主键ID
	 */
	private String id;
	/**
	 * 商品ID
	 */
	private String productId;
	/**
	 * 收藏时间
	 */
	private Date createTime;
	/**
	 * 收藏人
	 */
	private String collectioner;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getProductId() {
		return productId;
	}
	public void setProductId(String productId) {
		this.productId = productId;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public String getCollectioner() {
		return collectioner;
	}
	public void setCollectioner(String collectioner) {
		this.collectioner = collectioner;
	}
	

}
