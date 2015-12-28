package com.dimeng.p2p.console.servlets;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.session.Session;
import com.dimeng.framework.service.ServiceSession;

public class Logout extends AbstractConsoleServlet {

	private static final long serialVersionUID = 1L;

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
		Session session = serviceSession.getSession();
		if (session != null) {
			session.invalidate(request, response);
		}
		sendRedirect(request, response,
				getController().getURI(request, Login.class));
	}

}
