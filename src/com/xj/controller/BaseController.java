package com.xj.controller;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 基础控制器
 * @author Darren
 * @Date 2018年4月27日 下午7:11:54
 */
@Controller
@Scope("prototype")
@ResponseBody // 返回json，@ResponseEntity类似
public class BaseController {
	String language = "zh_CN";
	String errorCode = "200";
	String errorMessage = "OK";
	public String getLanguage() {
		return language;
	}
	public String getErrorCode() {
		return errorCode;
	}
	public String getErrorMessage() {
		return errorMessage;
	}
	public Result result(Object object) {
		Result result = new Result();
		result.setErrorCode(errorCode);
		result.setErrorMessage(errorMessage);
		result.setLanguage(language);
		result.setResult(object);
		return result;
	}
	

}
class Result{
	String language = "zh_CN";
	String errorCode = "200";
	String errorMessage = "OK";
	Object result = null;
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}
	public String getErrorCode() {
		return errorCode;
	}
	public void setErrorCode(String errorCode) {
		this.errorCode = errorCode;
	}
	public String getErrorMessage() {
		return errorMessage;
	}
	public void setErrorMessage(String errorMessage) {
		this.errorMessage = errorMessage;
	}
	public Object getResult() {
		return result;
	}
	public void setResult(Object result) {
		this.result = result;
	}
}
