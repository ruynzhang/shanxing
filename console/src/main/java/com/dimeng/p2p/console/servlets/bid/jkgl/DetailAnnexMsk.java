package com.dimeng.p2p.console.servlets.bid.jkgl;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S61.enums.T6110_F06;
import com.dimeng.p2p.S62.entities.T6230;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.modules.account.console.service.UserManage;
import com.dimeng.p2p.modules.bid.console.service.AnnexManage;
import com.dimeng.p2p.modules.bid.console.service.BidManage;
import com.dimeng.p2p.modules.bid.console.service.entity.MskAnnex;
import com.dimeng.util.parser.IntegerParser;

//@Right(id = "P2P_C_LOAN_ADDLOAN", name = "上传马赛克附件")
@MultipartConfig
public class DetailAnnexMsk extends AbstractBidServlet {

	private static final long serialVersionUID = -268955794485557959L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		AnnexManage annexManage = serviceSession.getService(AnnexManage.class);
		int loanId = IntegerParser.parse(request.getParameter("loanId"));
		int userId = IntegerParser.parse(request.getParameter("userId"));
		UserManage userManage = serviceSession.getService(UserManage.class);
		T6110_F06 userType = userManage.getUserType(userId);
		request.setAttribute("userType", userType);
		BidManage bidManage = serviceSession.getService(BidManage.class);
		T6230 t6230 = bidManage.getBidType(loanId);
		request.setAttribute("t6230", t6230);
		MskAnnex[] t6232s = annexManage.searchGk(loanId);
		request.setAttribute("t6232s", t6232s);
		forwardView(request, response, getClass());
	}
}
