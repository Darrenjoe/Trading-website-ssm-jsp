package com.xj.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.portlet.ModelAndView;

import com.xj.entity.Product;
import com.xj.entity.param.QueryConditionData;
import com.xj.service.ProductService;
import com.xj.util.Page;

/**
 * 商品信息控制器
 * 
 * @author Darren
 * @Date 2018年4月27日 下午7:34:04
 */
@Controller
@Scope("prototype")
@ResponseBody()
public class ProductController extends BaseController {
	@Autowired
	private ProductService productService;

	// 获取全部商品
	@RequestMapping("/getAllProduct")
	public Result getAllProduct(HttpServletResponse response, HttpServletRequest request) {
		errorMessage = "getAllProduct";
		List<Product> allProduct = productService.getAllProduct();
		return result(allProduct);
	}

	// 根据ID获取商品
	@RequestMapping("/getProductById")
	public Result getProductById(HttpServletResponse response, HttpServletRequest request) {
		errorMessage = "getProductById";
		String id = request.getParameter("id");
		Product productById = productService.getProductById(id);
		return result(productById);
	}

	// 根据种类获取商品
	@RequestMapping("/getProductKind")
	public ModelAndView getProductKind(HttpServletResponse response, HttpServletRequest request) {
		errorMessage = "getProductKind";
		ModelAndView modelAndView = new ModelAndView();
		int pageSize = Integer.parseInt(request.getParameter("pageSize"));
		int page = Integer.parseInt(request.getParameter("page"));
		System.out.println("pagesize" + pageSize);
		System.out.println("page" + page);
		Page page2 = new Page(page, pageSize);
		String productDesc = request.getParameter("productDesc");
		String gategory = request.getParameter("gategory");
		QueryConditionData queryConditionData = new QueryConditionData();
		queryConditionData.setGategory(gategory);
		queryConditionData.setProductDesc(productDesc);
		List<Product> allProduct = productService.getProductKind(queryConditionData, page2);
		modelAndView.addObject("list", allProduct);
		modelAndView.addObject("page", page2);
		return modelAndView;
	}

	// 根据商品简介获取商品
	@RequestMapping("/getProductByProductDesc")
	public Result getProductByProductDesc(HttpServletResponse response, HttpServletRequest request) {
		errorMessage = "getProductByProductDesc";
		String productDesc = request.getParameter("productDesc");
		List<Product> data = productService.getProductByProductDesc(productDesc);
		return result(data);
	}
}
