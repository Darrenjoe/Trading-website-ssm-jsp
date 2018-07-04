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
import org.springframework.web.portlet.ModelAndView;

import com.xj.entity.Affiche;
import com.xj.entity.param.QueryConditionData;
import com.xj.entity.view.AfficheView;
import com.xj.service.AfficheService;
import com.xj.util.Page;

/**
 * 公告栏信息控制器
 * 
 * @author Darren
 * @Date 2018年4月27日 下午6:59:19
 */
@Controller
@Scope("prototype")
@ResponseBody()
public class AfficheController extends BaseController {
	@Autowired
	private AfficheService afficheService;

	// 添加公告栏
	@RequestMapping(value = "/addAffiche", method = RequestMethod.POST)
	public Result addAffiche(HttpServletResponse response, HttpServletRequest request) {
		Affiche affiche = new Affiche();
		affiche.setTitle(request.getParameter("title"));
		affiche.setContent(request.getParameter("content"));
		affiche.setUserId(request.getParameter("userId"));
		boolean data = afficheService.addAffiche(affiche);
		return result(data);
	}

	// 获取全部公告栏信息
	@RequestMapping("/getAllAffiche")
	public Result getAllAffiche() {
		errorMessage = "getAllAffiche";
		System.out.println("111");
		List<AfficheView> allAffiche = afficheService.getAllAffiche();
		return result(allAffiche);
	}
	
	// 获取部分公告栏信息
	@RequestMapping("/querySomeAffice")
	public Result querySomeAffice() {
		errorMessage = "querySomeAffice";
		List<Affiche> allAffiche = afficheService.querySomeAffice();
		return result(allAffiche);
	}

	// 根据内容搜索公告栏
	@RequestMapping("/getAfficheByContent")
	public Result getAfficheByContent(HttpServletResponse response, HttpServletRequest request) {
		errorMessage = "getAfficheByContent";
		String content = request.getParameter("content");
		List<Affiche> data = afficheService.getAfficheByContent(content);
		return result(data);
	}

	// 分页查询公告
	@RequestMapping("/queryMoreAffiche")
	public ModelAndView queryMoreAffiche(HttpServletResponse response, HttpServletRequest request) {
		errorMessage = "queryMoreAffiche";
		ModelAndView modelAndView = new ModelAndView();
		int pageSize = Integer.parseInt(request.getParameter("pageSize"));
		int page = Integer.parseInt(request.getParameter("page"));
		Page page2 = new Page(page, pageSize);
		QueryConditionData queryConditionData = new QueryConditionData();
		List<Affiche> allAffiche = afficheService.queryMoreAffiche(queryConditionData, page2);
		modelAndView.addObject("list", allAffiche);
		modelAndView.addObject("page", page2);
		return modelAndView;
	}
}
