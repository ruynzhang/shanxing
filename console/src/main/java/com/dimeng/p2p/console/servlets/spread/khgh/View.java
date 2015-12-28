package com.dimeng.p2p.console.servlets.spread.khgh;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.spread.AbstractSpreadServlet;
import com.dimeng.p2p.modules.base.console.service.KhghManage;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_SPREAD_KHGH_VIEW", name = "查看客户关怀")
public class View extends AbstractSpreadServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}
	
	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		request.setAttribute("entity",
				serviceSession.getService(KhghManage.class).get(IntegerParser.parse(request.getParameter("id"))));
		forwardView(request, response, getClass());
	}
}
