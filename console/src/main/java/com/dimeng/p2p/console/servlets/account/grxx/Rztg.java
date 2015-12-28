package com.dimeng.p2p.console.servlets.account.grxx;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.modules.account.console.service.GrManage;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_ACCOUNT_RZTG", name = "认证审核通过")
public class Rztg extends AbstractBidServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		GrManage manage = serviceSession.getService(GrManage.class);
		int id = IntegerParser.parse(request.getParameter("yxid"));
		String desc = request.getParameter("desc");
		manage.rztg(id, desc);
		forward(request, response, getController().getURI(request, ShList.class));
	}

	
}
