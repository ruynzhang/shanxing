package com.dimeng.p2p.console.servlets.bid.lcgl.zqzrgl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.modules.financial.console.service.CreditorTransferManage;
import com.dimeng.p2p.modules.financial.console.service.entity.ViewLoanRecord;
import com.dimeng.p2p.modules.financial.console.service.entity.ViewTransfer;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_BUSI_ZQVIEW", name = "债权详情")
public class ViewLoan extends AbstractBidServlet {
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
		int transferId = IntegerParser.parse(request.getParameter("transferId"));
		ViewTransfer viewTransfer = creditorTransferManage.findTransferInfo(transferId);
		ViewLoanRecord viewLoanRecord = null;
		if(viewTransfer != null){
			viewLoanRecord = creditorTransferManage.findViewLoanRecord(viewTransfer.userId);
		}
		
		request.setAttribute("viewTransfer", viewTransfer);
		request.setAttribute("viewLoanRecord", viewLoanRecord);
		
		forwardView(request, response, getClass());
	}

}
