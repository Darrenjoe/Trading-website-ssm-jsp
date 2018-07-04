<!DOCTYPE HTML>
<%@page pageEncoding="UTF-8"%>
<%@include file="/Resource/component.jsp"%>
<html>
<head>
<title>商品分类</title>
<link rel="stylesheet" href="Resource/css/globe.css">
<link rel="stylesheet" href="Resource/css/merchandise.css">
<script src="<%=basePath%>Resource/js/jquery-2.0.3.min.js"></script>

<script>
	var currentPage = 1;
	var pageSize = 20;
	var pageCount;
	var list;
	var productDesc;
	var gategory;

	//搜索
	function search(value) {
		productDesc = $("#soso").val();
		gategory = value;
		if (value != null && value != "") {
			$("#arrow").attr("style", "display:inline");
			$("#child").attr("style", "display:inline");
		} else {
			$("#arrow").attr("style", "display:none");
			$("#child").attr("style", "display:none");
		}
		$("#child").html(value);

		console.log(productDesc);
		console.log(gategory);
		$
				.ajax({
					type : "post",
					url : host + 'getProductKind',
					data : {
						productDesc : productDesc,
						gategory : gategory,
						page : currentPage + "",
						pageSize : pageSize + ""
					},
					dataType : "json",
					success : function(data) {
						console.log(data);
						list = data.model.list;
						pageCount = data.model.page.pages;
						var str = "";
						$("#product").html("");
						$("#product").append("<tr>");
						for (i in list) {
							if (i % 4 == 0) {
								str += "</tr><tr><td class=td1><div class=div1><img class=img1 src=${pageContext.request.contextPath}/Resource/img/"
										+ list[i].imgUrl
										+ " name="
										+ list[i].id
										+ " onclick=goDetails(this.name)><p class=p1>"
										+ list[i].name
										+ "</p><p class=p1>"
										+ list[i].price
										+ "元"
										+ "</p></div></td>";
							} else {
								str += "<td class=td1><div class=div1><img class=img1 src=${pageContext.request.contextPath}/Resource/img/"
										+ list[i].imgUrl
										+ " name="
										+ list[i].id
										+ " onclick=goDetails(this.name)><p class=p1>"
										+ list[i].name
										+ "</p><p class=p1>"
										+ list[i].price
										+ "元"
										+ "</p></div></td>";
							}
						}
						$("#product").append(str);
						$("#product").append("</tr>");
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
	if (id == null || id == "") {
			window.location.href = "Jsp/login.jsp";
		}
		$.ajax({
			type : "post",
			url : host + 'getUserById',
			data : {
				id : id
			},
			dataType : "json",
			success : function(data) {
				console.log(data);
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

	$(document).ready(function() {
		gategory = "";
		search(gategory);
	});

	/* function search(){
		var url=host+"/getVolHourByPage.do?pageNumber="+currentPage;
		var startTime = $("#startTime").val();
		var endTime = $("#endTime").val();
		if(strStartTime != null && strStartTime !="" && strEndTime != null && strEndTime != ""){
			startTime = strStartTime;
			endTime = strEndTime;
		}
		url+="&startTime="+startTime;
		url+="&endTime="+endTime;
	    window.location.href=url;
	} */

	//查询上一页
	function previousPage() {
		$("#next").attr("disabled", false);
		var number = currentPage - 1;
		if (number > 0) {
			currentPage = number;
		} else {
			currentPage = 1;
		}
		search(gategory);
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
		search(gategory);
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
					</ul></li>
			</ul>
		</div>
	</div>
</header>
<div class="globe-top"></div>

<div class="mer-top">
	<div class="mer-t-s-l">
		<input id="soso" type="text" name="sosuo" placeholder="热门商品" />
	</div>
	<div class="mer-t-s-r">
		<button id="button" value="" onclick="search()">
			<img alt="" src="Resource/images/soso.png" />
		</button>
	</div>
</div>

<div class="profenlei">
	<div class="profenlei-1">
		<p>书籍资料</p>
		<ul>
			<li><button title="教科书" onclick="search(this.title)">教科书</button></li>
			<li><button title="四六级" onclick="search(this.title)">四六级</button></li>
			<li><button title="考研" onclick="search(this.title)">考研</button></li>
			<li><button title="文学" onclick="search(this.title)">文学</button></li>
			<li><button title="小说" onclick="search(this.title)">小说</button></li>
		</ul>
	</div>
	<div class="profenlei-2">
		<p>学习用具</p>
		<ul>
			<li><button title="小桌板" onclick="search(this.title)">小桌板</button></li>
			<li><button title="文具" onclick="search(this.title)">文具</button></li>
			<li><button title="其他" onclick="search(this.title)">其他</button></li>
		</ul>
	</div>
	<div class="profenlei-1">
		<p>生活用品</p>
		<ul>
			<li><button title="电器" onclick="search(this.title)">电器</button></li>
			<li><button title="乐器" onclick="search(this.title)">乐器</button></li>
			<li><button title="其他" onclick="search(this.title)">其他</button></li>
		</ul>
	</div>
	<div class="profenlei-2">
		<p>毕业好礼</p>
		<ul>
			<li><button title="限时上新" onclick="search(this.title)">限时上新</button></li>
			<li><button title="文具" onclick="search(this.title)">文具</button></li>
			<li><button title="其他" onclick="search(this.title)">其他</button></li>
		</ul>
	</div>
</div>

<div class="mer-main">
	<div class="mer-via">
	<button type="button" onclick="search('')">全部</button>
	<span id="arrow" style="display: none;">-></span>
	<button id="child" type="button" style="display: none;"></button>
	</div>
	<div class="ind-n-show">
	<table class="ind-n-pro">
	<tbody id="product"></tbody>
	</table>
	</div>
	<div class="mer-next">
		<button id="previous" value="上一页" onclick="previousPage()" disabled="disabled">上一页</button>
		<button id="next" value="下一页" onclick="nextPage()">下一页</button>
	</div>
</div>

<footer>
	<p>@版权所有：西南科技大学.swust.jjglxg1402-Darren.</p>
</footer>
</body>
</html>