package com.dimeng.p2p.console.servlets.offline;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.modules.bid.console.service.OfflineManage;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_OFFLIEN_OFFLINELINEZF", name = "线下债权作废")
@MultipartConfig
public class OfflineLineZf extends AbstractBidServlet {

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
		OfflineManage bidManage = serviceSession
				.getService(OfflineManage.class);
		int loanId = IntegerParser.parse(request.getParameter("loanId"));
		bidManage.updateBidStatus(loanId);
		sendRedirect(request, response,
				getController().getURI(request, OfflineLoanList.class));
	}
}
