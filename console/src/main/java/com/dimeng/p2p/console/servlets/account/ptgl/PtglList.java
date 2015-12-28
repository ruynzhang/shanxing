package com.dimeng.p2p.console.servlets.account.ptgl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S71.entities.T7101;
import com.dimeng.p2p.console.servlets.account.AbstractAccountServlet;
import com.dimeng.p2p.modules.account.console.service.PtglManage;

@Right(id = "P2P_C_ACCOUNT_PTLIST", isMenu=true, name = "平台管理")
public class PtglList extends AbstractAccountServlet {

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
		PtglManage manager = serviceSession.getService(PtglManage.class);
		T7101 entity = manager.search();
		
		request.setAttribute("result", entity);

		forwardView(request, response, getClass());
	}

}
