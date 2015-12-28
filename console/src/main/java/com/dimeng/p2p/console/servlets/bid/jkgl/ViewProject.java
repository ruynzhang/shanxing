package com.dimeng.p2p.console.servlets.bid.jkgl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S61.enums.T6110_F06;
import com.dimeng.p2p.S62.entities.T6211;
import com.dimeng.p2p.S62.entities.T6230;
import com.dimeng.p2p.S62.entities.T6231;
import com.dimeng.p2p.S62.entities.T6238;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.modules.account.console.service.UserManage;
import com.dimeng.p2p.modules.bid.console.service.BidManage;
import com.dimeng.p2p.modules.bid.console.service.entity.BidCheck;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_LOAN_PROJECT", name = "标的项目信息", isMenu = false)
public class ViewProject extends AbstractBidServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -268955794485557959L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		final BidManage bidManage = serviceSession.getService(BidManage.class);
		int loanId = IntegerParser.parse(request.getParameter("loanId"));
		int userId = IntegerParser.parse(request.getParameter("userId"));
		UserManage userManage = serviceSession.getService(UserManage.class);
		String userName = userManage.getUserNameById(userId);
		request.setAttribute("userName", userName);
		T6211[] t6211s = bidManage.getBidType();
		request.setAttribute("t6211s", t6211s);
		T6110_F06 userType = userManage.getUserType(userId);
		request.setAttribute("userType", userType);
		T6230 loan = bidManage.get(loanId);
		T6231 t6231 = bidManage.getExtra(loanId);
		request.setAttribute("loan", loan);
		request.setAttribute("t6231", t6231);
		T6230 t6230 = bidManage.getBidType(loanId);
		request.setAttribute("t6230", t6230);
		T6238 t6238 = bidManage.getBidFl(loanId);
		request.setAttribute("t6238", t6238);
		BidCheck[] bidChecks = bidManage.searchCheck(loanId);
		request.setAttribute("bidChecks", bidChecks);
		request.setAttribute("region", bidManage.getRegion(t6231.F07));
		super.processGet(request, response, serviceSession);
	}
}
