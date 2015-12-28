package com.dimeng.p2p.pay.servlets;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.pay.servlets.huichao.OpenAccountServlet;

/**
 * 个人用户注册
 */
public class UserRegister extends AbstractPayServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		this.forwardController(request, response, OpenAccountServlet.class);
	}

	@Override
	protected boolean mustAuthenticated() {
		return false;
	}
	

}
