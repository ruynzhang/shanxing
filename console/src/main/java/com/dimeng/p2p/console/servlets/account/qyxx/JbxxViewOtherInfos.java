package com.dimeng.p2p.console.servlets.account.qyxx;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S61.entities.T6161;
import com.dimeng.p2p.S61.entities.T6162;
import com.dimeng.p2p.S61.entities.T6163;
import com.dimeng.p2p.S61.entities.T6164;
import com.dimeng.p2p.console.servlets.account.AbstractAccountServlet;
import com.dimeng.p2p.modules.account.console.service.EnterpriseManage;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_ACCOUNT_QYJBOINFOSXXVIEW", name = "查询企业基本详情")
public class JbxxViewOtherInfos extends AbstractAccountServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		EnterpriseManage manager = serviceSession.getService(EnterpriseManage.class);
		
		int userId = IntegerParser.parse(request.getParameter("userId"));
		T6161 t6161 = manager.getEnterprise(userId);
		if (t6161 == null) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			return;
		}
		manager.getEnterpriseJs(userId);
		T6163[] t6163s= manager.getEnterpriseCw(userId);
		T6162 t6162=manager.getEnterpriseJs(userId);
		T6164 t6164 =manager.getEnterpriseLxr(userId);
		request.setAttribute("t6163s", t6163s);
		request.setAttribute("t6161", t6161);
		request.setAttribute("t6162", t6162);
		request.setAttribute("t6164", t6164);
		forwardView(request, response, getClass());
	}
}
