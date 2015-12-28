package com.dimeng.p2p.console.servlets.bid.tyjgl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.modules.bid.console.service.AnnexManage;
import com.dimeng.util.parser.IntegerParser;

public class DelAnnexMsk extends AbstractBidServlet {

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
		int loanId = IntegerParser.parse(request.getParameter("loanId"));
		annexManage.delMortFile(id);
		sendRedirect(request, response,
				getController().getURI(request, AddAnnexMsk.class) + "?loanId="
						+ loanId);
	}
}
