package com.xj.entity;

import java.util.Date;

/**
 * 订单信息实体类
 * @author Darren
 * @Date 2018年4月1日 下午3:36:56
 */
public class Orders {
	
	/**
	 * 主键ID
	 */
	private String id;
	/**
	 * 订单号
	 */
	private String orderNum;
	/**
	 * 用户ID
	 */
	private String userId;
	/**
	 * 产生时间
	 */
	private Date createTime;
	/**
	 * 接收人姓名
	 */
	private String receiverName;
	/**
	 * 交易地址
	 */
	private String receiverAddr;
	/**
	 * 交易时间
	 */
	private Date deliveryTime;
	/**
	 * 总价
	 */
	private String price;
	/**
	 * 订单状态
	 */
	private int orderSure;
	/**
	 * 状态
	 */
	private int state;
	/**
	 * 卖家ID
	 */
	private String sellerId;
	/**
	 * 商品名称
	 */
	private String productName;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getOrderNum() {
		return orderNum;
	}
	public void setOrderNum(String orderNum) {
		this.orderNum = orderNum;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public String getReceiverName() {
		return receiverName;
	}
	public void setReceiverName(String receiverName) {
		this.receiverName = receiverName;
	}
	public String getReceiverAddr() {
		return receiverAddr;
	}
	public void setReceiverAddr(String receiverAddr) {
		this.receiverAddr = receiverAddr;
	}
	public Date getDeliveryTime() {
		return deliveryTime;
	}
	public void setDeliveryTime(Date deliveryTime) {
		this.deliveryTime = deliveryTime;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public int getOrderSure() {
		return orderSure;
	}
	public void setOrderSure(int orderSure) {
		this.orderSure = orderSure;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public String getSellerId() {
		return sellerId;
	}
	public void setSellerId(String sellerId) {
		this.sellerId = sellerId;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	
	

}
