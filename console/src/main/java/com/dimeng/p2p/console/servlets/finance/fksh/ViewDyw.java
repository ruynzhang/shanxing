package com.dimeng.p2p.console.servlets.finance.fksh;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S61.enums.T6110_F06;
import com.dimeng.p2p.S62.entities.T6230;
import com.dimeng.p2p.S62.entities.T6234;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.modules.account.console.service.UserManage;
import com.dimeng.p2p.modules.bid.console.service.BidManage;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_LOAN_USERHOUSE", name = "查看抵押物列表", isMenu = false)
public class ViewDyw extends AbstractBidServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -268955794485557959L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		int userId = IntegerParser.parse(request.getParameter("userId"));
		int loanId = IntegerParser.parse(request.getParameter("loanId"));
		UserManage userManage = serviceSession.getService(UserManage.class);
		BidManage bidManage = serviceSession.getService(BidManage.class);
		T6110_F06 userType = userManage.getUserType(userId);
		T6230 t6230 = bidManage.getBidType(loanId);
		T6234[] t6234s = bidManage.searchBidDyw(loanId);
		request.setAttribute("t6230", t6230);
		request.setAttribute("userType", userType);
		request.setAttribute("t6234s", t6234s);
		forwardView(request, response, getClass());
	}
}
