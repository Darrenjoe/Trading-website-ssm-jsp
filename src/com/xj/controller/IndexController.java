package com.xj.controller;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@Scope("prototype")
public class IndexController {
	/**
	 * 返回页面index.html，文件夹以及后缀在context.xml的InternalResourceViewResolver配置
	 * @return
	 */
	@RequestMapping("/")
	public ModelAndView home() {
		System.out.println(this.getClass() + "." + Thread.currentThread().getStackTrace()[1].getMethodName());
	    return new ModelAndView("index");
	}
	@RequestMapping("/index")
	public ModelAndView index() {
		System.out.println(this.getClass() + "." + Thread.currentThread().getStackTrace()[1].getMethodName());
	    return new ModelAndView("index");
	}

}
