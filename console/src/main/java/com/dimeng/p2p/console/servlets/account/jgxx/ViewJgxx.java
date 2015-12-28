package com.dimeng.p2p.console.servlets.account.jgxx;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S61.entities.T6161;
import com.dimeng.p2p.console.servlets.account.AbstractAccountServlet;
import com.dimeng.p2p.modules.account.console.service.QyManage;
import com.dimeng.util.parser.IntegerParser;

public class ViewJgxx extends AbstractAccountServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		QyManage manage = serviceSession.getService(QyManage.class);
		int id = IntegerParser.parse(request.getParameter("id"));
		T6161 entity= manage.getQyxx(id);
		request.setAttribute("info", entity);
		forwardView(request, response, getClass());
	}
	
	
}
