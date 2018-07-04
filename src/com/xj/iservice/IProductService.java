package com.xj.iservice;

import java.util.List;

import com.xj.entity.Product;
import com.xj.entity.param.QueryConditionData;
import com.xj.util.Page;

/**
 * 商品信息服务接口
 * 
 * @author Darren
 * @Date 2018年4月27日 下午7:32:15
 */
public interface IProductService {
	
	// 添加商品
	boolean addProduct(Product product);

	// 获取全部商品
	public List<Product> getAllProduct();

	// 根据种类获取商品
	public List<Product> getProductKind(QueryConditionData queryConditionData, Page page);

	// 根据商品简介获取商品
	public List<Product> getProductByProductDesc(String productDesc);

	// 根据ID获取商品
	public Product getProductById(String id);

	// 根据ID删除商品信息
	public boolean deleteProductById(String id);

	// 根据用户ID获取商品
	public List<Product> getProductByUserId(String userId);

	// 根据用户ID删除商品
	public boolean deleteProductByUserId(String userId);

	// 根据名字获取商品
	public Product getProductByName(String name);

	// 修改商品库存量
	boolean updateProduct(Product product);
}
