package com.xj.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xj.entity.Collect;
import com.xj.service.CollectService;

/**
 * 收藏信息控制器
 * 
 * @author Darren
 * @Date 2018年4月27日 下午7:12:19
 */
@Controller
@Scope("prototype")
@ResponseBody()
public class CollectController extends BaseController {
	@Autowired
	private CollectService collectService;

	// 添加收藏
	@RequestMapping(value = "/addCollect", method = RequestMethod.POST)
	public Result addCollect(HttpServletResponse response, HttpServletRequest request) {
		Collect collect = new Collect();
		collect.setProductId(request.getParameter("productId"));
		collect.setCollectioner(request.getParameter("collectioner"));
		int data = collectService.addCollect(collect);
		return result(data);
	}

	// 获取全部收藏
	@RequestMapping("/getAllCollect")
	public Result getAllCollect() {
		errorMessage = "getAllCollect";
		List<Collect> allCollect = collectService.getAllCollect();
		return result(allCollect);
	}

}
