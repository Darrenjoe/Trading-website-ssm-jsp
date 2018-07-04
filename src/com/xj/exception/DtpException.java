package com.xj.exception;

/**
 * 数据转换平台业务异常类
 */
public class DtpException extends Exception {

	private static final long serialVersionUID = 1L;

	/**
	 *构造方法
	 */
	public DtpException() {
		super();
	}

	/**
	 * 构造方法
	 * @param message 异常消息
	 */
	public DtpException(String message) {
		super(message);
	}

	/**
	 * 构造方法
	 * @param message 异常消息
	 * @param cause 异常原因
	 */
	public DtpException(String message, Throwable cause) {
		super(message, cause);
	}

	/**
	 * 构造方法
	 * @param cause 异常原因
	 */
	public DtpException(Throwable cause) {
		super(cause);
	}

}
