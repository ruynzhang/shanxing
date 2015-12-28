package com.dimeng.p2p.console.servlets.account.grxx;

import java.io.OutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S61.entities.T6122;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.modules.account.console.service.GrManage;

@Right(id = "P2P_C_ACCOUNT_GRVIEW", name = "查询个人账号详情")
public class Open extends AbstractBidServlet {
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
		String id = request.getParameter("id");

		GrManage manage = serviceSession.getService(GrManage.class);
		T6122 attachment = manage.getAttachment(Integer.parseInt(id));
		response.setContentType(attachment.F01 + "");
		OutputStream out = response.getOutputStream();
		out.write(attachment.F02.getBytes(Long.parseLong("1"),
				(int) attachment.F02.length()));
	}

}
