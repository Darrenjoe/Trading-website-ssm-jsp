<!DOCTYPE HTML>
<%@page pageEncoding="UTF-8"%>
<%@include file="/Resource/component.jsp"%>
<html>
<head>
<title>管理员中心</title>
<link rel="stylesheet" href="Resource/css/globe.css">
<link rel="stylesheet" href="Resource/css/sellerinfo.css">
<link href="Resource/css/bootstrap.min.css" rel="stylesheet" />
<script src="<%=basePath%>Resource/js/jquery-2.0.3.min.js"></script>

<script>
	var id;
	var pwd;
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
		document.getElementById("man-info-out").style.display = "block";
		document.getElementById("man-product-out").style.display = "none";
		document.getElementById("man-notice-out").style.display = "none";
	}
	function open2() {
		document.getElementById("man-info-out").style.display = "none";
		document.getElementById("man-product-out").style.display = "block";
		document.getElementById("man-notice-out").style.display = "none";
		getAllProduct();
	}
	function open3() {
		document.getElementById("man-info-out").style.display = "none";
		document.getElementById("man-product-out").style.display = "none";
		document.getElementById("man-notice-out").style.display = "block";
		getAllAffiche();
	}
	//个人中心的弹出层
	function xiugaiopen() {
		document.getElementById("bg").style.display = "block";
		document.getElementById("man-i-modify").style.display = "block";
	}
	function changeopen() {
		document.getElementById("bg").style.display = "block";
		document.getElementById("man-i-modifypassword").style.display = "block";
	}
	function close() {
		document.getElementById("bg").style.display = "none";
		document.getElementById("man-i-modify").style.display = "none";
		document.getElementById("man-i-modifypassword").style.display = "none";
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

	//初始化
	$(document).ready(function() {
		id =
<%=(String) session.getAttribute("userId")%>
	//个人信息
		showUserInfo();
		getAllAffiche();
	});

	//修改密码
	function updatePwd() {
		var oldPassword = $("#man-i-oldpassword").val();
		var newPassword = $("#man-i-newpassword").val();
		var password = $("#man-i-password").val();
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
		var userName = $("#m-i-username").val();
		var telephone = $("#m-i-telenum").val();
		var signature = $("#man-i-signed").val();
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
				college : "",
				telephone : telephone,
				wechat : "",
				qqnum : "",
				gender : "",
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
				photoUrl = data.photoUrl;
				$("#username").html(data.userName);
				$("#signature").html(data.signature);
				$("#signature").html(data.signature);
				if(photoUrl == null||photoUrl == ""){
					$("#userAvatar").html("<img src=Resource/images/wan_heads.png>"+"</img>");
				}else{
					str +="<img src='${pageContext.request.contextPath}/Resource/img/avatars/" + data.photoUrl + "'/>";
					$("#userAvatar").html(str);
				}
				$("#user-p-user").html(data.userName);
				$("#user-p-userid").html(data.id);
				$("#user-p-telephone").html(data.telephone);
				$("#user-p-signature").html(data.signature);
			},
		});
	}

	//商品管理
	function getAllProduct() {
		$
				.ajax({
					type : "post",
					url : host + 'getAllProduct',
					dataType : "json",
					success : function(data) {
						var list = data.result;
						var str = "";
						$("#product").html("");
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
						$("#product").append(str);
					},
				});
	}

	function goDetails(value) {
		window.location = "Jsp/details.jsp?productId=" + value;
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
					open2();
				} else {
					alert("删除失败");
				}
			},
		});
	}

	//显示我的公告
	function getAllAffiche() {
		$.ajax({
			type : "post",
			url : host + 'getAllAffiche',
			dataType : "json",
			success : function(data) {
				var list = data.result;
				var str = "";
				$("#affiche").html("");
				for (i in list) {
					str += "<tr>" + "<td>" + list[i].content + "</td>" + "<td>"
							+ list[i].publisher + "</td>" + "<td>"
							+ list[i].createTime + "</td>"
							+ "<td><button type=button onclick=delMyAffiche("
							+ list[i].id + ")>删除</button></td>" + "</tr>";
				}
				$("#affiche").append(str);
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
					open3();
				} else {
					alert("删除失败");
				}
			},
		});
	}

	//搜索商品
	function searchProduct() {
		var productDesc = $("#man-p-soso").val();
		$
				.ajax({
					type : "post",
					url : host + 'getProductByProductDesc',
					data : {
						productDesc : productDesc
					},
					dataType : "json",
					success : function(data) {
						var list = data.result;
						var str = "";
						$("#product").html("");
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
						$("#product").append(str);
					},
				});
	}

	//搜索公告
	function searchAffiche() {
		var content = $("#man-notice-soso").val();
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
					str += "<tr>" + "<td>" + list[i].content + "</td>" + "<td>"
							+ list[i].publisher + "</td>" + "<td>"
							+ list[i].createTime + "</td>"
							+ "<td><button type=button onclick=delMyAffiche("
							+ list[i].id + ")>删除</button></td>" + "</tr>";
				}
				$("#affiche").append(str);
			},
		});
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

