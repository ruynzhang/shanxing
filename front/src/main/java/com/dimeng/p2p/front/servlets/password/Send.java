package com.dimeng.p2p.front.servlets.password;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.config.Envionment;
import com.dimeng.framework.http.session.Session;
import com.dimeng.framework.http.session.authentication.AuthenticationException;
import com.dimeng.framework.http.session.authentication.VerifyCodeAuthentication;
import com.dimeng.framework.message.sms.SmsSender;
import com.dimeng.framework.resource.ResourceRegister;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.account.front.service.PasswordManage;
import com.dimeng.p2p.front.servlets.AbstractFrontServlet;
import com.dimeng.p2p.front.util.EmailSender;
import com.dimeng.p2p.variables.defines.EmailVariavle;
import com.dimeng.p2p.variables.defines.MsgVariavle;
import com.dimeng.util.StringHelper;

public class Send extends AbstractFrontServlet{
	
	private static final long serialVersionUID = 1L;

	protected String FIND_PASSWORD_EMAIL = "find.password.email";
	protected String FIND_PASSWORD_PHONE = "find.password.phone";
	protected String FIND_PASSWORD_RESET = "find.password.reset";
	protected String PASSWORD_VERIFY_CODE_TYPE = "password.verify.code";
	protected String M_PASSWORD_PHONE = "phone.password.phone";
	protected String M_VERIFY_CODE_TYPE = "phone.verify.code";
	
	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
	}

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		String verifyCode = request.getParameter("verifyCode");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String type = request.getParameter("type");
		Session session = serviceSession.getSession();
		PasswordManage passwordManage = serviceSession
				.getService(PasswordManage.class);
		request.setAttribute("type", type);
		VerifyCodeAuthentication authentication = new VerifyCodeAuthentication();
		if ("email".equals(type)) {
			if (StringHelper.isEmpty(email)) {
				request.setAttribute("EMAIL_ERROR", "邮箱地址不能为空");
				forward(request, response,
						getController().getViewURI(request, Index.class));
				return;
			}
			authentication.setVerifyCode(verifyCode);
			authentication.setVerifyCodeType(FIND_PASSWORD_EMAIL);
			session.authenticateVerifyCode(authentication);

			int id = passwordManage.emailExist(email);
			if (id <= 0) {
				request.setAttribute("EMAIL_ERROR", "邮箱未被注册");
				forward(request, response,
						getController().getViewURI(request, Index.class));
				return;
			}
//			EmailSender emailSender = serviceSession
//					.getService(EmailSender.class);
			ConfigureProvider configureProvider = ResourceRegister
					.getResourceProvider(getServletContext()).getResource(
							ConfigureProvider.class);
			String tem = configureProvider
					.getProperty(EmailVariavle.FIND_PASSWORD);
			Envionment envionment = configureProvider.createEnvionment();
			session.invalidVerifyCode(PASSWORD_VERIFY_CODE_TYPE);
			String code = session.getVerifyCode(PASSWORD_VERIFY_CODE_TYPE);
			envionment.set("code", code);
			EmailSender.gmailSend(EmailVariavle.FIND_PASSWORD.getDescription(),
					StringHelper.format(tem, envionment), email);
//			emailSender.send(0, EmailVariavle.FIND_PASSWORD.getDescription(),
//					StringHelper.format(tem, envionment), email);
			session.setAttribute("PASSWORD_ACCOUNT_ID", Integer.toString(id));
			session.invalidVerifyCode(FIND_PASSWORD_EMAIL);
		} else if ("phone".equals(type)) {
			if (StringHelper.isEmpty(phone)) {
				request.setAttribute("PHONE_ERROR", "手机号码不能为空");
				forward(request, response,
						getController().getViewURI(request, Index.class));
				return;
			}
			authentication.setVerifyCode(verifyCode);
			authentication.setVerifyCodeType(FIND_PASSWORD_PHONE);
			session.authenticateVerifyCode(authentication);

			int id = passwordManage.phoneExist(phone);
			if (id <= 0) {
				request.setAttribute("PHONE_ERROR", "手机号码未被注册");
				forward(request, response,
						getController().getViewURI(request, Index.class));
				return;
			}
			SmsSender smsSender = serviceSession.getService(SmsSender.class);
			ConfigureProvider configureProvider = ResourceRegister
					.getResourceProvider(getServletContext()).getResource(
							ConfigureProvider.class);

			String tem = configureProvider
					.getProperty(MsgVariavle.FIND_PASSWORD);
			Envionment envionment = configureProvider.createEnvionment();
			String code = session.getVerifyCode(PASSWORD_VERIFY_CODE_TYPE);
			envionment.set("code", code);
			smsSender.send(0, StringHelper.format(tem, envionment), phone);
			session.setAttribute("PASSWORD_ACCOUNT_ID", Integer.toString(id));
		} else {
			sendRedirect(request, response,
					getController().getViewURI(request, Index.class));
			return;
		}

		sendRedirect(request, response,
				getController().getViewURI(request, Reset.class));
	}

	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		if(throwable instanceof AuthenticationException){
			String type = request.getParameter("type");
			if("email".equals(type)){
				request.setAttribute("EMAIL_VERIFYCODE_ERROR", "验证码错误");
				forward(request, response,
						getController().getViewURI(request, Index.class));
			}else if("phone".equals(type)){
				request.setAttribute("PHONE_VERIFYCODE_ERROR", "验证码错误");
				forward(request, response,
						getController().getViewURI(request, Index.class));
			}
		}
	}
}
