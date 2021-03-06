package com.dimeng.p2p.console.servlets.offline;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S62.entities.T6237;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.modules.account.console.service.EnterpriseManage;
import com.dimeng.p2p.modules.bid.console.service.OfflineManage;
import com.dimeng.p2p.modules.bid.console.service.entity.Dbxx;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_OFFLINE_ADDGUARANTEE", name = "查看担保信息")
public class DetailGuarantee extends AbstractBidServlet {

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
		int id = IntegerParser.parse(request.getParameter("id"));
		int loanId = IntegerParser.parse(request.getParameter("loanId"));
		OfflineManage OfflineManage = serviceSession.getService(OfflineManage.class);
		Dbxx t6236 = OfflineManage.getBidDb(id);
		T6237 t6237 = OfflineManage.getBidFx(loanId);
		String des = enterpriseManage.getJgDes(t6236.F03);
		request.setAttribute("t6236", t6236);
		request.setAttribute("t6237", t6237);
		request.setAttribute("des", des);
		forwardView(request, response, getClass());
	}
}