<div id="bg"></div>
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
				<h1><a href="javascript:;" onclick="open2()">商品管理</a></h1>
			</li>
			<li>
				<h1><a href="javascript:;" onclick="open3()">我的公告</a></h1>
			</li>
		</ul>
 		</div>
	<div class="sel-iframe">
		<div id="man-info-out" style="z-index:60">
			<div class="man-info">
				<div><strong>用户名：</strong><p id="user-p-user"></p></div>
				<div><strong>ID：</strong><p id="user-p-userid"></p></div>
				<div><strong>联系电话：</strong><p id="user-p-telephone"></p></div>
				<div><strong>个性签名：</strong><p id="user-p-signature"></p></div>
			</div>
			<div class="man-i-but">
				<button id="man-i-xiugai" onclick="xiugaiopen()">编辑</button>
				<button id="man-i-change" onclick="changeopen()">修改密码</button>
			</div>
			<form method="post" id="man-i-modify">
				<label>
					<span>用&nbsp;户&nbsp;名</span>
					<input id="m-i-username" type="text" value="" placeholder="用户名"/> 
				</label>
				<label>
					<span>联系电话</span>
					<input id="m-i-telenum" type="text" value="" placeholder="要个联系方式"/> 
				</label>
				<h2>个性签名</h2>
				<textarea id="man-i-signed" placeholder="请输入内容"></textarea>
				<button onclick="close()">取消</button>
				<button id="man-i-save" onclick="updateUser()">保存</button>
			</form>
			<form method="post" id="man-i-modifypassword">
				<label>
					<span>旧&nbsp;密&nbsp;码</span>
					<input id="man-i-oldpassword" type="text" value="" placeholder="旧密码"/> 
				</label>
				<label>
					<span>新&nbsp;密&nbsp;码</span>
					<input id="man-i-newpassword" type="text" value="" placeholder="新密码"/> 
				</label>
				<label>
					<span>确认密码</span>
					<input id="man-i-password" type="text" value="" placeholder="确认密码"/> 
				</label>
				<button onclick="close()">取消</button>
				<button id="man-i-savepassword" onclick="updatePwd()">保存</button>
			</form>
		</div>
		<div id="man-product-out" style="display:none;z-index:150">
			<div class="man-p-mer-top">
				<div class="man-p-mer-t-s-l">
					<input id="man-p-soso" type="text" name="sosuo" placeholder="热门商品" />
				</div>
				<div class="man-p-mer-t-s-r">
					<button id="man-p-button" value="" onclick="searchProduct()">
						<img alt="" src="Resource/images/soso.png"/>
					</button>
				</div>
			</div>
			<div class="man-p-manproduct">
				<ul>
					<li style="width:96px">商品图片</li>
					<li style="width:412px">商品名称</li>
					<li style="width:134px">价格</li>
					<li style="width:127px">操作</li>
				</ul>
				<div style="overflow: auto;width:790px;height: 480px;">
					<table class="table table-hover text-center">
						<tbody id="product">
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div id="man-notice-out" style="display:none;z-index:160">
			<div class="man-notice-mer-top">
				<div class="man-notice-mer-t-so">
					<div class="man-notice-mer-t-s-l">
						<input id="man-notice-soso" type="text" name="sosuo" placeholder="查询字段" />
					</div>
					<div class="man-notice-mer-t-s-r">
						<button id="man-notice-button" value="" onclick="searchAffiche()">
							<img alt="" src="Resource/images/soso.png"/>
						</button>
					</div>
				</div>
			</div>
			<div class="man-notice-mannotice">
				<ul>
					<li style="width:410px">内容</li>
					<li style="width:80px">发布人</li>
					<li style="width:206px">时间</li>
					<li style="width:54px">操作</li>
				</ul>
				<div style="overflow: auto;width:790px;height: 480px;">
					<table class="table table-hover text-center">
						<tbody id="affiche">
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
	
	
<footer>
<p>@版权所有：西南科技大学.swust.jjglxg1402-Darren.</p>
</footer>
</body>
</html>