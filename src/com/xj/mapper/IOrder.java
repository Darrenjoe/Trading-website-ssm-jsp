package com.xj.mapper;

import java.util.List;

import com.xj.entity.Orders;

/**
 * 订单信息Mapper
 * @author Darren
 * @Date 2018年4月27日 下午7:20:29
 */
public interface IOrder {

	// 添加订单
	boolean addOrder(Orders orders);

	// 获取全部订单
	public List<Orders> getAllOrder();

	// 根据买家ID获取订单
	public List<Orders> getOrdersByUserId(String userId);

	// 根据卖家ID获取订单
	public List<Orders> getOrdersBySellerId(String sellerId);

	// 根据ID查询订单
	public Orders getOrdersById(String id);
	
	//根据id更新订单数据
	boolean sureMyOrder(Orders order);
}
