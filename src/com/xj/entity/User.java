package com.xj.entity;

/**
 * 用户实体类
 */
public class User{

	/**
	 * 主键ID
	 */
	private String id;
	/**
	 * 登录名
	 */
	private String loginName;
	/**
	 * 用户名
	 */
	private String userName;
	/**
	 * 密码
	 */
	private String password;
	/**
	 * 状态
	 */
	private int state;
	/**
	 * 用户角色
	 */
	private int role;
	/**
	 * 姓名
	 */
	private String name;
	/**
	 * 学院
	 */
	private String college;
	/**
	 * 联系电话
	 */
	private String telephone;
	/**
	 * QQ号
	 */
	private String qqNumber;
	/**
	 * 微信号
	 */
	private String wechat;
	/**
	 * 性别
	 */
	private String gender;
	/**
	 * 个性签名
	 */
	private String signature;
	/**
	 * 头像
	 */
	private String photoUrl;
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	

	public int getRole() {
		return role;
	}

	public void setRole(int role) {
		this.role = role;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCollege() {
		return college;
	}

	public void setCollege(String college) {
		this.college = college;
	}

	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public String getQqNumber() {
		return qqNumber;
	}

	public void setQqNumber(String qqNumber) {
		this.qqNumber = qqNumber;
	}

	public String getWechat() {
		return wechat;
	}

	public void setWechat(String wechat) {
		this.wechat = wechat;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getSignature() {
		return signature;
	}

	public void setSignature(String signature) {
		this.signature = signature;
	}
	public String getPhotoUrl() {
		return photoUrl;
	}
	public void setPhotoUrl(String photoUrl) {
		this.photoUrl = photoUrl;
	}
}
