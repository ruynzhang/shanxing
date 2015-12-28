package com.dimeng.p2p.user.servlets.account.gzxx;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S61.entities.T6143;
import com.dimeng.p2p.account.user.service.UserBaseManage;
import com.dimeng.p2p.user.servlets.account.AbstractAccountServlet;
import com.dimeng.util.parser.IntegerParser;


public class ViewGzxx extends AbstractAccountServlet{
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		UserBaseManage userManage = serviceSession.getService(UserBaseManage.class);
		T6143 t = userManage.getGzxx(IntegerParser.parse(request.getParameter("id")));
		request.setAttribute("t", t);
		forwardView(request, response, getClass());
	}
}
