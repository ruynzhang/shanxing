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
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.common.KeepParam;
import com.dimeng.p2p.modules.account.pay.service.MobileSafetyManage;
import com.dimeng.p2p.modules.account.pay.service.UserManage;
import com.dimeng.p2p.utlis.JfUtil;
import com.dimeng.p2p.variables.defines.URLVariable;
import com.dimeng.util.StringHelper;

public class M_register extends AbstractMobileServicer{
	
	private static final long serialVersionUID = 1L;

	@Override
	protected boolean mustAuthenticated() {
		return false;
	}

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
		ConfigureProvider configureProvider = getResourceProvider()
				.getResource(ConfigureProvider.class);
		Session session = serviceSession.getSession();
		if (session == null) {
			session = getResourceProvider().getResource(SessionManager.class)
					.getSession(request, response, true);
		}
		String location = configureProvider.format(URLVariable.M_REGISTER)+ KeepParam.keepParamByString(request, ignoreKeys);
		//用户名
		String accountName = JfUtil.trimStr(request.getParameter("accountName"));
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
		String password = JfUtil.trimStr(request.getParameter("password"));
		String newPassword = JfUtil.trimStr(request.getParameter("newPassword"));
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
		
		//邀请码
		String code = request.getParameter("code");
		if(!StringHelper.isEmpty(code) && mSafetyManage.getUserIdByCode(code)==0){
			check(request, response, location, "推广码输入有误");
			return;
		}
		
		//保存到session
		session.setAttribute("register_step1_accountName", accountName);
		session.setAttribute("register_step1_password", password);
		session.setAttribute("register_step1_mobilephone", mobilephone);
		session.setAttribute("register_step1_code", code);
		sendRedirect(request, response, getConfigureProvider().format(URLVariable.M_REGISTER2));
	}

	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		logger.error(throwable);
		throwable.printStackTrace();
		getResourceProvider().log(throwable.getMessage());
		String location =  getController().getForwardURI(request, M_register.class) + KeepParam.keepParamByString(request, ignoreKeys);
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
	}

}
