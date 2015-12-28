package com.dimeng.p2p.front.servlets.password;

import com.dimeng.p2p.front.servlets.AbstractFrontServlet;

/**
 * 贷款模块抽象Servlet
 * 
 */
public abstract class AbstractPasswordServlet extends AbstractFrontServlet {

	private static final long serialVersionUID = 1L;
	protected String FIND_PASSWORD_EMAIL = "find.password.email";
	protected String FIND_PASSWORD_PHONE = "find.password.phone";
	protected String FIND_PASSWORD_RESET = "find.password.reset";
	protected String PASSWORD_VERIFY_CODE_TYPE = "password.verify.code";
	protected String M_PASSWORD_PHONE = "phone.password.phone";
	protected String M_VERIFY_CODE_TYPE = "phone.verify.code";

}
