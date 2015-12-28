package com.dimeng.p2p.console.servlets;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.session.Session;
import com.dimeng.framework.http.session.SessionManager;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.config.ConsoleConst;

public class LoginVerify extends AbstractConsoleServlet {

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
		Session dimengSession = getResourceProvider().getResource(
				SessionManager.class).getSession(request, response, true);
		dimengSession.invalidVerifyCode(ConsoleConst.LOGIN_VERIFY_CODE_TYPE);
		String verifyCode = dimengSession
				.getVerifyCode(ConsoleConst.LOGIN_VERIFY_CODE_TYPE);
		showKaptcha(COMMON_KAPTCHA_PRODUCER, verifyCode, response);
	}

}
