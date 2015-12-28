package com.dimeng.p2p.pay.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.config.Envionment;
import com.dimeng.framework.http.session.Session;
import com.dimeng.framework.message.sms.SmsSender;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.resource.ResourceRegister;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.modules.account.pay.service.MobileSafetyManage;
//import com.dimeng.p2p.pay.util.SmsSender;
import com.dimeng.p2p.variables.defines.MsgVariavle;
import com.dimeng.p2p.variables.defines.URLVariable;
import com.dimeng.util.StringHelper;
import com.dimeng.util.parser.DateTimeParser;

public class SendMobileVerifyCode extends AbstractPayServlet{

	private static final long serialVersionUID = 1L;
	
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
			HttpServletResponse response, ServiceSession serviceSession) throws Throwable {
		String phone = request.getParameter("phone");//手机号码
		PrintWriter out = response.getWriter();//输出流
		//判断手机号码参数是否存在
		if (!StringHelper.isEmpty(phone) && phone.matches("^(13|15|18|14|17)[0-9]{9}$")) {
			ConfigureProvider configureProvider = ResourceRegister
					.getResourceProvider(getServletContext()).getResource(
							ConfigureProvider.class);
			SmsSender smsSender = serviceSession.getService(SmsSender.class);
			MobileSafetyManage mSafetyManage = serviceSession.getService(MobileSafetyManage.class);
			String tem = null;
			String senType = null;
			
			//判断数据库中是否存在该手机号码
			if (mSafetyManage.isPhone(phone)) {
				StringBuilder sb = new StringBuilder();
				sb.append("{'num':00,'msg':'");
				sb.append("手机号码已存在" + "'}");
				out.write(sb.toString());
				return;
			}
			String ip = getIpAddr(request);
			int tag = mSafetyManage.isSendVerifyCode(ip, phone, 50, 60, 6);
			switch (tag) {
			case 1:
				System.out.println("该IP超过平台验证码发送限制， phone:" + phone + ", ip:" + ip);
				serviceSession.commit();
				response.getWriter().write("{\"msg\":\"您的IP已被封\"}");
				return;
			case 2:
				System.out.println("超过验证码发送限制， phone:" + phone + ", ip:" + ip);
				serviceSession.commit();
				response.getWriter().write("{\"msg\":\"超过验证码发送限制\"}");
				return;
			}
			serviceSession.commit();
			tem = configureProvider
					.getProperty(MsgVariavle.RIGISTER_VERIFIY_CODE);
			senType = "MOBILEVCODE";
			Envionment envionment = configureProvider.createEnvionment();
			Session session = serviceSession.getSession();
			//获取验证码
			String code = session.getVerifyCode(senType);
			envionment.set("date", DateTimeParser.format(new Timestamp(System
					.currentTimeMillis())));
			envionment.set("code", code);
			//发送
			smsSender.send(0, StringHelper.format(tem, envionment), phone);
		}
    }
	
	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		throwable.printStackTrace();
		getResourceProvider().log(throwable.getMessage());
		ConfigureProvider configureProvider = getResourceProvider()
				.getResource(ConfigureProvider.class);
		String location = configureProvider.format(URLVariable.REGISTER_MOBILE);
		if (throwable instanceof SQLException) {
			prompt(request, response, PromptLevel.ERROR, "系统繁忙，请稍后再试");
			sendRedirect(request, response, location);
		} else {
			prompt(request, response, PromptLevel.ERROR, throwable.getMessage());
			sendRedirect(request, response, location);
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
