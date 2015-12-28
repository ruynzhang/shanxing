package com.dimeng.p2p.console.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.session.Session;
import com.dimeng.framework.http.session.SessionManager;
import com.dimeng.framework.http.session.authentication.AuthenticationException;
import com.dimeng.framework.http.session.authentication.PasswordAuthentication;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.config.ConsoleConst;
import com.dimeng.p2p.console.servlets.common.Index;

public class Login extends AbstractConsoleServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected boolean mustAuthenticated() {
		return false;
	}

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		PasswordAuthentication authentication = new PasswordAuthentication();
		authentication.setAccountName(request.getParameter("username"));
		authentication.setPassword(request.getParameter("password"));
		authentication.setVerifyCode(request.getParameter("verifyCode"));
		authentication.setVerifyCodeType(ConsoleConst.LOGIN_VERIFY_CODE_TYPE);
		Session dimengSession = getResourceProvider().getResource(
				SessionManager.class).getSession(request, response, true);
		if(dimengSession!=null){
			dimengSession.invalidate(request, response);
		}
		dimengSession.checkIn(request, response, authentication);
		dimengSession.setAttribute(ConsoleConst.ACCOUNT_NAME,
				authentication.getAccountName());
		sendRedirect(request, response,
				getController().getURI(request, Index.class));
	}

	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		if (throwable instanceof AuthenticationException) {
			prompt(request, response, PromptLevel.ERROR, throwable.getMessage());
			forwardView(request, response, getClass());
		} else {
			super.onThrowable(request, response, throwable);
		}
	}
}
