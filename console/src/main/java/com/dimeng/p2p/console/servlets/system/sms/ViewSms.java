package com.dimeng.p2p.console.servlets.system.sms;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.system.AbstractSystemServlet;
import com.dimeng.p2p.modules.systematic.console.service.SmsManage;
import com.dimeng.p2p.modules.systematic.console.service.entity.Sms;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_SYS_VIEWSMS", name = "短信推广查看")
public class ViewSms extends AbstractSystemServlet {
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
		SmsManage smsManage = serviceSession.getService(SmsManage.class);
		int id = IntegerParser.parse(request.getParameter("id"));
		Sms sms = smsManage.get(id);
		request.setAttribute("sms", sms);
		forwardView(request, response,getClass());
	}

	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		super.onThrowable(request, response, throwable);
	}
}
