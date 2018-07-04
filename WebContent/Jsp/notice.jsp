<!DOCTYPE HTML>
<%@page pageEncoding="UTF-8"%>
<%@include file="/Resource/component.jsp"%>
<html>
<head>
<title>公告栏</title>
<link rel="stylesheet" href="Resource/css/globe.css">
<link rel="stylesheet" href="Resource/css/notice.css">
<script src="<%=basePath%>Resource/js/jquery-2.0.3.min.js"></script>
<script>
	var currentPage = 1;
	var pageSize = 10;
	var pageCount;

	//初始化显示
	$(document).ready(function() {
		userId =
<%=(String) session.getAttribute("userId")%>
	if (userId == null || userId == "") {
			window.location.href = "Jsp/login.jsp";
		}
		//显示个人信息
		showUserInfo();
		//公告栏信息展示
		search();
	});

	//显示个人信息
	function showUserInfo() {
		$.ajax({
			type : "post",
			url : host + 'getUserById',
			data : {
				id : userId
			},
			dataType : "json",
			success : function(data) {
				var str = "";
				photoUrl = data.photoUrl;
				$("#username").html(data.userName);
				$("#userId").html(data.id);
				if(photoUrl == null||photoUrl == ""){
					$("#userAvatar").html("<img src=Resource/images/wan_heads.png>"+"</img>");
				}else{
					str +="<img src='${pageContext.request.contextPath}/Resource/img/avatars/" + data.photoUrl + "'/>";
					$("#userAvatar").html(str);
				}
			},
		});
	}
	
	//去到查看用户页面
	function goVisitUser(id) {
		window.location = "Jsp/visituser.jsp?id=" + id;
	}
	
	//公告栏信息展示
	function search() {
		$.ajax({
			type : "post",
			url : host + 'queryMoreAffiche',
			data : {
				page : currentPage + "",
				pageSize : pageSize + ""
			},
			dataType : "json",
			success : function(data) {
				//console.log(data);
				var list = data.model.list;
				pageCount = data.model.page.pages;
				var str = "";
				//console.log(list);
				for (i in list) {
					str += "<tr>" + "<td id='tduser' onclick=goVisitUser("
							+ list[i].userId + ")>" + list[i].publisher
							+ "</td>" + "<td id='tdmessge' onclick=goNotice("
							+ list[i].userId + ")>" + list[i].content
							+ "</td>" + "</tr>";
				}
				$("#affiche").html("");
				$("#affiche").append(str);
			},
		});
	}

	//发布需求
	function publish() {
		var title = $("#title").val();
		var content = $("#content").val();
		console.log(title);
		console.log(content);
		if (null == title || "" == title) {
			alert("标题不能为空！");
			return;
		}
		if (null == content || "" == content) {
			alert("内容不能为空！");
			return;
		}
		$.ajax({
			type : "post",
			url : host + 'addAffiche',
			data : {
				title : title,
				content : content,
				userId : userId
			},
			dataType : "json",
			success : function(data) {
				if (data.result == true) {
					alert("发布成功！");
					document.getElementById("bg").style.display = "none";
					document.getElementById("popbox").style.display = "none";
				} else {
					alert("发布失败！");
				}
			},
		});
	}

	//查询上一页
	function previousPage() {
		$("#next").attr("disabled", false);
		var number = currentPage - 1;
		if (number > 0) {
			currentPage = number;
		} else {
			currentPage = 1;
		}
		search();
		if (number == 1 || number < 0) {
			$("#previous").attr("disabled", true);
		}
	}

	//查询下一页
	function nextPage() {
		$("#previous").attr("disabled", false);
		if (currentPage == pageCount) {
			return;
		}
		var number = parseInt(currentPage) + 1;
		currentPage = number;
		if (number == pageCount || number > pageCount) {
			currentPage = pageCount;
			$("#next").attr("disabled", true);
		}
		search();
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
	
	//搜索公告
	function searchAffiche() {
		var content = $("#soso").val();
		$.ajax({
			type : "post",
			url : host + 'getAfficheByContent',
			data : {
				content : content
			},
			dataType : "json",
			success : function(data) {
				var list = data.result;
				var str = "";
				$("#affiche").html("");
				for (i in list) {
					str += "<tr>" + "<td id='tduser' onclick=goVisitUser("
							+ list[i].userId + ")>" + list[i].publisher
							+ "</td>" + "<td id='tdmessge' onclick=goNotice("
							+ list[i].userId + ")>" + list[i].content
							+ "</td>" + "</tr>";
				}
				$("#affiche").append(str);
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

	function displaySubMenu(li) {
		var subMenu = li.getElementsByTagName("ul")[0];
		subMenu.style.display = "block";
	}
	function hideSubMenu(li) {
		var subMenu = li.getElementsByTagName("ul")[0];
		subMenu.style.display = "none";
	}
	function pupopen() {
		document.getElementById("bg").style.display = "block";
		document.getElementById("popbox").style.display = "block";
	}
	function pupclose() {
		document.getElementById("bg").style.display = "none";
		document.getElementById("popbox").style.display = "none";
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

<div class="not-top">
	<div class="not-t-box">
		<div id="userAvatar"></div>
		<div class="n-t-b-user">
			<div>
				<strong>用户名</strong>
				<p id="username"></p>
			</div>
			<div>
				<strong>ID：</strong>
				<p id="userId"></p>
			</div>
		</div>
		<div class="n-t-b-bot">
			<button id="preout" onclick="pupopen()" value="发布需求">发布需求</button>
		</div>
	</div>
</div>
<div class="mer-top">
	<div class="mer-t-s-l">
		<input id="soso" type="text" name="sosuo" placeholder="字段查询" />
	</div>
	<div class="mer-t-s-r">
		<button id="button" value="" onclick="searchAffiche()">
			<img alt="" src="Resource/images/soso.png" />
		</button>
	</div>
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
<div class="not-next">
	<button id="previous" value="上一页" onclick="previousPage()" disabled="disabled">上一页</button>
	<button id="next" value="下一页" onclick="nextPage()">下一页</button>
</div>
<div id="bg"></div>
<form action="" method="post" id="popbox">
	<h1>发布需求</h1>
	<label> <span>标题</span> <input id="title" type="text" value=""
		placeholder="标题" />
	</label>
	<h2>内容</h2>
	<textarea id="content" placeholder="请输入内容"></textarea>
	<button onclick="pupclose()">取消</button>
	<button onclick="publish()">发布需求</button>
</form>

<footer>
	<p>@版权所有：西南科技大学.swust.jjglxg1402-Darren.</p>
</footer>
</body>
</html>