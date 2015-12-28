package com.dimeng.p2p.console.servlets.offline;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S62.entities.T6236;
import com.dimeng.p2p.S62.entities.T6237;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.modules.account.console.service.EnterpriseManage;
import com.dimeng.p2p.modules.account.console.service.entity.Jg;
import com.dimeng.p2p.modules.bid.console.service.OfflineManage;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_OFFLINE_ADDGUARANTEE", name = "添加标的担保信息", isMenu = false)
public class AddGuarantee extends AbstractBidServlet {

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
		int jgId = IntegerParser.parse(request.getParameter("jgId"));
		Jg[] jgs = enterpriseManage.searchJg();
		String des = enterpriseManage.getJgDes(jgId);
		request.setAttribute("jgs", jgs);
		request.setAttribute("des", des);
		forwardView(request, response, getClass());
	}

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		int loanId = IntegerParser.parse(request.getParameter("loanId"));
		int userId = IntegerParser.parse(request.getParameter("userId"));
		OfflineManage OfflineManage = serviceSession.getService(OfflineManage.class);
		T6236 t6236 = new T6236();
		t6236.parse(request);
		t6236.F02 = loanId;
		OfflineManage.addGuarantee(t6236);
		T6237 t6237 = new T6237();
		t6237.F01 = loanId;
		t6237.F02 = request.getParameter("fxkzzs");
		t6237.F03 = request.getParameter("fdbqk");
		OfflineManage.addFx(t6237);
		sendRedirect(request, response,
				getController().getURI(request, AddGuaranteeXq.class)
						+ "?loanId=" + loanId + "&userId=" + userId);
	}
}
