package com.dimeng.p2p.console.servlets.base.dywsx;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.base.AbstractBaseServlet;
import com.dimeng.p2p.modules.base.console.service.DywsxManage;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_BASE_TYDYWSX", name = "停用抵押物属性")
public class TyDywsx extends AbstractBaseServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		DywsxManage manage = serviceSession.getService(DywsxManage.class);
		int id = IntegerParser.parse(request.getParameter("id"));
		manage.tyDywsx(id);
		sendRedirect(request, response,getController().getURI(request, DywsxList.class));
	}

}
