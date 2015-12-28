package com.dimeng.p2p.console.servlets.system.email;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.system.AbstractSystemServlet;
import com.dimeng.p2p.modules.systematic.console.service.EmailManage;
import com.dimeng.p2p.modules.systematic.console.service.entity.Email;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_SYS_VIEWEMAIL", name = "邮件推广查看")
public class ViewEmail extends AbstractSystemServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		EmailManage emailManage = serviceSession.getService(EmailManage.class);
		int id = IntegerParser.parse(request.getParameter("id"));
		Email email = emailManage.get(id);
		request.setAttribute("email", email);
		forwardView(request, response, this.getClass());
	}

	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		super.onThrowable(request, response, throwable);
	}
}
