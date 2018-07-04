package com.xj.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;

import com.xj.entity.Collect;
import com.xj.entity.Product;
import com.xj.entity.User;
import com.xj.iservice.IUserService;
import com.xj.mapper.ICollect;
import com.xj.mapper.IProduct;
import com.xj.mapper.IUser;

/**
 * 用户信息实现类
 * 
 * @author Darren
 * @Date 2018年4月27日 下午7:40:21
 */
@Scope("prototype")
public class UserService implements IUserService {
	@Autowired
	private IUser iUser;

	@Autowired
	private ICollect iCollect;

	@Autowired
	private IProduct iProduct;

	// 添加或者修改用户信息
	@Override
	public boolean addOrUpdateUser(User user) {
		try {
			if (user.getId() == null || user.getId().equals("")) {
				List<User> list = iUser.getAllUser();
				for (User user2 : list) {
					if (user.getLoginName().trim().equals(user2.getLoginName().trim())) {
						return false;
					}
				}
				int num = (int) (Math.random() * 1000000000);
				user.setId(num + "");
				user.setRole(1);
				user.setCollege("");
				user.setGender("");
				user.setUserName("");
				user.setName("");
				user.setSignature("");
				user.setState(0);
				user.setPhotoUrl("");
				iUser.addUser(user);
			} else {
				// iUser.updateUser(user);
			}
			return true;
		} catch (Exception e) {
			if (user.getId() == null || user.getId().equals("")) {
			} else {
			}
			return false;
		}
	}

	// 根据ID获取用户
	@Override
	public User getUserById(String id) {
		return iUser.getUserById(id);
	}

	// 根据登录名获取用户
	@Override
	public List<User> getUserByName(String name) {
		return iUser.getUserByName(name);
	}

	// 获取全部用户
	@Override
	public List<User> getAllUsers() {
		return iUser.getAllUser();
	}

	// 修改个人信息
	@Override
	public boolean updateUser(User user) {
		return iUser.updateUser(user);
	}

	// 修改密码
	@Override
	public boolean updatePwd(User user) {
		return iUser.updatePwd(user);
	}

	// 获取我的收藏
	@Override
	public List<Product> showMyCollect(String userId) {
		List<Product> list = new ArrayList<Product>();
		List<Collect> collectByUserId = iCollect.getCollectByUserId(userId);
		for (Collect collect : collectByUserId) {
			Product productById = iProduct.getProductById(collect.getProductId());
			list.add(productById);
		}
		return list;
	}

	// 删除我的收藏
	@Override
	public boolean deleteMyCollect(String productId) {
		return iCollect.deleteCollectByProductId(productId);
	}

	// 获取我的商品
	@Override
	public List<Product> showMyProduct(String userId) {
		return iProduct.getProductByUserId(userId);
	}

	// 删除我的商品
	public boolean deleteMyProduct(String id) {
		return iProduct.deleteProductById(id);
	}
	
	//更新头像
	@Override
	public boolean updatePhoto(User user) {
		return iUser.updatePhoto(user);
	}


}
