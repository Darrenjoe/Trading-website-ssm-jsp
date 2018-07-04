<!DOCTYPE HTML>
<%@page pageEncoding="UTF-8"%>
<%@include file="/Resource/component.jsp"%>
<%@page import= "com.xj.util.*"%>
<html>
<head>
<title>个人中心</title>
<link rel="stylesheet" href="Resource/css/globe.css">
<link rel="stylesheet" href="Resource/css/sellerinfo.css">
<link href="Resource/css/bootstrap.min.css" rel="stylesheet" />
<script src="<%=basePath%>Resource/js/jquery-2.0.3.min.js"></script>

<script>
	var id;
	var pwd;
	var userName;
	var college;
	var telephone;
	var wechat;
	var qqNumber;
	var gender;
	var signature;
	var photoUrl;
	//控制个人中心的下拉菜单
	function displaySubMenu(li) {
		var subMenu = li.getElementsByTagName("ul")[0];
		subMenu.style.display = "block";
	}
	function hideSubMenu(li) {
		var subMenu = li.getElementsByTagName("ul")[0];
		subMenu.style.display = "none";
	}
	
	//更头像选择
	function change(){
			$("#xialakuang").slideToggle("slow");
	}
	
	//选择div的时候弹出来
	function open1() {
		document.getElementById("user-per-info-out").style.display = "block";
		document.getElementById("user-ord-info-out").style.display = "none";
		document.getElementById("user-col-info-out").style.display = "none";
		document.getElementById("user-ord-buyer-out").style.display = "none";
		document.getElementById("user-myproduct-out").style.display = "none";
		document.getElementById("user-mynotice-out").style.display = "none";
	}
	function open2() {
		document.getElementById("user-per-info-out").style.display = "none";
		document.getElementById("user-ord-info-out").style.display = "block";
		document.getElementById("user-col-info-out").style.display = "none";
		document.getElementById("user-ord-buyer-out").style.display = "none";
		document.getElementById("user-myproduct-out").style.display = "none";
		document.getElementById("user-mynotice-out").style.display = "none";
		//我的订单
		showMyOrder();
	}
	function open3() {
		document.getElementById("user-per-info-out").style.display = "none";
		document.getElementById("user-ord-info-out").style.display = "none";
		document.getElementById("user-col-info-out").style.display = "block";
		document.getElementById("user-ord-buyer-out").style.display = "none";
		document.getElementById("user-myproduct-out").style.display = "none";
		document.getElementById("user-mynotice-out").style.display = "none";
		//我的收藏
		showMyCollect(id);
	}
	function open4() {
		document.getElementById("user-per-info-out").style.display = "none";
		document.getElementById("user-ord-info-out").style.display = "none";
		document.getElementById("user-col-info-out").style.display = "none";
		document.getElementById("user-ord-buyer-out").style.display = "block";
		document.getElementById("user-myproduct-out").style.display = "none";
		document.getElementById("user-mynotice-out").style.display = "none";
		//买家订单
		showBuyerOrder();
	}
	function open5() {
		document.getElementById("user-per-info-out").style.display = "none";
		document.getElementById("user-ord-info-out").style.display = "none";
		document.getElementById("user-col-info-out").style.display = "none";
		document.getElementById("user-ord-buyer-out").style.display = "none";
		document.getElementById("user-myproduct-out").style.display = "block";
		document.getElementById("user-mynotice-out").style.display = "none";
		//我的商品
		showMyProduct();
	}
	function open6() {
		document.getElementById("user-per-info-out").style.display = "none";
		document.getElementById("user-ord-info-out").style.display = "none";
		document.getElementById("user-col-info-out").style.display = "none";
		document.getElementById("user-ord-buyer-out").style.display = "none";
		document.getElementById("user-myproduct-out").style.display = "none";
		document.getElementById("user-mynotice-out").style.display = "block";
		//我的需求
		showMyAffiche();
	}
	//个人中心的弹出层
	function userpxiugaiopen() {
		document.getElementById("bg").style.display = "block";
		document.getElementById("user-p-modify").style.display = "block";
	}
	function userpchangeopen() {
		document.getElementById("bg").style.display = "block";
		document.getElementById("user-p-modifypassword").style.display = "block";
	}
	function userpclose() {
		document.getElementById("bg").style.display = "none";
		document.getElementById("user-p-modify").style.display = "none";
		document.getElementById("user-p-modifypassword").style.display = "none";
	}
	function pupopen() {
		document.getElementById("bg").style.display = "block";
		document.getElementById("popbox").style.display = "block";
	}
	function pupclose() {
		document.getElementById("bg").style.display = "none";
		document.getElementById("popbox").style.display = "none";
	}

	//去到个人中心
	function goPerson() {
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

	$(document).ready(function() {
		id =
<%=(String) session.getAttribute("userId")%>
	//个人信息
		showUserInfo();
	});
	//显示个人信息
	function showUserInfo() {
		$.ajax({
			type : "post",
			url : host + 'getUserById',
			data : {
				id : id
			},
			dataType : "json",
			success : function(data) {
				var str = "";
				pwd = data.password;
				userName = data.userName;
				college = data.college;
				telephone = data.telephone;
				wechat = data.wechat;
				qqNumber = data.qqNumber;
				gender = data.gender;
				signature = data.signature;
				photoUrl = data.photoUrl;
				console.log(photoUrl);
				$("#username").html(data.userName);
				$("#signature").html(data.signature);
				if(photoUrl == null||photoUrl == ""){
					$("#userAvatar").html("<img src=Resource/images/wan_heads.png>"+"</img>");
				}else{
					str +="<img src='${pageContext.request.contextPath}/Resource/img/avatars/"+data.photoUrl + "'/>";
/* 					str +="<img src=Resource/img/avatars/" + data.photoUrl + "'/>"; */
					$("#userAvatar").html(str);
				}
				$("#user-p-user").html(data.userName);
				$("#user-p-userid").html(data.id);
				$("#user-p-name").html(data.name);
				$("#user-p-sex").html(data.gender);
				$("#user-p-college").html(data.college);
				$("#user-p-telephone").html(data.telephone);
				$("#user-p-wechat").html(data.wechat);
				$("#user-p-qqnumber").html(data.qqNumber);
				$("#user-p-signature").html(data.signature);

				$("#user-p-username").html(data.userName);
				$("#user-p-collge").html(data.college);
				$("#user-p-telenum").html(data.telephone);
				$("#user-p-wechatnum").html(data.wechat);
				$("#user-p-qqnum").html(data.qqNumber);
				$("#user-p-signed").html(data.signature);
			},
		});
	}
	
	//显示个人订单
	function showMyOrder() {
		$.ajax({
			type : "post",
			url : host + 'getOrdersByUserId',
			data : {
				userId : id
			},
			dataType : "json",
			success : function(data) {
				var list = data.result;
				console.log(data.orderSure);
				var str = "";
				for (i in list) {
					if (list[i].orderSure == 1) {
						str += "<tr>" + "<td onclick=goOrderShow(" + list[i].id
								+ ")>" + list[i].orderNum + "</td>" + "<td>"
								+ list[i].productName + "</td>" + "<td>"
								+ list[i].sellerId + "</td>" + "<td>已完成</td>" + "</tr>";
						$("#orders").html("");
						$("#orders").append(str);
					} else if (list[i].orderSure == 0) {
						str += "<tr>" + "<td onclick=goOrderShow(" + list[i].id
								+ ")>" + list[i].orderNum + "</td>" + "<td>"
								+ list[i].productName + "</td>" + "<td>"
								+ list[i].sellerId + "</td>" + "<td><button type=button onclick=sureMyOrder("
								+ list[i].id + ")>确认完成</button></td>" + "</tr>";
						$("#orders").html("");
						$("#orders").append(str);
					}
				}
			},
		});
	}

	//去到订单详情页面
	function goOrderShow(id) {
		window.location = "Jsp/ordershow.jsp?id=" + id;
	}

	//显示我的收藏
	function showMyCollect(id) {
				$.ajax({
					type : "post",
					url : host + 'showMyCollect',
					data : {
						id : id
					},
					dataType : "json",
					success : function(data) {
						var list = data.result;
						var str = "";
						$("#myCollect").html("");
						for (i in list) {
							str += "<tr>"
									+ "<td><img src=${pageContext.request.contextPath}/Resource/img/"
									+ list[i].imgUrl
									+ " name="
									+ list[i].id
									+ " onclick=goDetails(this.name) width=30px;/></td>"
									+ "<td>"
									+ list[i].name
									+ "</td>"
									+ "<td>"
									+ list[i].price
									+ "</td>"
									+ "<td><button type=button onclick=delMyCollect("
									+ list[i].id + ")>删除</button></td>"
									+ "</tr>";
						}
						$("#myCollect").append(str);
					},
				});
	}

	//显示买家订单
	function showBuyerOrder() {
		$.ajax({
			type : "post",
			url : host + 'getOrdersBySellerId',
			data : {
				sellerId : id
			},
			dataType : "json",
			success : function(data) {
				var list = data.result;
				var str = "";
				for (i in list) {
					var showOrderSure;
					if (list[i].orderSure == 1) {
						showOrderSure = "已完成";
					} else {
						showOrderSure = "未完成";
					}
					str += "<tr>" + "<td onclick=goOrderShow(" + list[i].id
						+ ")>" + list[i].orderNum + "</td>" + "<td>"
						+ list[i].productName + "</td>" + "<td>"
						+ list[i].userId + "</td>" + "<td>"
						+ showOrderSure + "</td>" + "</tr>";
					$("#sellerOrder").html("");
					$("#sellerOrder").append(str);
				}
			},
		});
	}
	
	//确认完成订单
	function sureMyOrder(id){
		var r=confirm("订单是否交易成功？");
		if(r == true){
			$.ajax({
				type : "post",
				url : host + 'sureMyOrder',
				data : {
					id : id
				},
				dataType : "json",
				success : function(data) {
					if (data) {
						alert("订单完成");
						open2();
					} else {
						alert("出了些问题！");
					}
				},
			});
		}
	}
	
	//显示我的商品
	function showMyProduct() {
				$.ajax({
					type : "post",
					url : host + 'showMyProduct',
					data : {
						id : id
					},
					dataType : "json",
					success : function(data) {
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
									+ "<td>"
									+ list[i].name
									+ "</td>"
									+ "<td>"
									+ list[i].price
									+ "</td>"
									+ "<td><button type=button onclick=delMyProduct("
									+ list[i].id + ")>删除</button></td>"
									+ "</tr>";
						}
						$("#myProduct").append(str);
					},
				});
	}

	//显示我的需求
	function showMyAffiche() {
		$.ajax({
			type : "post",
			url : host + 'showMyAffiche',
			data : {
				id : id
			},
			dataType : "json",
			success : function(data) {
				var list = data.result;
				var str = "";
				$("#myAffiche").html("");
				for (i in list) {
					str += "<tr>" + "<td>" + list[i].content + "</td>" + "<td>"
							+ list[i].createTime + "</td>"
							+ "<td><button type=button onclick=delMyAffiche("
							+ list[i].id + ")>删除</button></td>" + "</tr>";
				}
				$("#myAffiche").append(str);
			},
		});
	}

	//删除我的需求
	function delMyAffiche(id) {
		$.ajax({
			type : "post",
			url : host + 'delMyAffiche',
			data : {
				id : id
			},
			dataType : "json",
			success : function(data) {
				if (data.result) {
					alert("删除成功");
					open6();
				} else {
					alert("删除失败");
				}
			},
		});
	}

	//删除我的收藏
	function delMyCollect(id) {
		$.ajax({
			type : "post",
			url : host + 'deleteMyCollect',
			data : {
				id : id
			},
			dataType : "json",
			success : function(data) {
				if (data.result) {
					alert("删除成功");
					open3();
				} else {
					alert("删除失败");
				}
			},
		});
	}

	//删除我的商品
	function delMyProduct(id) {
		$.ajax({
			type : "post",
			url : host + 'deleteMyProduct',
			data : {
				id : id
			},
			dataType : "json",
			success : function(data) {
				if (data.result) {
					alert("删除成功");
					open5();
				} else {
					alert("删除失败");
				}
			},
		});
	}

	//添加商品
	function addProduct() {
		var proname = $("#proname").val();
		var proprice = $("#proprice").val();
		var proNum = $("#proNum").val();
		var proType = $("#proType").val();
		var prophoto = $('#prophoto').val();
		var procontent = $("#procontent").val();
		if(prophoto == null|| prophoto == ""){
			alert("请选择文件");
			return;
		}
		var form = new FormData(document.getElementById("popbox"));
		$.ajax({
			type : "post",
			url : host + 'savaProduct',
			data : {
				name : proname,
				price : proprice,
				gategory : proType,
				inventory : proNum,
				imgUrl : prophoto,
				productDesc : procontent,
				userId : id
			},
			dataType : "json",
			success : function(data) {
				console.log(data);
				if (data.result) {
					alert("添加商品成功");
					pupclose();
					open5();
					showMyProduct();
				} else {
					alert("添加商品失败");
				}
			},
		});
		$.ajax({  
	        url : host + 'addProduct',  
	        data : form ,
	        type : 'post',  
	        processData:false,  
	        contentType:false,  
	        success : function(data){  
	        },  
	        error : function(data){
	        }  
	    });
	}
	
	//更新头像  （这是加的）
	function upDateUrl(){  
		var photourl = $("#changeAvatar").val();
		if(photourl == null|| photourl == ""){
			alert("请选择文件");
			return;
		}
	    var form = new FormData(document.getElementById("xialakuang"));
	     $.ajax({
			type : "post",
			url : host + "save2Data",
			data : {
				id : id ,
				photourl : photourl
			},
			dataType : "json",
			success : function(data) {
				console.log(data);
				 if (data) {
					alert("修改成功");
				} else {
					alert("修改失败");
				}
			}
		});
	    $.ajax({  
	        url : host + 'updatePhoto',  
	        data : form ,
	        type : 'post',  
	        processData:false,  
	        contentType:false,  
	        success : function(data){  
	        },  
	        error : function(data){
	        }  
	    });  
	    
	}  
	

	//修改个人信息
	function updateUser() {
		var userName = $("#user-p-username").val();
		var college = $("#user-p-collge").val();
		var telephone = $("#user-p-telenum").val();
		var wechat = $("#user-p-wechatnum").val();
		var qqnum = $("#user-p-qqnum").val();
		var gender = $("input[name='sex']:checked").val();
		var signature = $("#user-p-signed").val();
		if (userName == null || userName == "") {
			alert("请输入用户名");
			return;
		}
		$.ajax({
			type : "post",
			url : host + 'updateUser',
			data : {
				id : id,
				userName : userName,
				college : college,
				telephone : telephone,
				wechat : wechat,
				qqnum : qqnum,
				gender : gender,
				signature : signature
			},
			dataType : "json",
			success : function(data) {
				console.log(data);
				if (data) {
					alert("修改成功");
				} else {
					alert("修改失败");
				}
			},
		});
	}

	//修改密码
	function updatePwd() {
		var oldPassword = $("#user-p-oldpassword").val();
		var newPassword = $("#user-p-newpassword").val();
		var password = $("#user-p-password").val();
		if (pwd != oldPassword) {
			alert("密码错误！");
			return;
		}
		if (newPassword == null || newPassword == "") {
			alert("请输入新密码");
			return;
		}
		if (newPassword != password) {
			alert("请重新确认密码");
		} else {
			$.ajax({
				type : "post",
				url : host + 'updatePwd',
				data : {
					id : id,
					password : password
				},
				dataType : "json",
				success : function(data) {
					console.log(data);
					if (data) {
						alert("修改成功");
					} else {
						alert("修改失败");
					}
				},
			});
		}
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
					<a href="#">可爱的用户
						<img alt="" src="Resource/images/wan_heads.png"/></a>
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
			<div><strong>用 户 名:</strong><p id="username"></p></div>
			<div><strong>个性签名:</strong><p id="signature"></p></div>
		</div>
		<div class="changehead">
			<button id="uplaodurl" onclick="change()">更新头像</button>
		</div>
		<form id="xialakuang" method="post" enctype="multipart/form-data">
			<input id="changeAvatar" name="file" type="file" />
			<button onclick="upDateUrl()">确定</button>
		</form>
	</div>
</div>
<div class="sel-main">
	<div class="sel-left-nav">
		<ul>
			<li>
				<h1><a href="javascript:;" onclick="open1()">个人信息</a></h1>
			</li>
			<li>
				<h1><a href="javascript:;" onclick="open2()">我的订单</a></h1>
			</li>
			<li>
				<h1><a href="javascript:;" onclick="open3()">我的收藏</a></h1>
			</li>
			<li>
				<h1><a href="javascript:;" onclick="open4()">买家订单</a></h1>
			</li>
			<li>
				<h1><a href="javascript:;" onclick="open5()">我的商品</a></h1>
			</li>
			<li>
				<h1><a href="javascript:;" onclick="open6()">我的需求</a></h1>
			</li>
		</ul>
 		</div>
	<div class="sel-iframe">
		<div id="user-per-info-out" style="z-index:66;">
			<div class="user-p-per-info">
				<div><strong>用户名：</strong><p id="user-p-user"></p></div>
				<div><strong>ID：</strong><p id="user-p-userid"></p></div>
				<div><strong>姓名：</strong><p id="user-p-name"></p>
				<strong>性别：</strong><p id="user-p-sex"></p>
				<strong>学院：</strong><p id="user-p-college"></p></div>
				<div><strong>联系电话：</strong><p id="user-p-telephone"></p></div>
				<div><strong>微信：</strong><p id="user-p-wechat"></p></div>
				<div><strong>Q Q：</strong><p id="user-p-qqnumber"></p></div>
				<div><strong>个性签名：</strong><p id="user-p-signature"></p></div>
			</div>
			 <div class="user-p-per-i-but">
				<button id="user-p-xiugai" onclick="userpxiugaiopen()" value="">编辑</button>
				<button id="user-p-change" onclick="userpchangeopen()" value="">修改密码</button>
			</div>
			<form method="post" id="user-p-modify">
				<label>
					<span>用&nbsp;户&nbsp;名</span>
					<input id="user-p-username" type="text" value="" placeholder="用户名"/> 
				</label>
				<label>
					<span>性&nbsp;&nbsp;&nbsp;&nbsp;别</span>
					<input type="radio" name="sex" value="男" checked>男
					<input type="radio" name="sex" value="女">女
				</label>
				<label>
					<span>学&nbsp;&nbsp;&nbsp;&nbsp;院</span>
					<input id="user-p-collge" type="text" value="" placeholder="所在学院"/> 
				</label>
				<label>
					<span>联系电话</span>
					<input id="user-p-telenum" type="text" value="" placeholder="要个联系方式"/> 
				</label>
				<label>
					<span>微&nbsp;&nbsp;&nbsp;&nbsp;信</span>
					<input id="user-p-wechatnum" type="text" value="" placeholder="微信也一起吧"/>
				</label>
				<label>
					<span>Q&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Q</span>
					<input id="user-p-qqnum" type="text" value="" placeholder="空间给你点赞"/> 
				</label>
				<h2>个性签名</h2>
				<textarea id="user-p-signed" placeholder="请输入内容"></textarea>
				<button onclick="userpclose()">取消</button>
				<button id="user-p-save" onclick="updateUser()">保存</button>
			</form>
			<form method="post" id="user-p-modifypassword">
				<label>
				<span>旧&nbsp;密&nbsp;码</span>
				<input id="user-p-oldpassword" type="password" value="" placeholder="旧密码"/> 
				</label>
				<label>
				<span>新&nbsp;密&nbsp;码</span>
				<input id="user-p-newpassword" type="password" value="" placeholder="新密码"/> 
				</label>
				<label>
				<span>确认密码</span>
				<input id="user-p-password" type="password" value="" placeholder="确认密码"/> 
				</label>
				<button onclick="userpclose()">取消</button>
				<button id="user-p-savepassword" onclick="updatePwd()">保存</button>
			</form>
		</div>
		<div id="user-ord-info-out" style="display:none; z-index:70;">
			<div class="user-o-ord-info">
				<ul>
					<li style="width:200px">订单号</li>
					<li style="width:234px">商品名称</li>
					<li style="width:228px">卖家ID</li>
					<li style="width:110px">状态</li>
				</ul>
				<div style="overflow: auto;width:800px;height: 480px;">
					<table class="table table-hover text-center">
						<tbody id="orders">
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div id="user-col-info-out" style="display:none; z-index:75;">
			<div class="user-c-col-info">
				<ul>
					<li style="width:94px">商品图片</li>
					<li style="width:363px">商品名称</li>
					<li style="width:82px">价格</li>
					<li style="width:230px">操作</li>
				</ul>
				<div style="overflow: auto;width:800px;height: 480px;">
					<table class="table table-hover text-center">
						<tbody id="myCollect">
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div id="user-ord-buyer-out" style="display:none; z-index:80;">
			<div class="user-buy-ord-buyer">
				<ul>
					<li style="width:208px">订单号</li>
					<li style="width:235px">商品名称</li>
					<li style="width:229px">买家ID</li>
					<li style="width:100px">状态</li>
				</ul>
				<div style="overflow: auto;width:800px;height: 480px;">
					<table class="table table-hover text-center">
						<tbody id="sellerOrder">
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div id="user-myproduct-out" style="display:none; z-index:85;">
			<button id="newproduct" onclick="pupopen()" value="添加商品">添加商品</button>
			<div class="myproduct">
				<ul>
					<li style="width:96px">商品图片</li>
					<li style="width:412px">商品名称</li>
					<li style="width:109px">价格</li>
					<li style="width:140px">操作</li>
				</ul>
				<div style="overflow: auto;width:800px;height: 480px;">
					<table class="table table-hover text-center">
						<tbody id="myProduct">
						</tbody>
					</table>
				</div>
			</div>
			<form id="popbox" method="post" enctype="multipart/form-data">
				<h1>添加商品</h1>
				<label>
					<span>商品名称</span>
					<input id="proname" type="text" value="" placeholder="商品名称"/> 
				</label>
				<label>
					<span>商品价格</span>
					<input id="proprice" type="text" value="" placeholder="商品价格"/> 
				</label>
				<label>
					<span>商品数量</span>
					<select id="proNum" name="proNum" size="value">
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
						<option value="6">6</option></select>
				</label>
				<label>
					<span>商品类型</span>
					<select id="proType" name="proType" size="value">
						<option value="教科书">教科书</option>
						<option value="四六级">四六级</option>
						<option value="考研">考研</option>
						<option value="文学">文学</option>
						<option value="小说">小说</option>
						<option value="小桌板">小桌板</option>
						<option value="文具">文具</option>
						<option value="电器">电器</option>
						<option value="乐器">乐器</option>
						<option value=其他>其他</option></select>
				</label>
				<label>
					<span>商品图片</span>
					<input id="prophoto" type="file" name="file"/>
				</label>
				<h2>商品简介</h2>
				<textarea id="procontent" placeholder="请输入内容"></textarea>
				<button onclick="pupclose()">取消</button>
				<input type="button" id="suremake" onclick="addProduct()" value="上架"/>
			</form>
		</div>
		<div id="user-mynotice-out" style="display:none; z-index:90;">
			<div class="mynotice">
				<ul>
					<li style="width:456px">内容</li>
					<li style="width:180px">时间</li>
					<li style="width:135px">操作</li>
				</ul>
				<div style="overflow: auto;width:800px;height: 480px;">
					<table class="table table-hover text-center">
						<tbody id="myAffiche">
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
<div id="bg"></div>
	
<footer>
<p>@版权所有：西南科技大学.swust.jjglxg1402-Darren.</p>
</footer>
</body>
</html>