package com.dimeng.p2p.user.servlets.financing;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;

public class FinancingStatistics extends AbstractFinancingServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		sendRedirect(request, response,
				getController().getViewURI(request, getClass()));
	}

}
