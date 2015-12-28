package com.dimeng.p2p.user.servlets.account.ccxx;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S61.entities.T6113;
import com.dimeng.p2p.account.user.service.UserBaseManage;
import com.dimeng.p2p.user.servlets.account.AbstractAccountServlet;
import com.dimeng.util.parser.IntegerParser;


public class ViewCcxx extends AbstractAccountServlet{
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		UserBaseManage userManage = serviceSession.getService(UserBaseManage.class);
		T6113 t = userManage.getCcxx(IntegerParser.parse(request.getParameter("id")));
		request.setAttribute("t", t);
		forwardView(request, response, getClass());
	}
}
