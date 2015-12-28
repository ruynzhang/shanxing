package com.dimeng.p2p.console.servlets.account.kfxx;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S71.entities.T7168;
import com.dimeng.p2p.console.servlets.account.AbstractAccountServlet;
import com.dimeng.p2p.modules.account.console.service.GrManage;
import com.dimeng.p2p.modules.account.console.service.KhjlManage;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_ACCOUNT_KFXX_ADDHFJL",  name = "新增回访记录")
public class AddHfjl extends AbstractAccountServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		GrManage manage = serviceSession.getService(GrManage.class);
		int userId = IntegerParser.parse(request.getParameter("userId"));
		request.setAttribute("user", manage.getUser(userId));
		forwardView(request, response, getClass());
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			final HttpServletResponse response,
			final ServiceSession serviceSession) throws Throwable {
		KhjlManage manage = serviceSession.getService(KhjlManage.class);
		T7168 entity = new T7168();
		entity.parse(request);
		manage.addHfjl(entity);
		sendRedirect(request, response, getController().getURI(request, KfList.class));
	}

}
