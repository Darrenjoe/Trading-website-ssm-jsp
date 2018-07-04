<!DOCTYPE HTML>
<%@page pageEncoding="UTF-8"%>
<%@include file="/Resource/component.jsp"%>
<html>
<head>
<title>登录-西科交易</title>
<link rel="stylesheet" href="Resource/css/login.css">
<link rel="stylesheet" href="Resource/css/loginout.css">
<link rel="stylesheet" href="Resource/css/sweet-alert.css">
<script type="text/javascript" src="Resource/js/jquery-2.0.3.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="Resource/js/sweet-alert.min.js" charset="UTF-8"></script>

<script type="text/javascript">
	//登陆系统
	function login() {
		var username = $("#name").val();
		var password = $("#password").val();
		if (username == "" || username == undefined) {
			alert("用户名不能为空");
			$("#name").val("");
			$("#password").val("");
			return;
		}
		if (password == "" || password == undefined) {
			alert("密码不能为空");
			$("#password").val("");
			return;
		}
		$.ajax({
			type : "post",
			url : host + 'loginsubmit',
			data : {
				username : username,
				password : password
			},
			dataType : "json",
			success : function(data) {
				if (data.success == 'true') {
					window.location.href = "index.jsp?userId=" + data.id;
				} else {
					if (data.message == 1) {
						alert("密码错误！");
						$("#name").val("");
						$("#password").val("");
					} else {
						alert("用户不存在！");
						$("#name").val("");
						$("#password").val("");
					}
				}
			},
			beforeSend : function() {
			},
			error : function() {
				alert("请求异常");
			}
		});
	}

	//注册
	function register() {
		var username = $("#setname").val();
		var pwd = $("#setpassword").val();
		var pwdAgain = $("#password-m").val();
		var telephone = $("#telephone").val();
		var wechat = $("#wechat").val();
		var qqnum = $("#qqnum").val();
		if (isNull(username, "用户名") == "yes") {
			return;
		}
		if (isNull(pwd, "密码") == "yes") {
			return;
		}
		if (isNull(pwdAgain, "确认密码") == "yes") {
			return;
		}
		if (isNull(telephone, "联系电话") == "yes") {
			return;
		}
		if (isNull(wechat, "微信") == "yes") {
			return;
		}
		if (isNull(qqnum, "QQ") == "yes") {
			return;
		}
		if (pwd != pwdAgain) {
			alert("请确认密码");
			return;
		}
		var re = /^1\d{10}$/;
		if (!re.test(telephone)) {
			alert("手机号码格式不正确，请重新输入!");
			return;
		}
			$.ajax({
				type : "post",
				url : host + 'addOrUpdateUser',
				data : {
					username : username,
					pwd : pwd,
					telephone : telephone,
					wechat : wechat,
					qqnum : qqnum
				},
				dataType : "json",
				success : function(data) {
					if (data.result == true) {
						sweetAlert({
							title : "注册成功",
							timer : 2000,
							confirmButtonText : "确定"
						});
						document.getElementById("registered-tan").style.display = "none";
					} else {
						sweetAlert("", "注册失败", "warning");
					}
				},
			});
}

	//重置
	function reset() {
		$("#setname").val("");
		$("#setpassword").val("");
		$("#password-m").val("");
		$("#telephone").val("");
		$("#wechat").val("");
		$("#qqnum").val("");
	}

	//为空时提示
	function isNull(value, name) {
		if (null == value || "" == value) {
			alert(name + "为空，请输入！");
			return "yes";
		}
		return "no";
	}

	function forget() {
		alert("请联系管理员8008208820！！！");
	}
	function pupopen() {
		$("#registered-tan").attr("style", "display:block");
	}
	function pupclose() {
		document.getElementById("registered-tan").style.display = "none";
	}
</script>
</head>

<body>
	<div id="registered-tan">
	<h1>申请注册</h1>
	<label>
	<span>用&nbsp;户&nbsp;名:</span>
	<input id="setname" type="text" name="name" placeholder="学号/工号" />
	</label>
	<label>
	<span>密&nbsp;&nbsp;&nbsp;&nbsp;码:</span>
	<input id="setpassword" type="password" name="password" placeholder="密码" />
	</label>
	<label>
	<span>确认密码:</span>
	<input id="password-m" type="password" name="password" placeholder="确认密码" />
	</label>
	<label>
	<span>联系电话:</span>
	<input id="telephone" type="text" name="telephone"/>
	</label>
	<label>
	<span>微&nbsp;&nbsp;&nbsp;&nbsp;信:</span>
	<input id="wechat" type="text" name="wechat"/>
	</label>
	<label>
	<span>Q&nbsp;&nbsp;&nbsp;&nbsp;Q:</span>
	<input id="qqnum" type="text" name="qqnum"/>
	</label>
	<button onclick="register()">注册</button>
	<button onclick="reset()">重置</button>
	<button onclick="pupclose()">取消</button>
	</div>
<div class="login-main">
    <div class="dark-matter">
    <h1>用户登录</h1>
	<label>
	<span>用户名:</span>
    <input id="name" type="text" name="name" value="" placeholder="学号/工号" />
    </label>
    <label>
    <span>密&nbsp;&nbsp;码:</span>
    <input id="password" type="password" name="password" value="" placeholder="密码" />
    </label>
	<label>
	<p><a href="javascript:;" onclick="forget()">忘记密码？</a></p>
	</label>
	<button onclick="login()">登录</button>
	<button onclick="pupopen()">注册</button>
    </div>
</div>
<footer>
    <p>@版权所有：西南科技大学.swust.jjglxg1402-Darren.</p>
</footer>
</body>
</html>
