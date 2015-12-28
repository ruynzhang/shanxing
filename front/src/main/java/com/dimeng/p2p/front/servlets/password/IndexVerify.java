package com.dimeng.p2p.front.servlets.password;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.session.Session;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.front.servlets.AbstractFrontServlet;

public class IndexVerify extends AbstractFrontServlet {

	private static final long serialVersionUID = 1L;

	protected String FIND_PASSWORD_EMAIL = "find.password.email";
	protected String FIND_PASSWORD_PHONE = "find.password.phone";
	protected String FIND_PASSWORD_RESET = "find.password.reset";
	protected String PASSWORD_VERIFY_CODE_TYPE = "password.verify.code";
	protected String M_PASSWORD_PHONE = "phone.password.phone";
	protected String M_VERIFY_CODE_TYPE = "phone.verify.code";
	
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
		String t = request.getParameter("t");
		Session session = serviceSession.getSession();
		String verifyCode = null;
		if ("e".equals(t)) {
			session.invalidVerifyCode(FIND_PASSWORD_EMAIL);
			verifyCode = session.getVerifyCode(FIND_PASSWORD_EMAIL);
		} else if ("p".equals(t)) {
			session.invalidVerifyCode(FIND_PASSWORD_PHONE);
			verifyCode = session.getVerifyCode(FIND_PASSWORD_PHONE);
		} else if ("m".equals(t)) {
			session.invalidVerifyCode(M_PASSWORD_PHONE);
			verifyCode = session.getVerifyCode(M_PASSWORD_PHONE);
		} else {
			return;
		}
		AbstractFrontServlet.showKaptcha(
				AbstractFrontServlet.COMMON_KAPTCHA_PRODUCER, verifyCode,
				response);
	}

}
