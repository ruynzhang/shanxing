package com.dimeng.p2p.console.config;

import com.dimeng.p2p.P2PConst;

public abstract interface ConsoleConst extends P2PConst {
	/**
	 * 主库JNDI
	 */
	public static final String DB_MASTER_JNDI = "p2p/console/master";
	/**
	 * 用户登录验证码类型
	 */
	public static final String LOGIN_VERIFY_CODE_TYPE = "LOGIN";
	/**
	 * 登录名
	 */
	public static final String ACCOUNT_NAME = "ACCOUNT_NAME";

	/**
	 * 导入CSV格式
	 */
	public static final String CVS_STR = "application/csv";

	/**
	 * 导入txt格式
	 */
	public static final String TXT_STR = "text/plain";

	/**
	 * 导入EXCLE格式
	 */
	public static final String EXCLE_STR = "application/vnd.ms-excel";
}
