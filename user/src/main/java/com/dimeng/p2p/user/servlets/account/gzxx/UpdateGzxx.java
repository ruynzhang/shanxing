package com.dimeng.p2p.user.servlets.account.gzxx;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S61.entities.T6143;
import com.dimeng.p2p.account.user.service.UserBaseManage;
import com.dimeng.p2p.user.servlets.account.AbstractAccountServlet;
import com.dimeng.util.parser.IntegerParser;

public class UpdateGzxx extends AbstractAccountServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		UserBaseManage manage = serviceSession.getService(UserBaseManage.class);
		T6143 entity = new T6143();
		entity.parse(request);
		entity.F07 = IntegerParser.parse(request.getParameter("xian"));
		manage.updateGzxx(entity);
		sendRedirect(request, response,
				getController().getURI(request, Gzxx.class));
	}

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		UserBaseManage userManage = serviceSession
				.getService(UserBaseManage.class);
		T6143 t = userManage.getGzxx(IntegerParser.parse(request
				.getParameter("id")));
		request.setAttribute("t", t);
		forwardView(request, response, getClass());
	}

}
