package com.dimeng.p2p.front.servlets;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.config.Envionment;
import com.dimeng.framework.http.session.Session;
import com.dimeng.framework.http.session.authentication.VerifyCodeAuthentication;
import com.dimeng.framework.message.sms.SmsSender;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.resource.ResourceRegister;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.account.front.service.PasswordManage;
import com.dimeng.p2p.common.KeepParam;
import com.dimeng.p2p.variables.defines.MsgVariavle;
import com.dimeng.util.StringHelper;

public class Mpwd1 extends AbstractMobileServicer {

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
		
		String verifyCode = request.getParameter("verifyCode");
		String phone = request.getParameter("phone");
		String postfix=KeepParam.keepParamByString(request,ignoreKeys);
		if (StringHelper.isEmpty(phone)) {
			prompt(request, response, PromptLevel.ERROR, "手机号码不能为空");
			forward(request, response,getController().getViewURI(request, Mpwd1.class)+postfix);
			return;
		}
		Session session = serviceSession.getSession();
		VerifyCodeAuthentication authentication = new VerifyCodeAuthentication();
		authentication.setVerifyCode(verifyCode);
		authentication.setVerifyCodeType(FIND_PASSWORD_PHONE);
		session.authenticateVerifyCode(authentication);
		
		PasswordManage passwordManage = serviceSession.getService(PasswordManage.class);
		int id = passwordManage.phoneExist(phone);
		if (id <= 0) {
			prompt(request, response, PromptLevel.ERROR, "手机号码未被注册");
			forward(request, response,getController().getViewURI(request, Mpwd1.class)+postfix);
			return;
		}
		SmsSender smsSender = serviceSession.getService(SmsSender.class);
		ConfigureProvider configureProvider = ResourceRegister
				.getResourceProvider(getServletContext()).getResource(ConfigureProvider.class);
		String tem = configureProvider.getProperty(MsgVariavle.FIND_PASSWORD);
		Envionment envionment = configureProvider.createEnvionment();
		String code = session.getVerifyCode(PASSWORD_VERIFY_CODE_TYPE);
		envionment.set("code", code);
		smsSender.send(0, StringHelper.format(tem, envionment), phone);
		session.setAttribute("PASSWORD_ACCOUNT_ID", Integer.toString(id));
		sendRedirect(request, response,getController().getViewURI(request, Mpwd2.class)+postfix);
	}
	
	private static List<String> ignoreKeys = new ArrayList<String>();
	
	static {
		ignoreKeys.add("verifyCode");
	}

}
