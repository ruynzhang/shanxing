package com.dimeng.p2p.console.servlets.account.grxx;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S61.entities.T6110;
import com.dimeng.p2p.console.servlets.account.AbstractAccountServlet;
import com.dimeng.p2p.modules.account.console.service.GrManage;
import com.dimeng.p2p.modules.account.console.service.entity.Grxx;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_ACCOUNT_UPDATEGR", name = "修改个人账号")
public class UpdateGr extends AbstractAccountServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		GrManage manage = serviceSession.getService(GrManage.class);
		int userId = IntegerParser.parse(request.getParameter("userId"));
		Grxx user = manage.getUser(userId);
		if (user == null) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			return;
		}
		request.setAttribute("user", user);
		forwardView(request, response, getClass());
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			final HttpServletResponse response,
			final ServiceSession serviceSession) throws Throwable {
		try {
			GrManage manage = serviceSession.getService(GrManage.class);
			T6110 t6110 = new T6110();
			t6110.F01 = IntegerParser.parse(request.getParameter("userId"));
			t6110.F04 = request.getParameter("msisdn");
			t6110.F05 = request.getParameter("mailbox");
			manage.update(t6110);
			sendRedirect(request, response,
					getController().getURI(request, GrList.class));
		} catch (Exception e) {
			prompt(request, response, PromptLevel.ERROR, e.getMessage());
			processGet(request, response, serviceSession);
		}
	
	}

}
