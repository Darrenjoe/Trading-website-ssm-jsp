package com.xj.iservice;

import java.util.List;

import com.xj.entity.Orders;
import com.xj.entity.view.OrderView;

/**
 * 订单信息服务接口
 * 
 * @author Darren
 * @Date 2018年4月27日 下午7:22:29
 */
public interface IOrderService {
	// 获取全部订单
	public List<Orders> getAllOrder();

	// 添加订单
	int addOrder(Orders order);

	// 根据用户ID获取订单
	public List<Orders> getOrdersByUserId(String userId);

	// 根据卖家ID获取订单
	public List<Orders> getOrdersBySellerId(String sellerId);

	// 根据ID查询订单
	public Orders getOrdersById(String id);

	// 订单详情页面显示的订单
	public OrderView showOrder(String id);
	
	//根据id更新订单数据
	boolean sureMyOrder(Orders order);
}
