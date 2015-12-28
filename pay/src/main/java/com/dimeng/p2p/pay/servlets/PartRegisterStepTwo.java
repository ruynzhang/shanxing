package com.dimeng.p2p.pay.servlets;

import java.io.PrintWriter;

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
import com.dimeng.p2p.modules.account.pay.service.MobileSafetyManage;
import com.dimeng.p2p.modules.account.pay.service.UserManage;
import com.dimeng.p2p.modules.account.pay.service.entity.UserInsert;
import com.dimeng.p2p.service.RedPacketManage;
import com.dimeng.p2p.service.TasteActivityManage;
import com.dimeng.p2p.utlis.JfResource;
import com.dimeng.p2p.utlis.JfUtil;
import com.dimeng.p2p.variables.defines.LetterVariable;
import com.dimeng.util.StringHelper;
import com.dimeng.util.parser.EnumParser;

public class PartRegisterStepTwo extends AbstractPayServlet {
	
	private static final long serialVersionUID = 1L;

	@Override
	protected boolean mustAuthenticated() {
		return false;
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		
		PrintWriter out = response.getWriter();//输出流
		response.setContentType("text/html;charset="
				+ getResourceProvider().getCharset());
		
		Session session = serviceSession.getSession();
		ConfigureProvider configureProvider = getResourceProvider()
				.getResource(ConfigureProvider.class);
		if (session == null) {
			session = getResourceProvider().getResource(SessionManager.class)
					.getSession(request, response, true);
		}
		MobileSafetyManage mSafetyManage = serviceSession.getService(MobileSafetyManage.class);
		final UserManage userManage = serviceSession.getService(UserManage.class);
		//短信验证码
		VerifyCodeAuthentication authentication = new VerifyCodeAuthentication();
		String phoneVerifyCode = request.getParameter("phoneVerifyCode");
		authentication.setVerifyCodeType("PHONEVERIFYCODE");
		authentication.setVerifyCode(phoneVerifyCode);
		try {
			session.authenticateVerifyCode(authentication);
		} catch (AuthenticationException e) {
			prompt(request, response, PromptLevel.ERROR, e.getMessage());
			StringBuilder sb = new StringBuilder();
			sb.append("{'num':0,'msg':'");
			sb.append("验证码错误" + "'}");
			out.write(sb.toString());
			return;
		}
		
		final String accountName = session.getAttribute("register_step1_accountName");
		final String password = session.getAttribute("register_step1_password");
		final String mobilephone = session.getAttribute("register_step1_mobilephone");
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
			//更新手机
			mSafetyManage.updatePhone(userId, mobilephone);
			//**** add by zhengxin 2014/11/28 给邀请人发送短信和站内信 *****
			if(!StringHelper.isEmpty(code)){
				int parentUserId = mSafetyManage.getUserIdByCode(code);
				if(parentUserId > 0){
					tag[0] = true;
					String letterTemplate = configureProvider.getProperty(LetterVariable.FRIEND_RIGISTER_EVENT);
					Envionment envionment = configureProvider.createEnvionment();
					//mSafetyManage.sendLetter(parentUserId, "邀请好友成功", StringHelper.format(letterTemplate, envionment));
					TasteActivityManage manage=serviceSession.getService(TasteActivityManage.class);
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
			passwordAuthentication.setVerifyCode(session
					.getVerifyCode(passwordAuthentication.getVerifyCodeType()));
			if(session!=null){
				session.invalidate(request, response);
			}
			session.checkIn(request, response, passwordAuthentication);
			session.removeAttribute("register_step1_accountName");
			session.removeAttribute("register_step1_password");
			session.removeAttribute("register_step1_mobilephone");
			session.removeAttribute("register_step1_code");
			
			if(JfUtil.isActivity()){
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
						if(tag[0]){
							//推荐人送积分
							jfResource.addCredits(accountName, 11, null, true);
							//被推荐人送积分
							jfResource.addCredits(userManage.getUserNameByCode(code), 9, null, true);
						}
						// end
					} catch (Throwable e) {
						e.printStackTrace();
					}
				}
			});
			
			RedPacketManage redPacketManage = serviceSession.getService(RedPacketManage.class);
			redPacketManage.sendRedPacket(serviceSession,2, 1);
			
			StringBuilder sb = new StringBuilder();
			sb.append("{'num':1,'msg':'");
			sb.append("" + accountName + "" + "'}");
			out.write(sb.toString());
		}
	}
}