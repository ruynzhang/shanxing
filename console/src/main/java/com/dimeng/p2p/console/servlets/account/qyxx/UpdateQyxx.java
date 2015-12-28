package com.dimeng.p2p.console.servlets.account.qyxx;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S61.entities.T6161;
import com.dimeng.p2p.console.servlets.account.AbstractAccountServlet;
import com.dimeng.p2p.console.servlets.account.qyxx.jscl.UpdateJscl;
import com.dimeng.p2p.modules.account.console.service.QyManage;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_ACCOUNT_QYXX_UPDATEQYXX", name = "修改企业信息")
public class UpdateQyxx extends AbstractAccountServlet {
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
			QyManage manage = serviceSession.getService(QyManage.class);
			int id = IntegerParser.parse(request.getParameter("id"));
			T6161 entity = new T6161();
			entity.parse(request);
			entity.F01 = id;
			manage.updateQyxx(entity);
			sendRedirect(request, response,
					getController().getURI(request, UpdateJscl.class) + "?id="
							+ id);
		} catch (Exception e) {
			prompt(request, response, PromptLevel.ERROR, e.getMessage());
			processGet(request, response, serviceSession);
		}
	}

}
