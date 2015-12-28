package com.dimeng.p2p.console.servlets.account.ptgl;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S71.entities.T7101;
import com.dimeng.p2p.console.servlets.account.AbstractAccountServlet;
import com.dimeng.p2p.modules.account.console.service.PtglManage;
import com.dimeng.p2p.modules.account.console.service.entity.Ptgl;
import com.dimeng.util.parser.IntegerParser;

@MultipartConfig
@Right(id = "P2P_C_ACCOUNT_UPDATEPT", name = "修改平台管理")
public class ViewPtgl extends AbstractAccountServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		PtglManage manage = serviceSession.getService(PtglManage.class);
		int id = IntegerParser.parse(request.getParameter("id"));
		T7101 entity = manage.get(id);
		if (entity == null) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			return;
		}
		request.setAttribute("entity", entity);
		forwardView(request, response, getClass());
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			final HttpServletResponse response,
			final ServiceSession serviceSession) throws Throwable {
		PtglManage manage = serviceSession.getService(PtglManage.class);
		
		Ptgl ptgl = new Ptgl();
		ptgl.parse(request);
		manage.update(ptgl);
		
		sendRedirect(request, response, getController().getURI(request, PtglList.class));
	}

}
