package com.dimeng.p2p.console.servlets.base.xymb;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.base.AbstractBaseServlet;
import com.dimeng.p2p.modules.base.console.service.XymbManage;
import com.dimeng.p2p.modules.base.console.service.entity.Xymb;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_BASE_UPDATEXYMB", name = "协议模板修改")
public class UpdateXymb extends AbstractBaseServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		XymbManage xymbManage = serviceSession.getService(XymbManage.class);
		int id = IntegerParser.parse(request.getParameter("id"));
		int version = IntegerParser.parse(request.getParameter("version"));
		Xymb xymb = xymbManage.get(id, version);
		request.setAttribute("xymb", xymb);
		forwardView(request, response, getClass());
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			final HttpServletResponse response,
			final ServiceSession serviceSession) throws Throwable {
		XymbManage xymbManage = serviceSession.getService(XymbManage.class);
		int id = IntegerParser.parse(request.getParameter("id"));
		String content = request.getParameter("content");
		xymbManage.add(id, content);
		sendRedirect(request, response,
				getController().getURI(request, XymbList.class));
	}
	
	
}
