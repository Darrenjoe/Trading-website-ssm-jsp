package com.xj.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;

import com.xj.entity.Product;
import com.xj.entity.param.QueryConditionData;
import com.xj.iservice.IProductService;
import com.xj.mapper.IProduct;
import com.xj.util.Page;

/**
 * 商品信息实现类
 * 
 * @author Darren
 * @Date 2018年4月27日 下午7:29:27
 */
@Scope("prototype")
public class ProductService implements IProductService {
	@Autowired
	private IProduct iProduct;

	// 添加商品
	@Override
	public boolean addProduct(Product product) {
		int num = (int) (Math.random() * 1000000000);
		product.setId(num + "");
		product.setState(0);
		boolean addProduct = iProduct.addProduct(product);
		return addProduct;
	}

	// 获取全部商品
	@Override
	public List<Product> getAllProduct() {
		return iProduct.getAllProduct();
	}

	// 根据种类获取商品
	@Override
	public List<Product> getProductKind(QueryConditionData queryConditionData, Page page) {
		List<Product> productKind = iProduct.getProductKind(queryConditionData, page);
		return productKind;
	}

	// 根据商品简介获取商品
	@Override
	public List<Product> getProductByProductDesc(String productDesc) {
		return iProduct.getProductByProductDesc(productDesc);
	}

	// 根据ID获取商品
	@Override
	public Product getProductById(String id) {
		return iProduct.getProductById(id);
	}

	// 根据ID删除商品信息
	@Override
	public boolean deleteProductById(String id) {
		return iProduct.deleteProductById(id);
	}

	// 根据用户ID获取商品
	@Override
	public List<Product> getProductByUserId(String userId) {
		return iProduct.getProductByUserId(userId);
	}

	// 根据用户ID删除商品
	@Override
	public boolean deleteProductByUserId(String userId) {
		return iProduct.deleteProductByUserId(userId);
	}

	// 根据商品名称获取商品
	@Override
	public Product getProductByName(String name) {
		return iProduct.getProductByName(name);
	}

	// 修改商品库存量
	@Override
	public boolean updateProduct(Product product) {
		return iProduct.updateProduct(product);
	}
}
