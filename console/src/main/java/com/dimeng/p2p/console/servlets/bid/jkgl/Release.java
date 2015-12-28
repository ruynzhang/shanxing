package com.dimeng.p2p.console.servlets.bid.jkgl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.modules.bid.console.service.BidManage;
import com.dimeng.p2p.utlis.JfResource;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_BID_RELEASE", name = "标的发布")
public class Release extends AbstractBidServlet {

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
		bidManage.release(loanId);
		
		JfResource jfResource = getResourceProvider().getResource(JfResource.class);
		
		// pushP2p(希财接口)
		jfResource.csaiPushP2p(loanId);
		
		// postToRotu(Post到融途)
		jfResource.postToRotu(loanId);
		
		sendRedirect(request, response,
				getController().getURI(request, LoanList.class));
	}
}
