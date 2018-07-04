package com.xj.mapper;

import com.xj.entity.User;

import java.util.List;

/**
 * 用户信息Mapper
 * 
 * @author Darren
 * @Date 2018年4月27日 下午7:38:31
 */
public interface IUser {

	// 添加用户信息
	boolean addUser(User user);

	// 根据ID获取用户
	public User getUserById(String id);

	// 根据登录名获取用户
	public List<User> getUserByName(String loginName);

	// 获取全部用户
	public List<User> getAllUser();

	// 修改个人信息
	boolean updateUser(User user);

	// 修改密码
	boolean updatePwd(User user);
	
	//根据id更新头像
	boolean updatePhoto(User user);
	
}
