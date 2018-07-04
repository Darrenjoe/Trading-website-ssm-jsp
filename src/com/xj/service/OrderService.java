package com.xj.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;

import com.xj.entity.Orders;
import com.xj.entity.Product;
import com.xj.entity.User;
import com.xj.entity.view.OrderView;
import com.xj.iservice.IOrderService;
import com.xj.mapper.IOrder;
import com.xj.mapper.IProduct;
import com.xj.mapper.IUser;
import com.xj.util.DateUtils;

/**
 * 订单信息实现类
 * @author Darren
 * @Date 2018年4月27日 下午7:20:46
 */
@Scope("prototype")
public class OrderService implements IOrderService{
	@Autowired
	private IOrder iOrder;
	@Autowired
	private IUser iUser;
	@Autowired
	private IProduct iProduct;

	// 添加订单
	@Override
	public int addOrder(Orders order) {
		int num=(int)(Math.random()*1000000000); 
		int num2=(int)(Math.random()*1000000000); 
		order.setId(num+"");
		Date now = new Date();
		order.setOrderNum(num2+"");
		order.setCreateTime(now);
		User userById = iUser.getUserById(order.getUserId());
		order.setReceiverName(userById.getName());
		order.setOrderSure(0);
		order.setState(0);
		Product productByName = iProduct.getProductByName(order.getProductName());
		int number = Integer.parseInt(order.getPrice())/Integer.parseInt(productByName.getPrice());
		if(number > productByName.getInventory()){
			return 2;//库存不够
		}
		boolean addOrder = iOrder.addOrder(order);
		if(addOrder){
			productByName.setInventory(productByName.getInventory()-number);
			boolean updateProduct = iProduct.updateProduct(productByName);
			if(!updateProduct){
				return 0;//减库存没成功
			}
			return 1;
		}
		return 0;
	}
	
	// 获取全部订单
	@Override
	public List<Orders> getAllOrder() {
		return iOrder.getAllOrder();
	}

	// 根据买家ID获取订单
	@Override
	public List<Orders> getOrdersByUserId(String userId) {
		return iOrder.getOrdersByUserId(userId);
	}

	// 根据卖家ID获取订单
	@Override
	public List<Orders> getOrdersBySellerId(String sellerId) {
		return iOrder.getOrdersBySellerId(sellerId);
	}

	// 根据ID查询订单
	@Override
	public Orders getOrdersById(String id) {
		return iOrder.getOrdersById(id);
	}

	//订单详情页面显示订单信息
	@Override
	public OrderView showOrder(String id) {
		OrderView orderView = new OrderView();
		Orders ordersById = iOrder.getOrdersById(id);
		orderView.setId(id);
		orderView.setOrderNum(ordersById.getOrderNum());
		orderView.setProductName(ordersById.getProductName());
		orderView.setOrderSure(ordersById.getOrderSure());
		Product productByName = iProduct.getProductByName(ordersById.getProductName());
		orderView.setPrice(productByName.getPrice());
		orderView.setImgUrl(productByName.getImgUrl());
		orderView.setProductNum(Integer.parseInt(ordersById.getPrice())/Integer.parseInt(productByName.getPrice()));
		User buyerInfo = iUser.getUserById(ordersById.getUserId());
		orderView.setBuyer(buyerInfo.getUserName());
		User sellerInfo = iUser.getUserById(ordersById.getSellerId());
		orderView.setSeller(sellerInfo.getUserName());
		orderView.setReceiverAddr(ordersById.getReceiverAddr());
		String time = DateUtils.formatDateToString(ordersById.getDeliveryTime(), DateUtils.YYYY_MM_DD_HH_MM_SS);
		orderView.setDeliveryTime(time);
		return orderView;
	}
	
	//更新订单状态
	@Override
	public boolean sureMyOrder(Orders order) {
		return iOrder.sureMyOrder(order);
	}
	
}
