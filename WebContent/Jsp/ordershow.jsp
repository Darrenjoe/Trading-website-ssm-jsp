<!DOCTYPE HTML>
<%@page pageEncoding="UTF-8"%>
<%@include file="/Resource/component.jsp"%>
<html>
<head>
<title>订单详情</title>
<link rel="stylesheet" href="Resource/css/globe.css">
<link rel="stylesheet" href="Resource/css/ordershow.css">
<link href="Resource/css/bootstrap.min.css" rel="stylesheet" />
<script src="<%=basePath%>Resource/js/jquery-2.0.3.min.js"></script>
<script>
	var orderId;

	//获取url参数的值
	function GetQueryString(name) {
		var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
		var r = window.location.search.substr(1).match(reg);
		if (r != null)
			return unescape(r[2]);
		return null;
	}
	//初始化显示
	$(document).ready(function() {
		orderId = GetQueryString("id");
		console.log(orderId);
		//显示订单信息
		showOrder();
	});

	//显示订单信息
	function showOrder() {
		$.ajax({
			type : "post",
			url : host + 'showOrder',
			data : {
				id : orderId
			},
			dataType : "json",
			success : function(data) {
				var data = data.result;
				$("#ord-p-img").html("<img src='${pageContext.request.contextPath}/Resource/img/" + data.imgUrl + "' />");
				$("#orderNum").html(data.orderNum);
				$("#productName").html(data.productName);
				$("#price").html(data.price);
				$("#productNum").html(data.productNum);
				$("#buyer").html(data.buyer);
				$("#seller").html(data.seller);
				$("#address").html(data.receiverAddr);
				$("#time").html(data.deliveryTime);
				if(data.orderSure == 1){
					$("#ord-footer").html("已完成");
				}
				else if(data.orderSure == 0) {
					$("#ord-footer").html("未完成");
				}
			},
		});
	}

	function displaySubMenu(li) {
		var subMenu = li.getElementsByTagName("ul")[0];
		subMenu.style.display = "block";
	}
	function hideSubMenu(li) {
		var subMenu = li.getElementsByTagName("ul")[0];
		subMenu.style.display = "none";
	}

	//去到个人中心
	function goPerson() {
		var id =
<%=(String) session.getAttribute("userId")%>
	$.ajax({
			type : "post",
			url : host + 'getUserById',
			data : {
				id : id
			},
			dataType : "json",
			success : function(data) {
				if (0 == data.state) {
					if (1 == data.role) {
						window.location = "Jsp/userinfo.jsp";
					} else if (2 == data.role) {
						window.location = "Jsp/managerinfo.jsp";
					}
				}
			},
		});
	}

	//退出登录
	function logout() {
		$.ajax({
			type : "post",
			url : host + 'logout',
			dataType : "json"
		});
	}
</script>
</head>
<body>
<header>
	<div class="top">
		<div class="logo">
			<a href="#"><img alt="" src="Resource/images/logo6.gif" /></a>
		</div>
		<div class="nav">
			<ul>
				<li><a href="index.jsp">首页</a></li>
				<li><a href="Jsp/merchandise.jsp">商品</a></li>
				<li><a href="Jsp/notice.jsp">公告栏</a></li>
			</ul>
		</div>
		<div id="user">
			<ul>
				<li onmouseover="displaySubMenu(this)"
					onmouseout="hideSubMenu(this)">
					<a href="#">可爱的用户<img alt="" src="Resource/images/wan_heads.png" /></a>
					<ul>
						<li><a onclick="goPerson()">个人中心</a></li>
						<li><a onclick="logout()">注销登录</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</div>
</header>
<div class="globe-top"></div>

<div class="ord-main">
	<div class="ord-title">订单详情</div>
	<div class="ord-product">
		<div id="ord-p-img"></div>
		<div class="ord-p-info">
			<div><strong>订单编号：</strong><p id="orderNum"></p></div>
			<div><strong>商品名称：</strong><p id="productName"></p></div>
			<div><strong>商品价格：</strong><p id="price"></p></div>
			<div><strong>商品数量：</strong><p id="productNum"></p></div>
		</div>
	</div>
	<div class="ord-contact">
		<div><strong>买&nbsp;&nbsp;&nbsp;&nbsp;家：</strong><p id="buyer"></p></div>
		<div><strong>卖&nbsp;&nbsp;&nbsp;&nbsp;家：</strong><p id="seller"></p></div>
		<div><strong>交易地址：</strong><p id="address"></p></div>
		<div><strong>交易时间：</strong><p id="time"></p></div>
	</div>
	<div id="ord-footer"></div>
</div>
	
<footer>
<p>@版权所有：西南科技大学.swust.jjglxg1402-Darren.</p>
</footer>
</body>
</html>