package com.dimeng.p2p.front.servlets;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.config.Envionment;
import com.dimeng.framework.http.session.Session;
import com.dimeng.framework.http.session.SessionManager;
import com.dimeng.framework.message.sms.SmsSender;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.variables.defines.MsgVariavle;
import com.dimeng.util.StringHelper;
import com.dimeng.util.parser.IntegerParser;

public class GetMobileCode extends AbstractFrontServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected boolean mustAuthenticated() {
		return false;
	}

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
	}

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		System.out.println("GetMobileCode");
//		Session session = getResourceProvider().getResource(
//				SessionManager.class).getSession(request, response, true);
//		session.invalidVerifyCode("MOBILECODE");
//		int userId = IntegerParser.parse(request.getParameter("userId"));
//		String mobile = request.getParameter("mobile");
//		ConfigureProvider configureProvider = getResourceProvider()
//				.getResource(ConfigureProvider.class);
//		SmsSender sender = serviceSession.getService(SmsSender.class);
//		final String verifyCode = session.getVerifyCode("MOBILECODE");
//		String template = configureProvider
//				.getProperty(MsgVariavle.RIGISTER_VERIFIY_CODE);
//		if (template == null) {
//			template = "${code},请验证!";
//		}
//		Envionment envionment = configureProvider.createEnvionment();
//		envionment.set("code", verifyCode);
//		sender.send(0, StringHelper.format(template, envionment), mobile);
//		request.setAttribute("userId", userId);
//		forward(request, response,
//				getController().getViewURI(request, Register.class));
	}
}
