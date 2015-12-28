package com.dimeng.p2p.console.servlets.account.qyxx.cwzk;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S61.entities.T6163;
import com.dimeng.p2p.console.servlets.account.AbstractAccountServlet;
import com.dimeng.p2p.console.servlets.account.qyxx.lxxx.UpdateLxxx;
import com.dimeng.p2p.modules.account.console.service.QyManage;
import com.dimeng.p2p.modules.account.console.service.entity.Cwzk;
import com.dimeng.util.parser.IntegerParser;

public class ViewCwzk extends AbstractAccountServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		QyManage manage = serviceSession.getService(QyManage.class);
		int id = IntegerParser.parse(request.getParameter("id"));
		T6163[] info = manage.getCwzk(id);
		request.setAttribute("info", info);
		forwardView(request, response, getClass());
	}

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		QyManage manage = serviceSession.getService(QyManage.class);
		int id = IntegerParser.parse(request.getParameter("id"));
		Cwzk entity = new Cwzk();
		entity.parse(request);
		manage.updateCwzk(entity);
		sendRedirect(request, response, getController()
				.getURI(request, UpdateLxxx.class)+"?id="+id);
	}

}
