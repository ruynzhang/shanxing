package com.dimeng.p2p.front.servlets.mobile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.front.servlets.financing.AbstractFinancingServlet;

public class BidDetail extends AbstractFinancingServlet {

	private static final long serialVersionUID = -268955794485557959L;

	@Override
	protected void processGet(HttpServletRequest request, HttpServletResponse response, ServiceSession serviceSession) throws Throwable {
		processPost(request, response, serviceSession);
	}

	// 参考BidManageImpl
	@Override
	protected void processPost(final HttpServletRequest request, HttpServletResponse response, ServiceSession serviceSession) throws Throwable {
	}
}
