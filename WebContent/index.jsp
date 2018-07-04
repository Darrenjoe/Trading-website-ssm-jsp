<!DOCTYPE HTML>
<%@page pageEncoding="UTF-8"%>
<%@include file="Resource/component.jsp"%>
<html>
<head>
<title>西科交易</title>
<link rel="stylesheet" href="Resource/css/globe.css">
<link rel="stylesheet" href="Resource/css/index.css">
<script type="text/javascript" src="Resource/js/flash.js"></script>
<script type="text/javascript" src="Resource/js/jquery-2.0.3.min.js" charset="UTF-8"></script>
<script>

	//登陆显示公告信息
	$(document).ready(
			function() {
				$.ajax({
					type : "post",
					url : host + 'querySomeAffice',
					dataType : "json",
					success : function(data) {
						var data = data.result;
						var str = "";
						//console.log(data);
						for (i in data) {
							str += "<tr>" + "<td id='tduser' onclick=goVisitUser("
									+ data[i].userId + ")>" + data[i].publisher
									+ "</td>" + "<td id='tdmessge' onclick=goNotice("
									+ data[i].userId + ")>" + data[i].content
									+ "</td>" + "</tr>";
						}
						$("#affiche").append(str);
					},
				});
			});

	//去到查看用户页面
	function goVisitUser(id) {
		window.location = "Jsp/visituser.jsp?id=" + id;
	}

	//去到公告栏页面
	function goNotice(id) {
		window.location = "Jsp/notice.jsp?id=" + id;
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
				//console.log(data);
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

	//去到登录页面
	function goLogin() {
		var userId =
<%=(String) session.getAttribute("userId")%>
	if (null == userId || "" == userId) {
			window.location.href = "Jsp/login.jsp";
		}
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
<div onclick="goLogin()" style="z-index: 999;">
<div id="container">
    <div id="list" style="left: -1300px;">
        <img src="Resource/images/flash3.jpg" alt="1" />
        <img src="Resource/images/flash1.jpg" alt="1" />
        <img src="Resource/images/flash2.jpg" alt="2" />
        <img src="Resource/images/flash3.jpg" alt="3" />
        <img src="Resource/images/flash1.jpg" alt="3" />
    </div>
    <div id="buttons">
        <span index="1" class="on"></span>
        <span index="2"></span>
        <span index="3"></span>
    </div>
    <a href="javascript:;" id="prev" class="arrow">&lt;</a>
    <a href="javascript:;" id="next" class="arrow">&gt;</a>
</div>
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

<div class="index-new">
	<div class="ind-n-title">
		<img class="ershou-1" src="Resource/images/ershou-1.png" alt=""/>
		<div class="ershou-2">
			<img alt="" src="Resource/images/1.png" name="1000038" onclick="goDetails(this.name)"/>
			<p>笔记本电脑</p>
			<p>￥2000</p>
		</div>
		<div class="ershou-2">
			<img alt="" src="Resource/images/2.png" name="1000035" onclick="goDetails(this.name)"/>
			<p>吉他</p>
			<p>￥240</p>
		</div>
		<div class="ershou-2">
			<img alt="" src="Resource/images/3.png" name="1000025" onclick="goDetails(this.name)"/>
			<p>四级听力耳机</p>
			<p>￥15</p>
		</div>
	</div>
	<div class="ind-n-show">
		<img class="biye-1" src="Resource/images/biye-1.jpg" alt=""/>
		<ul>
			<li>
				<img alt="" src="Resource/images/4.png" name="1000039" onclick="goDetails(this.name)"/>
			</li>
			<li class="biye-word">
				<p>迷你音箱</p>
				<p>￥15</p>
			</li>
			<li>
				<img alt="" src="Resource/images/7.png" name="1000040" onclick="goDetails(this.name)"/>
			</li>
			<li class="biye-word">
				<p>收纳盒</p>
				<p>￥8</p>
			</li>
		</ul>
		<ul>
			<li class="biye-word">
				<p>床上书桌</p>
				<p>￥15</p>
			</li>
			<li>
				<img alt="" src="Resource/images/5.png" name="1000019" onclick="goDetails(this.name)"/>
			</li>
			<li class="biye-word">
				<p>迷你风扇</p>
				<p>￥10</p>
			</li>
			<li>
				<img alt="" src="Resource/images/6.png" name="1000041" onclick="goDetails(this.name)"/>
			</li>
		</ul>
	</div>
	<div class="ind-n-book">
		<img class="esshuji" src="Resource/images/ershoushuji.jpg" alt=""/>
		<ul class="esshuji-1">
			<li>
				<img alt="" src="Resource/images/9.png" name="1000042" onclick="goDetails(this.name)"/>
				<p>我们仨</p>
				<p>￥15</p>
			</li>
			<li>
				<img alt="" src="Resource/images/10.png" name="1000043" onclick="goDetails(this.name)"/>
				<p>自在独行</p>
				<p>￥20</p>
			</li>
		</ul>
		<ul class="esshuji-2">
			<li>
				<img alt="" src="Resource/images/13.png" name="1000044" onclick="goDetails(this.name)"/>
				<p>数学之美</p>
				<p>￥20</p>
			</li>
			<li>
				<img alt="" src="Resource/images/14.png" name="1000002" onclick="goDetails(this.name)"/>
				<p>高等数学</p>
				<p>￥11</p>
			</li>
		</ul>
		<ul class="esshuji-3">
			<li>
				<img alt="" src="Resource/images/8.png" name="1000016" onclick="goDetails(this.name)"/>
				<p>麦田的守望者</p>
				<p>￥10</p>
			</li>
			<li>
				<img alt="" src="Resource/images/12.png" name="1000045" onclick="goDetails(this.name)"/>
				<p>我们一无所有</p>
				<p>￥22</p>
			</li>
			<li>
				<img alt="" src="Resource/images/11.png" name="1000048" onclick="goDetails(this.name)"/>
				<p>概率论</p>
				<p>￥15</p>
			</li>
		</ul>
		<ul class="esshuji-2">
			<li>
				<img style="margin-top:25px" alt="" src="Resource/images/16.png" name="1000046" onclick="goDetails(this.name)"/>
				<p>CSS权威指南</p>
				<p>￥18</p>
			</li>
			<li>
				<img style="margin-top:25px" alt="" src="Resource/images/15.png" name="1000047" onclick="goDetails(this.name)"/>
				<p>HTML5秘籍</p>
				<p>￥21</p>
			</li>
		</ul>
	</div>
</div>
<div class="index-adv">
	<img alt="" src="Resource/images/ind-adv.jpg"/>	
</div>

<table class="ind-ann">
	<tr>
		<th class="indth1">
			<div class="induser">用户名</div>
		</th>
		<th class="indth2">
			<div class="indmsg">消息</div>
		</th>
	</tr>
	<tbody id="affiche">
</table>

<footer>
<p>@版权所有：西南科技大学.swust.jjglxg1402-Darren.</p>
</footer>
</div>
</body>
</html>
<!-- <script typr="text/javascript">
function keyDown(){
	var keyCode = event.keyCode;
	if(keyCode == 13){
		login();
	}
}
document.onkeydown = keyDown;
</script> -->
