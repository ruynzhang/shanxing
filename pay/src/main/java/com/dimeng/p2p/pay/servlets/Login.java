package com.dimeng.p2p.pay.servlets;

import java.net.URLEncoder;

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
import com.dimeng.p2p.modules.account.pay.service.UserManage;
import com.dimeng.p2p.variables.defines.URLVariable;
import com.dimeng.util.StringHelper;

/**
 * 手机登陆时的操作
 * @description TODO
 * @author wuyongchang
 * @date 2014年12月12日
 *
 */

public class Login extends AbstractPayServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected boolean mustAuthenticated() {
		return false;
	}

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		PasswordAuthentication authentication = new PasswordAuthentication();
		String accountname = request.getParameter("accountName");
		authentication.setAccountName(accountname);
		authentication.setPassword(request.getParameter("password"));
		Session session1 = serviceSession.getSession();
		// 获取验证码
		String code = session1.getVerifyCode("MOBILELOGIN");
		authentication.setVerifyCode(code);
		authentication.setVerifyCodeType("MOBILELOGIN");
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
			String referer = request.getParameter("_z");
			if (StringHelper.isEmpty(referer)) {
				// 跳转到抽奖页面的处理
				UserManage userManage = serviceSession
						.getService(UserManage.class);
				// 获取手机号码
				String phone = userManage.getphonecode(accountname);
				request.setAttribute("phone", phone);
				// 跳转到抽奖页面
				forwardController(request, response, Award.class);
			} else {
				sendRedirect(request, response, referer);
			}
		} catch (AuthenticationException e) {
			getResourceProvider().log(e.getMessage());
			prompt(request, response, PromptLevel.ERROR,
					e.getMessage());

			if (!StringHelper.isEmpty(request.getParameter("type"))) {

				final ConfigureProvider configureProvider = getResourceProvider()
						.getResource(ConfigureProvider.class);
				sendRedirect(request, response, configureProvider
						.format(URLVariable.LOGIN_MOBILESUBMIT3));
				return;
			}

			sendRedirect(request, response, getController().getViewURI(request, M_login.class));
		}
	}
	
	
}
