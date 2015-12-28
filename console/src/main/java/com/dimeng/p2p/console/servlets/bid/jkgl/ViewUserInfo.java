package com.dimeng.p2p.console.servlets.bid.jkgl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S62.entities.T6230;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.modules.account.console.service.GrManage;
import com.dimeng.p2p.modules.account.console.service.entity.Grxx;
import com.dimeng.p2p.modules.bid.console.service.BidManage;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_LOAN_USERHOUSE", name = "标的用户信息", isMenu = false)
public class ViewUserInfo extends AbstractBidServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -268955794485557959L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		GrManage personalManage = serviceSession
				.getService(GrManage.class);
		int userId = IntegerParser.parse(request.getParameter("userId"));
		BidManage bidManage = serviceSession.getService(BidManage.class);
		int loanId = IntegerParser.parse(request.getParameter("loanId"));
		T6230 t6230 = bidManage.getBidType(loanId);
		Grxx user = personalManage.getUser(userId);
		request.setAttribute("user", user);
		request.setAttribute("t6230", t6230);
		forwardView(request, response, getClass());
	}
}
