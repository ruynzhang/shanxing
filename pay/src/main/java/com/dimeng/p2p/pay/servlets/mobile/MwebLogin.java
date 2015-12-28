package com.dimeng.p2p.pay.servlets.mobile;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.http.session.Session;
import com.dimeng.framework.http.session.SessionManager;
import com.dimeng.framework.http.session.authentication.AuthenticationException;
import com.dimeng.framework.http.session.authentication.PasswordAuthentication;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.account.user.service.UserInfoManage;
import com.dimeng.p2p.account.user.service.UserManage;
import com.dimeng.p2p.common.KeepParam;
import com.dimeng.p2p.pay.servlets.AbstractMobileServicer;
import com.dimeng.p2p.utlis.JfResource;
import com.dimeng.p2p.variables.defines.URLVariable;
import com.dimeng.util.StringHelper;

public class MwebLogin extends AbstractMobileServicer {

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
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		//判断是否登录和有跳转
		String referer = request.getParameter("_z");
		//serviceSession.getSession().isAuthenticated() &&
		if( serviceSession.getSession().isAuthenticated() && !StringHelper.isEmpty(referer)){
			sendRedirect(request, response, referer);
			return;
		}
		ConfigureProvider configureProvider = getResourceProvider().getResource(ConfigureProvider.class);
		if(!serviceSession.getSession().isAuthenticated() && !StringHelper.isEmpty(referer)){
		
			sendRedirect(request, response,
					getConfigureProvider().format(URLVariable.MWEB_LOGINWEB));
			return;
		}
		
		String postfix=KeepParam.keepParamByString(request,ignoreKeys);
		
		PasswordAuthentication authentication = new PasswordAuthentication();
		String accountname = request.getParameter("accountName");
		authentication.setAccountName(accountname);
		authentication.setPassword(request.getParameter("password"));
		authentication.setVerifyCode(request.getParameter("verifyCode"));
		authentication.setVerifyCodeType("LOGIN");
		{
			boolean rememberName = !StringHelper.isEmpty(request
					.getParameter("remember"));
			if (rememberName) {
				Cookie cookie = new Cookie("ACCOUNT_NAME", URLEncoder.encode(
						authentication.getAccountName(), "UTF-8"));
				cookie.setMaxAge(2592000);
				response.addCookie(cookie);
			}
		}
		try {
			
			
			
			
			
			Session session = getResourceProvider().getResource(
					SessionManager.class).getSession(request, response, true);
			session.checkIn(request, response, authentication);
			

			// 同步php 论坛
			final UserManage userManage = serviceSession
					.getService(UserManage.class);
			UserInfoManage userinfomanage = serviceSession
					.getService(UserInfoManage.class);
			final String accountName = userinfomanage.getUserName(session
					.getAccountId());
			final String password = request.getParameter("password");
			JfResource.threadPool.execute(new Runnable() {
				public void run() {
					try {
						// 同步积分商城
						userManage.getLoginClub(accountName, password);
					} catch (Throwable e) {
						e.printStackTrace();
					}
				}
			});
			
			// 增加积分 add by zhengxin 20150309
			String loginName = accountName;
			JfResource jfResource = getResourceProvider().getResource(
					JfResource.class);
			// 登录10天加积分
			jfResource.addCreditsByLogin(loginName);
			// end

			if (StringHelper.isEmpty(referer)) {
				sendRedirect(request, response,
						configureProvider.format(URLVariable.MWEB_LIST));
			} else {
				sendRedirect(request, response, referer);
			}

		} catch (AuthenticationException e) {
			getResourceProvider().log(e.getMessage());
			prompt(request, response, PromptLevel.ERROR, e.getMessage());
			sendRedirect(request, response,
					getConfigureProvider().format(URLVariable.MWEB_LOGINWEB)+postfix);
		}
	}
	
	private static List<String> ignoreKeys = new ArrayList<String>();
	
	static {
		ignoreKeys.add("password");
	}
}
