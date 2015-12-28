package com.dimeng.p2p.front.servlets;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.config.Envionment;
import com.dimeng.framework.http.session.Session;
import com.dimeng.framework.message.sms.SmsSender;
import com.dimeng.framework.resource.ResourceRegister;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.account.front.service.PasswordManage;
import com.dimeng.p2p.variables.defines.MsgVariavle;
import com.dimeng.util.StringHelper;
import com.dimeng.util.parser.DateTimeParser;

/**
 * 
 * @description 获取手机验证码
 * @author Zheng Xin
 * @date 2014年11月19日
 *
 */
public class GetPhoneVerifyCode extends AbstractFrontServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * 是否需要校验登录状态
	 */
	@Override
	protected boolean mustAuthenticated() {
		return false;
	}

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
	}

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		String mobilephone = request.getParameter("mobilephone");
		String sessionMp = serviceSession.getSession().getAttribute("register_step1_mobilephone");
		if(sessionMp == null || !sessionMp.equals(mobilephone))
			return;
		PasswordManage passwordManage = serviceSession.getService(PasswordManage.class);
		if(!StringHelper.isEmpty(mobilephone) && mobilephone.matches("^(13|15|18|14|17)[0-9]{9}$")){
			int exist = passwordManage.phoneExist(mobilephone);
			if(exist > 0){
				return;
			}
//			String ip = getIpAddr(request);
//			int tag = passwordManage.isSendVerifyCode(ip, mobilephone, 50, 60, 6);
//			switch (tag) {
//			case 1:
//				System.out.println("该IP超过平台验证码发送限制， phone:" + mobilephone + ", ip:" + ip);
//				serviceSession.commit();
//				response.getWriter().write("{\"msg\":\"您的IP已被封\"}");
//				return;
//			case 2:
//				System.out.println("超过验证码发送限制， phone:" + mobilephone + ", ip:" + ip);
//				serviceSession.commit();
//				response.getWriter().write("{\"msg\":\"超过验证码发送限制\"}");
//				return;
//			}
			serviceSession.commit();
			ConfigureProvider configureProvider = ResourceRegister
					.getResourceProvider(getServletContext()).getResource(
							ConfigureProvider.class);
			SmsSender sender = serviceSession.getService(SmsSender.class);
			//获取验证码
			Session session = serviceSession.getSession();
			session.invalidVerifyCode("PHONEVERIFYCODE");
			String code = session.getVerifyCode("PHONEVERIFYCODE");
			//获取短信模版
			String template = configureProvider
					.getProperty(MsgVariavle.RIGISTER_VERIFIY_CODE);
			//设置模版占位符数据
			Envionment envionment = configureProvider.createEnvionment();
			envionment.set("date", DateTimeParser.format(new Timestamp(System
					.currentTimeMillis())));
			envionment.set("code", code);
//			System.out.println("手机" + mobilephone);
//			System.out.println("验证码" + code);
//			System.out.println("内容" + StringHelper.format(template, envionment));
			//发送短信
			sender.send(0, StringHelper.format(template, envionment), mobilephone);
		}
	}
	
	public String getIpAddr(HttpServletRequest request) { 
		String ip=request.getHeader("X-Real-IP"); 
		if(ip == null || ip.length() == 0) { 
			ip=request.getHeader("X-Forwarded-For"); 
		} 
	    if(ip == null || ip.length() == 0) { 
	        ip=request.getHeader("Proxy-Client-IP"); 
	    } 
	    if(ip == null || ip.length() == 0) { 
	        ip=request.getHeader("WL-Proxy-Client-IP"); 
	    } 
	    if(ip == null || ip.length() == 0) { 
	        ip=request.getRemoteAddr(); 
	    } 
	    return ip; 
	} 
}
