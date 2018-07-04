package com.xj.entity;

import java.util.Date;

/**
 * 公告栏实体类
 * @author Darren
 * @Date 2018年4月1日 下午3:43:38
 */
public class Affiche {
	
	/**
	 * 主键ID
	 */
	private String id;
	/**
	 * 标题
	 */
	private String title;
	/**
	 * 内容
	 */
	private String content;
	/**
	 * 发布时间
	 */
	private Date createTime;
	/**
	 * 发布人
	 */
	private String publisher;
	/**
	 * 用户ID
	 */
	private String userId;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}

}
