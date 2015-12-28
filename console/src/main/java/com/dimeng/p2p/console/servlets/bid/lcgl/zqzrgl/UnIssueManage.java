package com.dimeng.p2p.console.servlets.bid.lcgl.zqzrgl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.modules.financial.console.service.CreditorTransferManage;

@Right(id = "P2P_C_BUSI_ZQSHBTG", name = "债权审核不通过")
public class UnIssueManage extends AbstractBidServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}
	
	@Override
	protected void processPost(final HttpServletRequest request,final HttpServletResponse response,
			final ServiceSession serviceSession) throws Throwable {
		CreditorTransferManage creditorTransferManage = serviceSession.getService(CreditorTransferManage.class);
		String ids = request.getParameter("ids");
		creditorTransferManage.shbtg(ids);

		// 重定向
		sendRedirect(request, response, getController().getURI(request, TransferFinishList.class));
	}

}
