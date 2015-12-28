package com.dimeng.p2p.console.servlets.account.jgxx;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S61.entities.T6161;
import com.dimeng.p2p.S61.entities.T6180;
import com.dimeng.p2p.console.servlets.account.AbstractAccountServlet;
import com.dimeng.p2p.console.servlets.account.jgxx.jscl.UpdateJscl;
import com.dimeng.p2p.modules.account.console.service.QyManage;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_ACCOUNT_JGXX_UPDATEJGXX", name = "修改机构信息")
public class UpdateJgxx extends AbstractAccountServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		QyManage manager = serviceSession.getService(QyManage.class);
		int userId = IntegerParser.parse(request.getParameter("id"));
		T6161 t6161 = manager.getQyxx(userId);
		if (t6161 == null) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			return;
		}
		request.setAttribute("t6161", t6161);
		forwardView(request, response, getClass());
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			final HttpServletResponse response,
			final ServiceSession serviceSession) throws Throwable {
		try {
			serviceSession.openTransactions();
			QyManage manage = serviceSession.getService(QyManage.class);
			int id = IntegerParser.parse(request.getParameter("id"));
			T6161 entity = new T6161();
			entity.parse(request);
			entity.F01 = id;
			manage.updateQyxx(entity);
			
			T6180 t6180 = new T6180();
			t6180.F01 = id;
			t6180.F02 = request.getParameter("jgjs");
			manage.updateDbzz(t6180);
			
			sendRedirect(request, response,
					getController().getURI(request, UpdateJscl.class) + "?id="
							+ id);
		} catch (Exception e) {
			prompt(request, response, PromptLevel.ERROR, e.getMessage());
			processGet(request, response, serviceSession);
		}
	}

}
