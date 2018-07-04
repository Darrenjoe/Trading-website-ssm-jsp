<!DOCTYPE HTML>
<%@page pageEncoding="UTF-8"%>
<%@include file="/Resource/component.jsp"%>
<html>
<head>
<title>查看用户</title>
<link rel="stylesheet" href="Resource/css/globe.css">
<link rel="stylesheet" href="Resource/css/visituser.css">
<script src="<%=basePath%>Resource/js/jquery-2.0.3.min.js"></script>
<script>
	var userId;
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
		userId = GetQueryString("id");
		//显示用户信息
		showUserInfo();
		//显示商品
		showMyProduct();
	});

	//显示用户信息
	function showUserInfo() {
		$.ajax({
			type : "post",
			url : host + 'getUserById',
			data : {
				id : userId
			},
			dataType : "json",
			success : function(data) {
				console.log(data);
				$("#username").html(data.name);
				$("#gender").html(data.gender);
				$("#college").html(data.college);
				$("#signature").html(data.signature);
				$("#telephone").html(data.telephone);
				$("#wechat").html(data.wechat);
				$("#qqNumber").html(data.qqNumber);
			},
		});
	}

	//显示我的商品
	function showMyProduct() {
		$
				.ajax({
					type : "post",
					url : host + 'showMyProduct',
					data : {
						id : userId
					},
					dataType : "json",
					success : function(data) {
						console.log(data);
						var list = data.result;
						var str = "";
						$("#myProduct").html("");
						for (i in list) {
							str += "<tr>"
									+ "<td><img src=${pageContext.request.contextPath}/Resource/img/"
									+ list[i].imgUrl
									+ " name="
									+ list[i].id
									+ " onclick=goDetails(this.name) width=30px;/></td>"
									+ "<td>" + list[i].name + "</td>" + "<td>"
									+ list[i].price + "</td>" + "<td>"
									+ list[i].inventory + "</td>" + "</tr>";
						}
						$("#myProduct").append(str);
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

	//去到商品详情页面
	function goDetails(value) {
		window.location = "Jsp/details.jsp?productId=" + value;
	}
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

<div class="vis-main">
	<div class="vis-title">用户信息</div>
	<div class="vis-user-info">
		<div><strong>用户名：</strong><p id="username"></p></div>
		<div><ul>
			<li><strong>性别：</strong><p id="gender"></p></li>
			<li><strong>学院：</strong><p id="college"></p></li>
		</ul></div>
		<div style="clear: both"><strong>个性签名：</strong><p id="signature"></p></div>
		<div><strong>联系电话：</strong><p id="telephone"></p></div>
		<div><ul>
			<li><strong>微信：</strong><p id="wechat"></p></li>
			<li><strong>QQ：</strong><p id="qqNumber"></p></li>
		</ul></div>
	</div>
	<div class="vis-p-title">他的商品</div>
	<div class="vis-p-name">
		<ul>
			<li>商品图片</li>
			<li>商品名称</li>
			<li>商品价格</li>
			<li>商品数量</li>
		</ul>
		<div style="overflow: auto; width: 970px; height: 400px;">
			<table class="table-hover">
				<tbody id="myProduct">
				</tbody>
			</table>
		</div>
	</div>
</div>
	
<footer>
<p>@版权所有：西南科技大学.swust.jjglxg1402-Darren.</p>
</footer>
</body>
</html>