package com.dimeng.p2p.pay.servlets.mobile;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.config.Envionment;
import com.dimeng.framework.http.session.Session;
import com.dimeng.framework.http.session.SessionManager;
import com.dimeng.framework.http.session.authentication.AuthenticationException;
import com.dimeng.framework.http.session.authentication.PasswordAuthentication;
import com.dimeng.framework.http.session.authentication.VerifyCodeAuthentication;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S61.enums.T6141_F03;
import com.dimeng.p2p.common.KeepParam;
import com.dimeng.p2p.modules.account.pay.service.MobileSafetyManage;
import com.dimeng.p2p.modules.account.pay.service.UserManage;
import com.dimeng.p2p.modules.account.pay.service.entity.UserInsert;
import com.dimeng.p2p.pay.servlets.AbstractMobileServicer;
import com.dimeng.p2p.pay.servlets.M_register;
import com.dimeng.p2p.service.RedPacketManage;
import com.dimeng.p2p.service.TasteActivityManage;
import com.dimeng.p2p.utlis.JfResource;
import com.dimeng.p2p.utlis.JfUtil;
import com.dimeng.p2p.variables.defines.LetterVariable;
import com.dimeng.p2p.variables.defines.URLVariable;
import com.dimeng.util.StringHelper;
import com.dimeng.util.parser.EnumParser;

public class MwebRegisterStepTwo extends AbstractMobileServicer {
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
		Session session = serviceSession.getSession();
		ConfigureProvider configureProvider = getResourceProvider()
				.getResource(ConfigureProvider.class);
		if (session == null) {
			session = getResourceProvider().getResource(SessionManager.class)
					.getSession(request, response, true);
		}
		String location = configureProvider.format(URLVariable.MWEB_REGISTER2);
		MobileSafetyManage mSafetyManage = serviceSession
				.getService(MobileSafetyManage.class);
		final UserManage userManage = serviceSession
				.getService(UserManage.class);
		// 短信验证码
		VerifyCodeAuthentication authentication = new VerifyCodeAuthentication();
		String phoneVerifyCode = JfUtil.trimStr(request
				.getParameter("phoneVerifyCode"));
		authentication.setVerifyCodeType("PHONEVERIFYCODE");
		authentication.setVerifyCode(phoneVerifyCode);
		try {
			session.authenticateVerifyCode(authentication);
		} catch (AuthenticationException e) {
			prompt(request, response, PromptLevel.ERROR, e.getMessage());
			sendRedirect(request, response, location);
			return;
		}

		final String accountName = session
				.getAttribute("register_step1_accountName");
		final String password = session.getAttribute("register_step1_password");
		final String mobilephone = session
				.getAttribute("register_step1_mobilephone");
		final String code = session.getAttribute("register_step1_code");
		final String partId = session.getAttribute("register_step1_partId");

