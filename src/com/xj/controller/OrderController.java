package com.xj.controller;

import java.text.ParseException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xj.entity.Orders;
import com.xj.entity.view.OrderView;
import com.xj.service.OrderService;
import com.xj.util.DateUtils;

/**
 * 订单信息控制器
 * 
 * @author Darren
 * @Date 2018年4月27日 下午7:23:12
 */
@Controller
@Scope("prototype")
@ResponseBody()
public class OrderController extends BaseController {
	@Autowired
	private OrderService orderService;

	// 添加订单
	@RequestMapping(value = "/addOrder", method = RequestMethod.POST)
	public Result addOrder(HttpServletResponse response, HttpServletRequest request) throws ParseException {
		Orders order = new Orders();
		String orderplace = request.getParameter("orderplace");// 交易地点
		String ordertime = request.getParameter("ordertime") + ":00";// 交易时间
		String replaceAll = ordertime.replaceAll("/", "-");
		String userId = request.getParameter("userId");// 买家ID
		String sellerId = request.getParameter("sellerId");// 卖家ID
		String allPrice = request.getParameter("allPrice");// 总价
		String productName = request.getParameter("productName");// 商品名称
		order.setReceiverAddr(orderplace);
		order.setDeliveryTime(DateUtils.formatDate(replaceAll, DateUtils.YYYY_MM_DD_HH_MM_SS));
		order.setUserId(userId);
		order.setSellerId(sellerId);
		order.setPrice(allPrice);
		order.setProductName(productName);
		int data = orderService.addOrder(order);
		return result(data);
	}
	
	// 确认订单完成
	@RequestMapping(value = "/sureMyOrder", method = RequestMethod.POST)
	public Result sureMyOrder(HttpServletResponse response, HttpServletRequest request) {
		Orders order = new Orders();
		order.setId(request.getParameter("id"));
		order.setOrderSure(1);
		boolean data = orderService.sureMyOrder(order);
		return result(data);
	}
	// 获取全部订单
	@RequestMapping("/getAllOrder")
	public Result getAllOrder() {
		errorMessage = "getAllOrder";
		List<Orders> allOrder = orderService.getAllOrder();
		return result(allOrder);
	}

	// 根据买家ID获取订单
	@RequestMapping("/getOrdersByUserId")
	public Result getOrdersByUserId(String userId) {
		List<Orders> data = orderService.getOrdersByUserId(userId);
		return result(data);
	}

	// 根据卖家ID获取订单
	@RequestMapping("/getOrdersBySellerId")
	public Result getOrdersBySellerId(String sellerId) {
		List<Orders> data = orderService.getOrdersBySellerId(sellerId);
		return result(data);
	}

	// 订单详情页面显示订单信息
	@RequestMapping("/showOrder")
	public Result showOrder(String id) {
		OrderView data = orderService.showOrder(id);
		return result(data);
	}
}
