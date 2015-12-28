package com.dimeng.p2p.console.servlets.account.qyxx;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.account.AbstractAccountServlet;
import com.dimeng.p2p.modules.account.console.service.UserManage;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_ACCOUNT_QYUNBLACK", name = "取消拉黑企业账号")
public class QyUnBlack extends AbstractAccountServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			final HttpServletResponse response,
			final ServiceSession serviceSession) throws Throwable {
		UserManage manage = serviceSession.getService(UserManage.class);
		int id = IntegerParser.parse(request.getParameter("userId"));
		String blacklistDesc = request.getParameter("blacklistDesc");
		
		manage.unBlack(id, blacklistDesc);
		
		sendRedirect(request, response, getController().getURI(request, QyList.class));
	}
}
