package com.dimeng.p2p.user.servlets.account.fcxx;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S61.entities.T6112;
import com.dimeng.p2p.account.user.service.UserBaseManage;
import com.dimeng.p2p.user.servlets.account.AbstractAccountServlet;
import com.dimeng.util.parser.IntegerParser;


public class UpdateFcxx extends AbstractAccountServlet{
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		
		UserBaseManage manage = serviceSession.getService(UserBaseManage.class);
		T6112 entity = new T6112();
		entity.parse(request);
		entity.F08 = IntegerParser.parse(request.getParameter("xian"));
		manage.updateFcxx(entity);
		sendRedirect(request, response, getController().getURI(request, Fcxx.class));
	}

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		UserBaseManage userManage = serviceSession.getService(UserBaseManage.class);
		T6112 t = userManage.getFcxx(IntegerParser.parse(request.getParameter("id")));
		request.setAttribute("t", t);
		forwardView(request, response, getClass());
	}
	
	
	
}
