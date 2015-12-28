package com.dimeng.p2p.user.servlets.spread;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;

public class Wytg extends AbstractSpreadServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		
		forward(request, response, getController().getViewURI(request, Wytg.class));
	}


}
