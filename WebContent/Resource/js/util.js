
/**
* 生成菜单
*/
function createSidebarMenu(obj,data){
	var dataHtml = '<ul class="nav sidebar-menu"></ul>';
	$(obj).append(dataHtml);
	var len = data.length;
	for(var i = 0; i < len; i++){
		var id = data[i].id;
		var pid = data[i].parentId;
		var text = data[i].menuName;
		var url = data[i].actionUrl;
		var icon =  data[i].menuIcon;
		
		if(icon == "save") icon = "glyphicon glyphicon-tasks";
		
		var clickMethod = "";
		if(url != ""){
			url = host + url;
			clickMethod = "sidebarMenuClick(this,'"+ url +"')";
		}
		
		if(pid == 1 || pid == undefined){
			dataHtml = '<li>'+
							'<a id="'+ id +'" onclick="'+ clickMethod +'"><i class="menu-icon '+ icon +'"></i><span class="menu-text">'+ text +'</span><i class="menu-expand"></i></a>'+
							'<ul class="submenu"></ul>'+
						'</li>';
			$(obj).find(".nav").append(dataHtml);
		}else{
			dataHtml = '<li><a id="'+ id +'" pid="'+ pid +'" onclick="'+ clickMethod +'"><span class="menu-text">'+ text +'</span></a></li>';
			$(obj).find(".nav li #"+ pid).next(".submenu").append(dataHtml);
		}
	}
	
	//处理没有子级的项
	$(obj).find(".submenu").each(function(){
		if($(this).find("li").length == 0) $(this).prev("a").find(".menu-expand").remove();
	});
	
	//添加选中效果
	$(obj).find(".nav li a").on("click", function(){
		var node = $(this).parent("li");
		if(node.find(".menu-expand").length == 0){
			$(obj).find(".nav li").removeClass("active");
			node.addClass("active").siblings().removeClass("open");
		}else{
			if(node.is(".open")) node.removeClass("open");
			else node.addClass("open");
		}
	});
}
/* 菜单操作 */
function sidebarMenuClick(obj, url){
	if(url == "" || url == undefined) return;
	$("#frame-content").attr("src", url);
	var breadcrumb = $(".breadcrumb");
	breadcrumb.find(".active").removeClass("active")
	breadcrumb.find(".newRumb").remove();
	var pid = $(obj).attr("pid");
	var ptHtml = "";
	if(pid != undefined) ptHtml = '<li class="newRumb"><span class="menu-text"> '+ $("#"+ pid).text() +' </span></li>';
	var tHtml = '<li class="newRumb active"><a href="'+ url +'"><span class="menu-text"> '+ $(obj).text() +' </span></a></li>';
	breadcrumb.append(ptHtml+tHtml);
	$(".header-title h1").text($(obj).text());
}
function frameRefresh(){
	var frame = $("#frame-content");
	var url = frame.attr("src");
	if(url == "" || url == undefined) return;
	frame.attr("src", url);
}

/**
*	非空验证 validateRequired
*/
function validateRequired(){
	var validate = true;
	$(".vMsg").remove();//移除提示

	//非空验证
	var required = $(".required");
	required.each(function(){
		var obj = $(this);
		if(obj.val() == ""){
			var msg = "必填项.";
			var style = "";
			if(obj.is("input") && obj.is(".wdatebox")){
				msg = "请选择时间.";
				style = "margin-top:0px;";
			}
			if(obj.is("select")){
				msg = "请选择.";
				style = "margin-top:-2px;";
			}
			//$(this).after('<span class="vMsg">'+ msg +'</span>');
			var msgHtml = '<span class="alert alert-danger fade in vMsg">'+
	                            '<button class="close" data-dismiss="alert">×</button>'+
	                            '<i class="fa-fw fa fa-warning"></i>'+ msg +
	                        '</span>';
			$(this).after(msgHtml);
			
			//vMsg超出界面处理
			var vMsg = $(this).next(".vMsg");
			var vw = vMsg.offset().left + vMsg.outerWidth();
			if(vw > $("body").width()) vMsg.css({ "right": 0 });
			
			validate = false;
		}
	});

	//移除提示信息
	setTimeout(function(){
		$(".vMsg").fadeOut(1000);
	},2000);

	return validate;
}