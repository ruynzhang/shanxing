package com.dimeng.p2p.pay.servlets;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

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
import com.dimeng.p2p.service.RedPacketManage;
import com.dimeng.p2p.service.TasteActivityManage;
import com.dimeng.p2p.utlis.JfResource;
import com.dimeng.p2p.utlis.JfUtil;
import com.dimeng.p2p.variables.defines.LetterVariable;
import com.dimeng.p2p.variables.defines.URLVariable;
import com.dimeng.util.StringHelper;
import com.dimeng.util.parser.EnumParser;

public class MobileRegisterAjax extends AbstractPayServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected boolean mustAuthenticated() {
		return false;
	}

	@Override
	protected void processGet(HttpServletRequest request, HttpServletResponse response, ServiceSession serviceSession) throws Throwable {
		processPost(request, response, serviceSession);
	}

	@Override
	protected void processPost(final HttpServletRequest request, HttpServletResponse response, ServiceSession serviceSession) throws Throwable {

		PrintWriter out = response.getWriter();//输出流
		response.setContentType("text/html;charset=" + getResourceProvider().getCharset());
		Session session = serviceSession.getSession();
		if (session == null) {
			session = getResourceProvider().getResource(SessionManager.class).getSession(request, response, true);
		}

		String location = "/mobile/mPartRegister.html" + KeepParam.keepParamByString(request, ignoreKeys);
		//用户名
		final String accountName = request.getParameter("accountName");
		if (StringHelper.isEmpty(accountName) || !accountName.matches("^([A-Za-z])([\\w]{5,17})$")) {
			check(request, response, location, "用户名必须为6-18个字符，使用字母、数字、下划线，需以字母开头");
			return;
		}
		UserManage userManager = serviceSession.getService(UserManage.class);
		boolean isResult = userManager.isAccountExists(accountName);
		if (isResult) {
			check(request, response, location, "用户名已存在");
			return;
		}
		//密码
		final String password = request.getParameter("password");

		if (StringHelper.isEmpty(password) || password.length() > 20 || password.length() < 6) {
			check(request, response, location, "密码必须为6~20个字符，区分大小写");
			return;
		}

		//手机
		MobileSafetyManage mSafetyManage = serviceSession.getService(MobileSafetyManage.class);
		final String mobilephone = request.getParameter("mobilephone");
		if (StringHelper.isEmpty(mobilephone) || !mobilephone.matches("^(13|15|18|14|17)[0-9]{9}$")) {
			check(request, response, location, "手机号码不正确");
			return;
		}
		if (mSafetyManage.isPhone(mobilephone)) {
			check(request, response, location, "手机号码存在");
			return;
		}
		//图片验证码
		VerifyCodeAuthentication authentication = new VerifyCodeAuthentication();
		/** 添加注册验证码 2014-12-03 yangjh */
		String verifyCode = request.getParameter("verifyCode");
		authentication.setVerifyCodeType("REGISTER");
		authentication.setVerifyCode(verifyCode);
		try {
			session.authenticateVerifyCode(authentication);
		} catch (AuthenticationException e) {
			prompt(request, response, PromptLevel.ERROR, e.getMessage());
			sendRedirect(request, response, location);
			StringBuilder sb = new StringBuilder();
			sb.append("{'num':00,'msg':'");
			sb.append("" + e.getMessage() + "" + "'}");
			out.write(sb.toString());
			return;
		}
		//邀请码
		final String code = request.getParameter("code");
		//保存到session
		session.setAttribute("register_step1_accountName", accountName);
		session.setAttribute("register_step1_password", password);
		session.setAttribute("register_step1_mobilephone", mobilephone);
		session.setAttribute("register_step1_code", code);
		String partId = request.getParameter("partId");
		session.setAttribute("register_step1_partId", partId);
		response.getWriter().print(true);
		response.getWriter().flush();


		ConfigureProvider configureProvider = getResourceProvider().getResource(ConfigureProvider.class);
		if (session == null) {
			session = getResourceProvider().getResource(SessionManager.class).getSession(request, response, true);
		}
		final UserManage userManage = serviceSession.getService(UserManage.class);

		UserInsert user = new UserInsert() {
			@Override
			public T6141_F03 getType() {
				return EnumParser.parse(T6141_F03.class, request.getParameter("type"));
			}

			@Override
			public String getPassword() {
				return password;
			}

			@Override
			public String getCode() {
				return "";
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

		int userId = userManage.addUser(user, partId);
		final boolean[] tag = new boolean[1];
		if (userId > 0) {
			//更新手机
			mSafetyManage.updatePhone(userId, mobilephone);
			//**** add by zhengxin 2014/11/28 给邀请人发送短信和站内信 *****
			if (!StringHelper.isEmpty(code)) {
				int parentUserId = mSafetyManage.getUserIdByCode(code);
				if (parentUserId > 0) {
					tag[0] = true;
					String letterTemplate = configureProvider.getProperty(LetterVariable.FRIEND_RIGISTER_EVENT);
					Envionment envionment = configureProvider.createEnvionment();
					//mSafetyManage.sendLetter(parentUserId, "邀请好友成功", StringHelper.format(letterTemplate, envionment));
					TasteActivityManage manage = serviceSession.getService(TasteActivityManage.class);
					manage.sendLetter(parentUserId, "邀请好友成功", StringHelper.format(letterTemplate, envionment));
					// end
					//					String parentPhone = mSafetyManage.getPhoneByUserId(parentUserId);
					//					if(parentPhone != null && !"".equals(parentPhone.trim())){
					//发送短信给邀请人
					//						SmsSender smsSender = serviceSession.getService(SmsSender.class);
					//						String template = configureProvider.getProperty(MsgVariavle.FRIEND_RIGISTER_EVENT);
					//						envionment = configureProvider.createEnvionment();
					//发送
					//						smsSender.send(0, StringHelper.format(template, envionment), parentPhone);
					//					}
				}
			}
			serviceSession.commit();

			//登录
			PasswordAuthentication passwordAuthentication = new PasswordAuthentication();
			passwordAuthentication.setAccountName(accountName);
			passwordAuthentication.setPassword(password);
			passwordAuthentication.setVerifyCodeType("abc");
			passwordAuthentication.setVerifyCode(session.getVerifyCode(passwordAuthentication.getVerifyCodeType()));
			if (session != null) {
				session.invalidate(request, response);
			}
			session.checkIn(request, response, passwordAuthentication);
			session.removeAttribute("register_step1_accountName");
			session.removeAttribute("register_step1_password");
			session.removeAttribute("register_step1_mobilephone");
			session.removeAttribute("register_step1_code");

			if (JfUtil.isActivity()) {
				//注册送体验金
				userManage.addTyjnum2(userId);
			}
			//******************************************
			final JfResource jfResource = getResourceProvider().getResource(JfResource.class);
			JfResource.threadPool.execute(new Runnable() {
				public void run() {
					try {
						//同步php 论坛的uc
						//userManage.getRegisterPhp(accountName, password, mobilephone);
						//同步积分商城的uc
						userManage.getRegisterClub(accountName, password, mobilephone);
						//增加积分 add by zhengxin 20150309
						//登录10天加积分
						jfResource.addCreditsByLogin(accountName);
						//注册送积分
						jfResource.addCredits(accountName, 16, null, true);
						if (tag[0]) {
							//推荐人送积分
							jfResource.addCredits(accountName, 11, null, true);
							// 被推荐人送积分
							jfResource.addCredits(userManage.getUserNameByCode(code), 9, null, true);
						}
						// end
					} catch (Throwable e) {
						e.printStackTrace();
					}
				}
			});

			RedPacketManage redPacketManage = serviceSession.getService(RedPacketManage.class);
			redPacketManage.sendRedPacket(serviceSession, 2, 1);

			//返回用户名
			response.getWriter().print(accountName);
			response.getWriter().flush();

		}
	}

	private void check(HttpServletRequest request, HttpServletResponse response, String location, String failDes) throws Throwable {
		prompt(request, response, PromptLevel.ERROR, failDes);
		PrintWriter out = response.getWriter();//输出流
		StringBuilder sb = new StringBuilder();
		sb.append("{'num':00,'msg':'");
		sb.append("" + failDes + "" + "'}");
		out.write(sb.toString());
	}

	private static List<String> ignoreKeys = new ArrayList<String>();

	static {
		ignoreKeys.add("password");
		ignoreKeys.add("_a");
		ignoreKeys.add("iAgree");
		ignoreKeys.add("yzm");
	}

}
