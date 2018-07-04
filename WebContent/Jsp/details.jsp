<!DOCTYPE HTML>
<%@page pageEncoding="UTF-8"%>
<%@include file="/Resource/component.jsp"%>
<html>
<head>
<title>商品详情</title>
<link rel="stylesheet" href="Resource/css/globe.css">
<link rel="stylesheet" href="Resource/css/details.css">
<link rel="stylesheet" href="Resource/css/sweet-alert.css">
<link href="<%=basePath%>Resource/css/jquery.datetimepicker.css" rel="stylesheet" />
<script src="<%=basePath%>Resource/js/jquery-2.0.3.min.js"></script>
<script src="./Resource/js/datetime/jquery.datetimepicker.js"></script>
<script type="text/javascript" src="Resource/js/sweet-alert.min.js" charset="UTF-8"></script>

<script>
	var sellerId;
	var price;
	var productName;//商品名称

	//获取url参数的值
	function getQueryString(name) {
		var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
		var r = window.location.search.substr(1).match(reg);
		if (r != null)
			return unescape(r[2]);
		return null;
	}

	//添加收藏
	function addCollect() {
		var productId = getQueryString("productId");
		var id =
<%=(String) session.getAttribute("userId")%>
	if (id == null || id == "") {
			window.location.href = "Jsp/login.jsp";
		} else {
			$.ajax({
				type : "post",
				url : host + 'addCollect',
				data : {
					productId : productId,
					collectioner : id
				},
				dataType : "json",
				success : function(data) {
					var data = data.result;
					switch (data) {
					case 1:
						alert("收藏成功");
						break;
					case 2:
						alert("该用户已经收藏该商品");
						break;
					default:
						alert("收藏失败");
						break;
					}
				},
			});
		}
	}

	//弹出订单框
	function showOrder() {
		$("#orderbox").attr("style", "display:inline");
	}

	//取消订单框
	function orderclose() {
		$("#orderbox").attr("style", "display:none");
	}

	//确认生成订单
	function createOrder() {
		var pronumber = $("#pronumber").val();//商品数量
		var orderplace = $("#orderplace").val();//交易地点
		var ordertime = $("#ordertime").val();//交易时间
		var userId =
<%=(String) session.getAttribute("userId")%>
	var allPrice = price * pronumber * 1;
		if (userId == null || userId == "") {
			window.location.href = "Jsp/login.jsp";
		} else {
			if (null == pronumber || "" == pronumber) {
				alert("请输入商品数量！");
				return;
			}
			if (null == orderplace || "" == orderplace) {
				alert("请输入交易地点！");
				return;
			}
			if (null == ordertime || "" == ordertime) {
				alert("请输入交易时间！");
				return;
			}
			if (userId == sellerId) {
				alert("亲，你要自己买自己的东西吗");
				return;
			}
			$.ajax({
				type : "post",
				url : host + 'addOrder',
				data : {
					orderplace : orderplace,
					ordertime : ordertime,
					userId : userId,
					sellerId : sellerId,
					allPrice : allPrice,
					productName : productName
				},
				dataType : "json",
				success : function(data) {
					if (data.result == 1) {
						alert("订单生成成功！");
					} else if (data.result == 2) {
						alert("该商品库存不够！");
					} else {
						alert("订单生成失败！");
					}
				},
			});
			$("#orderbox").attr("style", "display:none");
		}
	}

	//初始化显示商品信息
	$(document).ready(function() {
		var id = getQueryString("productId");
		$.ajax({
			type : "post",
			url : host + 'getProductById',
			data : {
				id : id
			},
			dataType : "json",
			success : function(data) {
				var data = data.result;
				$("#bgImg").attr('src', "${pageContext.request.contextPath}/Resource/img/" + data.imgUrl);
				$("#pro-info").html(data.productDesc);
				$("#pro-name").html(data.name);
				$("#pro-price").html(data.price + "元");
				$("#pro-number").html(data.inventory);
				sellerId = data.userId;
				price = data.price;
				productName = data.name;
				$.ajax({
					type : "post",
					url : host + 'getUserById',
					data : {
						id : data.userId
					},
					dataType : "json",
					success : function(data) {

						$("#name").html(data.name);
						$("#number").html(data.telephone);
						$("#wechat").html(data.wechat);
						$("#qq").html(data.qqNumber);
					},
				});
			},
		});
	});

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

	//加载时间控件
	setTimeout(function() {
		$(".form_datetime").datetimepicker({
			lang : 'ch',
			timepicker : true,
			formatDate : 'Y-m-d H:i'
		});
	}, 500);
</script>
</head>

<body>
<header>
	<div class="top">
		<div class="logo">
			<a href="#"><img alt="" src="Resource/images/logo6.gif"/></a>
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
				<li onmouseover="displaySubMenu(this)" onmouseout="hideSubMenu(this)">
					<a href="#">可爱的用户<img alt="" src="Resource/images/wan_heads.png"/></a>
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

<div class="det-top">
	<a>全部</a>&gt;<a>商品</a>&gt;<a></a></div>
<div class="det-info">
	<img id="bgImg" class="det-i-img"/>
	<div class="det-i-info">
		<div><strong>商品简介:</strong><p id="pro-info" style="font-size: 26px;"></p></div>
		<div><strong>商品名称:</strong><p id="pro-name" style="font-size: 26px;"></p></div>
		<div><strong>商品价格:</strong><p id="pro-price" style="font-size: 26px;"></p></div>
		<div><strong>商品数量:</strong><p id="pro-number" style="font-size: 26px;"></p></div>
	</div>
</div>
<div class="det-contact">
	<div class="det-c-l">
		<b>卖家联系方式</b><br/>
		<strong>姓名：</strong><p id="name"></p><br/>
		<strong>电话：</strong><p id="number"></p><br/>
		<strong>微信：</strong><p id="wechat"></p><br/>
		<strong>Q&nbsp;Q：</strong><p id="qq"></p>
	</div>
	<div class="det-c-r">
		<button id="collection" value="加入收藏" onclick="addCollect()">加入收藏</button><br>
		<button id="order" value="生成订单" onclick="showOrder()">生成订单</button>
	</div>
</div>
<div id="orderbox">
	<h1>加入订单</h1>
	<label>
	<span>商品数量</span>
	<input id="pronumber" type="text" value="" placeholder="商品数量"/> 
	</label>
	<label>
		<span>交易地址</span>
		<input id="orderplace" type="text" value="" placeholder="交易地址"/> 
	</label>
	<label>
		<span>交易时间</span>
		<input id="ordertime" class="form_datetime" placeholder="交易时间" size="22" type="text" value="">
	</label>
	<button onclick="orderclose()">取消</button>
	<button id="suremake" onclick="createOrder()">确认</button>
</div>

<footer>
    <p>@版权所有：西南科技大学.swust.jjglxg1402-Darren.</p >
</footer>
<div id="bg"></div>
</body>
</html>