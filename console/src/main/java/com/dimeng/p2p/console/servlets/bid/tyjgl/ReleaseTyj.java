package com.dimeng.p2p.console.servlets.bid.tyjgl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.common.Expemonyinfo;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.modules.bid.console.service.BidManage;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_BUSI_RELEASETYJ", name = "体验金的发布")
public class ReleaseTyj extends AbstractBidServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -268955794485557959L;

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
		int loanId = IntegerParser.parse(request.getParameter("loanId"));
		BidManage bidManage = serviceSession.getService(BidManage.class);
		Expemonyinfo bid=bidManage.getTyj(loanId);
		bidManage.releasetyj(loanId,bid.fundraterm);
		sendRedirect(request, response,
				getController().getURI(request, TyjglList.class));
	}
}
