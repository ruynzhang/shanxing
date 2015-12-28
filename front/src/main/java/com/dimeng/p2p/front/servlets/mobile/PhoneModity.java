package com.dimeng.p2p.front.servlets.mobile;

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
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.account.front.service.PasswordManage;
import com.dimeng.p2p.variables.defines.MsgVariavle;
import com.dimeng.util.StringHelper;

public class PhoneModity extends AbstractMobileServlet{
	private static final long serialVersionUID = 1L;
	protected String FIND_PASSWORD_PHONE = "find.password.phone";
	protected String PASSWORD_VERIFY_CODE_TYPE = "password.verify.code";
	
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
		String phone = request.getParameter("phone");
		
		if (StringHelper.isEmpty(phone)) {
			request.setAttribute("PHONE_ERROR", "手机号码不能为空");
			forward(request, response,
					getController().getViewURI(request, DismePassword.class));
			return;
		}
		VerifyCodeAuthentication authentication = new VerifyCodeAuthentication();
		authentication.setVerifyCode(verifyCode);
		authentication.setVerifyCodeType(FIND_PASSWORD_PHONE);
		Session session = serviceSession.getSession();
		session.authenticateVerifyCode(authentication);
		PasswordManage passwordManage = serviceSession
				.getService(PasswordManage.class);
		ConfigureProvider configureProvider = getResourceProvider()
				.getResource(ConfigureProvider.class);

		int id = passwordManage.phoneExist(phone);
		if (id <= 0) {
			request.setAttribute("PHONE_ERROR", "手机号码未被注册");
			forward(request, response,
					getController().getViewURI(request, DismePassword.class));
			return;
		}
		SmsSender smsSender = serviceSession.getService(SmsSender.class);
	

		String tem = configureProvider
				.getProperty(MsgVariavle.FIND_PASSWORD);
		Envionment envionment = configureProvider.createEnvionment();
		String code = session.getVerifyCode(PASSWORD_VERIFY_CODE_TYPE);
		envionment.set("code", code);
		smsSender.send(0, StringHelper.format(tem, envionment), phone);
		session.setAttribute("PASSWORD_ACCOUNT_ID", Integer.toString(id));
		sendRedirect(request, response,
				getController().getViewURI(request, ResetPassword.class));
	}
	
	
	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		if(throwable instanceof AuthenticationException){
				request.setAttribute("PHONE_VERIFYCODE_ERROR", "验证码错误");
				forward(request, response,
						getController().getViewURI(request, DismePassword.class));
		}
	}

}
