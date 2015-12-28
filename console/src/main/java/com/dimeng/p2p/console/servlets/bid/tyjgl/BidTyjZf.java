package com.dimeng.p2p.console.servlets.bid.tyjgl;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.modules.bid.console.service.BidManage;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_BUSI_BIDTYJZF", name = "体验标的作废")
@MultipartConfig
public class BidTyjZf extends AbstractBidServlet {

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
		BidManage bidManage = serviceSession.getService(BidManage.class);
		int loanId = IntegerParser.parse(request.getParameter("loanId"));
		bidManage.rebidzftyj(loanId);
		sendRedirect(request, response,
				getController().getURI(request, TyjglList.class));
	}
}
