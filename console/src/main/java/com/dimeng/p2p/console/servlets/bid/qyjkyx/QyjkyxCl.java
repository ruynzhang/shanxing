package com.dimeng.p2p.console.servlets.bid.qyjkyx;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.modules.bid.console.service.BidWillManage;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_BUSI_QYJKYXCL", name = "企业借款意向处理")
public class QyjkyxCl extends AbstractBidServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			final HttpServletResponse response,
			final ServiceSession serviceSession) throws Throwable {
		BidWillManage bidWillManage = serviceSession
				.getService(BidWillManage.class);
		String disposeDesc = request.getParameter("disposeDesc");
		bidWillManage.qyjkyxCl(IntegerParser.parse(request.getParameter("id")),
				disposeDesc);
		sendRedirect(request, response,
				getController().getURI(request, QyjkyxList.class));
	}
}
