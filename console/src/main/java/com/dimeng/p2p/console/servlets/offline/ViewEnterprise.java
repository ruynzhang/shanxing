package com.dimeng.p2p.console.servlets.offline;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S61.entities.T6161;
import com.dimeng.p2p.S62.entities.T6230;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.modules.account.console.service.EnterpriseManage;
import com.dimeng.p2p.modules.bid.console.service.OfflineManage;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_OFFLINE_ENTERPRISE", name = "标的企业信息", isMenu = false)
public class ViewEnterprise extends AbstractBidServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -268955794485557959L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		EnterpriseManage enterpriseManage = serviceSession
				.getService(EnterpriseManage.class);
		OfflineManage OfflineManage = serviceSession.getService(OfflineManage.class);
		int userId = IntegerParser.parse(request.getParameter("userId"));
		T6161 t6161 = enterpriseManage.getEnterprise(userId);
		request.setAttribute("t6161", t6161);
		int loanId = IntegerParser.parse(request.getParameter("loanId"));
		T6230 t6230 = OfflineManage.getBidType(loanId);
		request.setAttribute("t6230", t6230);
		forwardView(request, response, getClass());
	}
}
