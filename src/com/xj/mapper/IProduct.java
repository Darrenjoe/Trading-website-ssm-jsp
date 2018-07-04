package com.xj.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.xj.entity.Product;
import com.xj.entity.param.QueryConditionData;
import com.xj.util.Page;

/**
 * 商品信息Mapper
 * @author Darren
 * @Date 2018年4月27日 下午7:29:17
 */
public interface IProduct {

	// 添加商品
	boolean addProduct(Product product);

	// 获取全部商品
	public List<Product> getAllProduct();

	// 根据种类获取商品
	public List<Product> getProductKind(@Param("queryConditionData") QueryConditionData queryConditionData, Page page);

	// 根据商品简介获取商品
	public List<Product> getProductByProductDesc(@Param("productDesc") String productDesc);

	// 根据ID获取商品
	public Product getProductById(String id);

	// 根据ID删除商品信息
	public boolean deleteProductById(String id);

	// 根据用户ID获取商品
	public List<Product> getProductByUserId(String userId);

	// 根据用户ID删除商品
	public boolean deleteProductByUserId(String userId);

	// 根据商品名称获取商品
	public Product getProductByName(@Param("name") String name);

	// 修改商品库存量
	boolean updateProduct(Product product);
}
