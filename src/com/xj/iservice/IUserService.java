package com.xj.iservice;

import com.xj.entity.Product;
import com.xj.entity.User;

import java.util.List;

/**
 * 用户信息服务接口
 * 
 * @author Darren
 * @Date 2018年4月27日 下午7:43:13
 */
public interface IUserService {

	// 添加或者修改用户信息
	public boolean addOrUpdateUser(User user);

	// 根据ID获取用户
	public User getUserById(String id);

	// 根据登录名获取用户
	public List<User> getUserByName(String name);

	// 获取全部用户
	public List<User> getAllUsers();

	// 修改个人信息
	public boolean updateUser(User user);

	// 修改密码
	public boolean updatePwd(User user);

	// 获取我的收藏
	public List<Product> showMyCollect(String userId);

	// 删除我的收藏
	public boolean deleteMyCollect(String userId);

	// 获取我的商品
	public List<Product> showMyProduct(String userId);

	// 删除我的商品
	public boolean deleteMyProduct(String id);
	
	// 更新用户头像
	public boolean updatePhoto(User user);
}
