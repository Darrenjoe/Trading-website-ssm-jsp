package com.xj.entity;

/**
 * 商品信息实体类
 * @author Darren
 * @Date 2018年4月1日 下午3:31:45
 */
public class Product {
	
	/**
	 * 主键ID
	 */
	private String id;
	/**
	 * 商品名称
	 */
	private String name;
	/**
	 * 商品类型
	 */
	private String gategory;
	/**
	 * 商品简介
	 */
	private String productDesc;
	/**
	 * 图片地址
	 */
	private String imgUrl;
	/**
	 * 是否优惠
	 */
	private int discount;
	/**
	 * 商品价格
	 */
	private String price;
	/**
	 * 优惠价格
	 */
	private String disprice;
	/**
	 * 库存量
	 */
	private int inventory;
	/**
	 * 状态
	 */
	private int state;
	/**
	 * 用户ID，用于关联上传商品的用户
	 */
	private String userId;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getGategory() {
		return gategory;
	}
	public void setGategory(String gategory) {
		this.gategory = gategory;
	}
	public String getProductDesc() {
		return productDesc;
	}
	public void setProductDesc(String productDesc) {
		this.productDesc = productDesc;
	}
	public int getDiscount() {
		return discount;
	}
	public void setDiscount(int discount) {
		this.discount = discount;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getDisprice() {
		return disprice;
	}
	public void setDisprice(String disprice) {
		this.disprice = disprice;
	}
	public int getInventory() {
		return inventory;
	}
	public void setInventory(int inventory) {
		this.inventory = inventory;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public String getImgUrl() {
		return imgUrl;
	}
	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	

}
