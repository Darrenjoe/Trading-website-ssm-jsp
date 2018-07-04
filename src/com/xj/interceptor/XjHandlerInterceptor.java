package com.xj.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class XjHandlerInterceptor extends HandlerInterceptorAdapter {
	// 此处一般继承HandlerInterceptorAdapter适配器即可
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
//		Log.error("===========XjHandlerInterceptor preHandle");
//		System.out.println("===========XjHandlerInterceptor preHandle");
		String url = request.getRequestURI();
		if(url.indexOf(".error")>=0){
			request.getRequestDispatcher("/WEB-INF/content/error.html").forward(request, response);
            return false;
        }
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
//		System.out.println("===========XjHandlerInterceptor postHandle");
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
//		System.out.println("===========XjHandlerInterceptor afterCompletion");
	}
}