		UserInsert user = new UserInsert() {
			@Override
			public T6141_F03 getType() {
				return EnumParser.parse(T6141_F03.class,
						request.getParameter("type"));
			}

			@Override
			public String getPassword() {
				return password;
			}

			@Override
			public String getCode() {
				return code;
			}

			@Override
			public String getAccountName() {
				return accountName;
			}

			@Override
			public String getPhone() {
				return request.getParameter("phone");
			}

			@Override
			public String getName() {
				return request.getParameter("name");
			}

			@Override
			public String getUsername() {
				return null;
			}

			@Override
			public String getphcode() {
				return null;
			}
			
		};
		int userId = userManage.addUser(user,partId);
		final boolean[] tag = new boolean[1];
		if (userId > 0) {
			// 更新手机
			mSafetyManage.updatePhone(userId, mobilephone);
			// **** add by zhengxin 2014/11/28 给邀请人发送短信和站内信 *****
			if (!StringHelper.isEmpty(code)) {
				int parentUserId = mSafetyManage.getUserIdByCode(code);
				if (parentUserId > 0) {
					tag[0] = true;
					String letterTemplate = configureProvider
							.getProperty(LetterVariable.FRIEND_RIGISTER_EVENT);
					Envionment envionment = configureProvider
							.createEnvionment();
					// mSafetyManage.sendLetter(parentUserId, "邀请好友成功",
					// StringHelper.format(letterTemplate, envionment));

					TasteActivityManage manage = serviceSession
							.getService(TasteActivityManage.class);
					manage.sendLetter(parentUserId, "邀请好友成功",
							StringHelper.format(letterTemplate, envionment));
					// String parentPhone =
					// mSafetyManage.getPhoneByUserId(parentUserId);
					// if(parentPhone != null &&
					// !"".equals(parentPhone.trim())){
					// 发送短信给邀请人
					// SmsSender smsSender =
					// serviceSession.getService(SmsSender.class);
					// String template =
					// configureProvider.getProperty(MsgVariavle.FRIEND_RIGISTER_EVENT);
					// envionment = configureProvider.createEnvionment();
					// 发送
					// smsSender.send(0, StringHelper.format(template,
					// envionment), parentPhone);
					// }
				}
			}
			serviceSession.commit();
			// 登录
			PasswordAuthentication passwordAuthentication = new PasswordAuthentication();
			passwordAuthentication.setAccountName(accountName);
			passwordAuthentication.setPassword(password);
			passwordAuthentication.setVerifyCodeType("abc");
			passwordAuthentication.setVerifyCode(session
					.getVerifyCode(passwordAuthentication.getVerifyCodeType()));
			/**if (session != null) {
				session.invalidate(request, response);
			}**/
			session.checkIn(request, response, passwordAuthentication);
			session.removeAttribute("register_step1_accountName");
			session.removeAttribute("register_step1_password");
			session.removeAttribute("register_step1_mobilephone");
			session.removeAttribute("register_step1_code");
			RedPacketManage redPacketManage = serviceSession
					.getService(RedPacketManage.class);
			redPacketManage.sendRedPacket(serviceSession, 2, 1);

			final JfResource jfResource = getResourceProvider().getResource(
					JfResource.class);
			JfResource.threadPool.execute(new Runnable() {
				public void run() {
					try {
						// 同步php 论坛的uc
						// userManage.getRegisterPhp(accountName, password,
						// mobilephone);
						// 同步积分商城的uc
						userManage.getRegisterClub(accountName, password,
								mobilephone);
						// 增加积分 add by zhengxin 20150309
						// 登录10天加积分
						jfResource.addCreditsByLogin(accountName);
						// 注册送积分
						jfResource.addCredits(accountName, 16, null, true);
						if (tag[0]) {
							// 推荐人送积分
							jfResource.addCredits(accountName, 11, null, true);
							// 被推荐人送积分
							jfResource.addCredits(
									userManage.getUserNameByCode(code), 9,
									null, true);
						}
						// end
					} catch (Throwable e) {
						e.printStackTrace();
					}
				}
			});
			// end

			// sendRedirect(request, response,
			// getConfigureProvider().format(URLVariable.MWEB_REGISTERSTEP3));
			sendRedirect(request, response,
					getResourceProvider().getResource(ConfigureProvider.class)
							.format(URLVariable.MWEB_REGISTERSTEP3)
							+ "?accountName=" + accountName);
		}
	}

	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		logger.error(throwable);
		throwable.printStackTrace();
		getResourceProvider().log(throwable.getMessage());
		List<String> ignoreKeys = new ArrayList<String>();
		ignoreKeys.add("password");
		ignoreKeys.add("newPassword");
		ignoreKeys.add("showPwd");
		ignoreKeys.add("showNewPwd");
		ignoreKeys.add("_a");
		ignoreKeys.add("iAgree");
		ignoreKeys.add("verifyCode");
		String location = getController().getForwardURI(request,
				M_register.class)
				+ KeepParam.keepParamByString(request, ignoreKeys);
		if (throwable instanceof SQLException) {
			prompt(request, response, PromptLevel.ERROR, "系统繁忙，请稍后再试");
			sendRedirect(request, response, location);
		} else {
			prompt(request, response, PromptLevel.ERROR, throwable.getMessage());
			sendRedirect(request, response, location);
		}
	}

}
