package com.dimeng.p2p.pay.servlets;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.http.session.Session;
import com.dimeng.framework.http.session.SessionManager;
import com.dimeng.framework.http.session.authentication.AuthenticationException;
import com.dimeng.framework.http.session.authentication.VerifyCodeAuthentication;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.common.KeepParam;
import com.dimeng.p2p.modules.account.pay.service.MobileSafetyManage;
import com.dimeng.p2p.modules.account.pay.service.UserManage;
import com.dimeng.p2p.variables.defines.URLVariable;
import com.dimeng.util.StringHelper;

public class Register extends AbstractPayServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected boolean mustAuthenticated() {
		return false;
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		Session session = serviceSession.getSession();
		ConfigureProvider configureProvider = getResourceProvider()
				.getResource(ConfigureProvider.class);
		if (session == null) {
			session = getResourceProvider().getResource(SessionManager.class)
					.getSession(request, response, true);
		}
		
		String location = configureProvider.format(URLVariable.REGISTER) + KeepParam.keepParamByString(request, ignoreKeys);
		//用户名
		String accountName = request.getParameter("accountName");
		if(StringHelper.isEmpty(accountName) || !accountName.matches("^([A-Za-z])([\\w]{5,17})$")){
			check(request, response, location, "用户名必须为6-18个字符，使用字母、数字、下划线，需以字母开头");
			return;
		}
		UserManage userManager = serviceSession.getService(UserManage.class);
		boolean isResult = userManager.isAccountExists(accountName);
		if(isResult){
			check(request, response, location, "用户名已存在");
			return;
		}
		//密码
		String password = request.getParameter("password");
		String newPassword = request.getParameter("newPassword");
		if(StringHelper.isEmpty(password) || password.length() > 20 || password.length() < 6){
			check(request, response, location, "密码必须为6~20个字符，区分大小写");
			return;
		}
		if(!password.equals(newPassword)){
			check(request, response, location, "两次密码输入不一致!");
			return ;
		}
		//手机
		MobileSafetyManage mSafetyManage = serviceSession.getService(MobileSafetyManage.class);
		String mobilephone = request.getParameter("mobilephone");
		if(StringHelper.isEmpty(mobilephone) || !mobilephone.matches("^(13|15|18|14|17)[0-9]{9}$")){
			check(request, response, location, "手机号码不正确");
			return;
		}
		if(mSafetyManage.isPhone(mobilephone)){
			check(request, response, location, "手机号码存在");
			return;
		}
		//图片验证码
		VerifyCodeAuthentication authentication = new VerifyCodeAuthentication();
		/**添加注册验证码 2014-12-03 yangjh*/
		String verifyCode = request.getParameter("verifyCode");
		authentication.setVerifyCodeType("REGISTER");
		authentication.setVerifyCode(verifyCode);
		try {
			session.authenticateVerifyCode(authentication);
		} catch (AuthenticationException e) {
			prompt(request, response, PromptLevel.ERROR, e.getMessage());
			sendRedirect(request, response, location);
			return;
		}
		//邀请码
		String code = request.getParameter("code");
		//保存到session
		session.setAttribute("register_step1_accountName", accountName);
		session.setAttribute("register_step1_password", password);
		session.setAttribute("register_step1_mobilephone", mobilephone);
		session.setAttribute("register_step1_code", code);
		String partId = request.getParameter("partId");
		session.setAttribute("register_step1_partId", partId);
		sendRedirect(request, response,
				getResourceProvider().getResource(ConfigureProvider.class)
						.format(URLVariable.REGISTER_STEP_2));
	}

	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		throwable.printStackTrace();
		getResourceProvider().log(throwable.getMessage());
		ConfigureProvider configureProvider = getResourceProvider()
				.getResource(ConfigureProvider.class);
		String location = configureProvider.format(URLVariable.REGISTER)+KeepParam.keepParamByString(request, ignoreKeys);
		if (throwable instanceof SQLException) {
			prompt(request, response, PromptLevel.ERROR, "系统繁忙，请稍后再试");
			sendRedirect(request, response, location);
		} else {
			prompt(request, response, PromptLevel.ERROR, throwable.getMessage());
			sendRedirect(request, response, location);
		}
	}

	private void check(HttpServletRequest request,
			HttpServletResponse response, String location, String failDes) throws Throwable{
			prompt(request, response, PromptLevel.ERROR, failDes);
			sendRedirect(request, response, location);
	}
	
	private static List<String> ignoreKeys = new ArrayList<String>();
	
	static {
		ignoreKeys.add("password");
		ignoreKeys.add("newPassword");
		ignoreKeys.add("showPwd");
		ignoreKeys.add("showNewPwd");
		ignoreKeys.add("_a");
		ignoreKeys.add("iAgree");
		ignoreKeys.add("verifyCode");
	}
	
}
