package com.dimeng.p2p.user.servlets;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.http.servlet.Controller;
import com.dimeng.framework.http.session.Session;
import com.dimeng.framework.http.session.SessionManager;
import com.dimeng.framework.http.session.authentication.AuthenticationException;
import com.dimeng.framework.http.session.authentication.PasswordAuthentication;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.account.user.service.UserInfoManage;
import com.dimeng.p2p.account.user.service.UserManage;
import com.dimeng.p2p.common.KeepParam;
import com.dimeng.p2p.utlis.JfResource;
import com.dimeng.p2p.variables.defines.URLVariable;
import com.dimeng.util.StringHelper;

public class Loginclub extends AbstractUserServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected boolean mustAuthenticated() {
		return false;
	}

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		/**
		 * begin
		 * 善林荟跳转路径的处理
		 */
		String slhurl =request.getParameter("slhurl");
		request.setAttribute("slhurl", slhurl);
		//end
		String userName=request.getParameter("accountName");
		/***体验金活动*/
//		TasteActivityManage activityManage=serviceSession.getService(TasteActivityManage.class);
//		Object obj=MerCached.client.get(MerCached.AC_PREFIX+activityManage.getUserName(userName));
//		String activityCode=obj==null?"":obj.toString();
//		if(JfUtil.isNull(activityCode)){
//			activityCode=request.getParameter("activityCode");
//		}
//		boolean fff=activityCode.equals(JfUtil.properties.getProperty("activityCode"));
//		if(!fff && !activityCode.equals("内测码") && !activityCode.equals("")){
//			getController().prompt(request, response,PromptLevel.ERROR, "您输入的内测码有误,请重新输入");
//			sendRedirect(request, response,getController().getViewURI(request, Loginclub.class) + KeepParam.keepParamByString(request, ignoreKeys));
//			return;
//		}
		/***体验金活动*/
		
		PasswordAuthentication authentication = new PasswordAuthentication();
		authentication.setAccountName(userName);
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
		Controller controller = getController();
		try {
			Session session = getResourceProvider().getResource(
					SessionManager.class).getSession(request, response, true);
			if(session!=null){
				session.invalidate(request, response);
			}
			session.checkIn(request, response, authentication);


			String referer = request.getParameter("_z");
			//同步php 论坛
			final UserManage userManage = serviceSession.getService(UserManage.class);
			UserInfoManage userinfomanage = serviceSession.getService(UserInfoManage.class);
			final String accountName = userinfomanage.getUserName(session.getAccountId());
			final String password = request.getParameter("password");
			userManage.getLoginPhp(accountName, password);
			//同步积分商城
			userManage.getLoginClub(accountName, password);
			/**JfResource.threadPool.execute(new Runnable() {
				public void run() {
					try {
						userManage.getLoginPhp(accountName, password);
						//同步积分商城
						//userManage.getLoginClub(accountName, password);
					} catch (Throwable e) {
						e.printStackTrace();
					}
				}
			});**/
			//增加积分 add by zhengxin 20150309
			String loginName = accountName;
			JfResource jfResource = getResourceProvider().getResource(JfResource.class);
			//登录10天加积分
			jfResource.addCreditsByLogin(loginName);
			// end
			
//			/**奖内测码保存到缓存中*/
//			if(obj==null && fff){
//				MerCached.client.set(MerCached.AC_PREFIX+loginName, 60*60*24*30,activityCode);
//			}
			
			//活动抽奖
//			String activity=request.getParameter("_a");
//			if("yes".equals(activity)){
//				String url=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+"/pay/activity.htm";
//				controller.sendRedirect(request, response,url);
//				return;
//			}
			if (StringHelper.isEmpty(referer)) {
				@SuppressWarnings("unused")
				ConfigureProvider configureProvider = getResourceProvider()
						.getResource(ConfigureProvider.class);
				//controller.sendRedirect(request, response, configureProvider.format(URLVariable.USER_UCCLUB));
				//controller.forward(request, response, Ucclub.class);
				forward(request, response,getController().getViewURI(request, Ucclub.class));
				
			} else {
				controller.sendRedirect(request, response, referer);
			}
		} catch (AuthenticationException e) {
			List<String> ignoreKeys = new ArrayList<String>();
			ignoreKeys.add("password");
			ignoreKeys.add("showPwd");
			ignoreKeys.add("_a");
			ignoreKeys.add("verifyCode");
			
			getResourceProvider().log(e.getMessage());
			controller.prompt(request, response, PromptLevel.ERROR,
					e.getMessage());
			if(!StringHelper.isEmpty(request
					.getParameter("type"))){
				
				final ConfigureProvider configureProvider = getResourceProvider()
						.getResource(ConfigureProvider.class);
				controller.sendRedirect(request, response,configureProvider.format(URLVariable.INDEX));
				return;
			}
			
			sendRedirect(request, response,
					controller.getViewURI(request, Loginclub.class) + KeepParam.keepParamByString(request, ignoreKeys));
		}
	}
	private static List<String> ignoreKeys = new ArrayList<String>();
	
	static {
		ignoreKeys.add("password");
		ignoreKeys.add("showPwd");
		ignoreKeys.add("_a");
		ignoreKeys.add("verifyCode");
	}

}
