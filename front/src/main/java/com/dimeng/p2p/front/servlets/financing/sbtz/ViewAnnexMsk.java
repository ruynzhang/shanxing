package com.dimeng.p2p.front.servlets.financing.sbtz;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S62.entities.T6232;
import com.dimeng.p2p.front.servlets.financing.AbstractFinancingServlet;
import com.dimeng.p2p.modules.bid.front.service.AnnexManage;
import com.dimeng.util.parser.IntegerParser;

public class ViewAnnexMsk extends AbstractFinancingServlet {

	private static final long serialVersionUID = -268955794485557959L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		AnnexManage annexManage = serviceSession.getService(AnnexManage.class);
		int id = IntegerParser.parse(request.getParameter("id"));
		T6232 t6232 = annexManage.getGk(id);
		request.setAttribute("t6232", t6232);
		forwardView(request, response, getClass());
	}
}
