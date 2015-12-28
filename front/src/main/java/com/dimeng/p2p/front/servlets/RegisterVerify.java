package com.dimeng.p2p.front.servlets;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.session.Session;
import com.dimeng.framework.http.session.SessionManager;
import com.dimeng.framework.service.ServiceSession;

public class RegisterVerify extends AbstractFrontServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected boolean mustAuthenticated() {
		return false;
	}

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		Session session = getResourceProvider().getResource(
				SessionManager.class).getSession(request, response, true);
		session.invalidVerifyCode("REGISTER");
		final String verifyCode = session.getVerifyCode("REGISTER");
		AbstractFrontServlet.showKaptcha(
				AbstractFrontServlet.COMMON_KAPTCHA_PRODUCER, verifyCode,
				response);
	}
}
