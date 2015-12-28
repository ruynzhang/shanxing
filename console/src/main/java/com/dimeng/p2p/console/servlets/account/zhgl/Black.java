package com.dimeng.p2p.console.servlets.account.zhgl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.account.AbstractAccountServlet;
import com.dimeng.p2p.modules.account.console.service.UserManage;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_ACCOUNT_GRBLACK", name = "拉黑个人账号")
public class Black extends AbstractAccountServlet {
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
		
		manage.black(id, blacklistDesc);
		
		sendRedirect(request, response, getController().getURI(request, ZhList.class)+"?paging.current="+request.getParameter("paging.current"));
	}

}
