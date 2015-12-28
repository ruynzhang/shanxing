package com.dimeng.p2p.front.servlets;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.session.Session;
import com.dimeng.framework.http.session.SessionManager;
import com.dimeng.framework.service.ServiceSession;

public class Logout extends AbstractFrontServlet {
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
		Session session = getResourceProvider().getResource(
				SessionManager.class).getSession(request, response, true);
		if (session != null) {
			session.invalidate(request, response);
		}
		sendRedirect(request, response,
				getController().getViewURI(request, Index.class));
	}
}
