package com.xj.entity.view;

/**
 * 用于订单详情页面
 * @author Darren
 * @Date 2018年4月27日 上午11:39:20
 */
public class OrderView {
	
	/**
	 * 主键ID
	 */
	private String id;
	/**
	 * 订单号
	 */
	private String orderNum;
	/**
	 * 商品名称
	 */
	private String productName;
	/**
	 * 商品价格
	 */
	private String price;
	/**
	 * 商品数量
	 */
	private int productNum;
	/**
	 * 买家
	 */
	private String buyer;
	/**
	 * 卖家
	 */
	private String seller;
	/**
	 * 交易地址
	 */
	private String receiverAddr;
	/**
	 * 交易时间
	 */
	private String deliveryTime;
	/**
	 * 图片地址
	 */
	private String imgUrl;
	/**
	 * 交易状态
	 */
	private int orderSure;
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
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public int getProductNum() {
		return productNum;
	}
	public void setProductNum(int productNum) {
		this.productNum = productNum;
	}
	public String getBuyer() {
		return buyer;
	}
	public void setBuyer(String buyer) {
		this.buyer = buyer;
	}
	public String getSeller() {
		return seller;
	}
	public void setSeller(String seller) {
		this.seller = seller;
	}
	public String getReceiverAddr() {
		return receiverAddr;
	}
	public void setReceiverAddr(String receiverAddr) {
		this.receiverAddr = receiverAddr;
	}
	public String getDeliveryTime() {
		return deliveryTime;
	}
	public void setDeliveryTime(String deliveryTime) {
		this.deliveryTime = deliveryTime;
	}
	public String getImgUrl() {
		return imgUrl;
	}
	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}
	public int getOrderSure() {
		return orderSure;
	}
	public void setOrderSure(int orderSure) {
		this.orderSure = orderSure;
	}
}
