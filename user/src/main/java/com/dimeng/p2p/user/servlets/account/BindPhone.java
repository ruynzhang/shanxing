package com.dimeng.p2p.user.servlets.account;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.http.session.Session;
import com.dimeng.framework.http.session.authentication.AuthenticationException;
import com.dimeng.framework.http.session.authentication.VerifyCodeAuthentication;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.account.user.service.SafetyManage;
import com.dimeng.p2p.account.user.service.UserManage;
import com.dimeng.p2p.variables.defines.URLVariable;
import com.dimeng.util.StringHelper;

public class BindPhone extends AbstractAccountServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, final ServiceSession serviceSession)
			throws Throwable {
		SafetyManage safetyManage = serviceSession
				.getService(SafetyManage.class);
		String phpne = request.getParameter("binphpne");
		String code = request.getParameter("bphoneCode");
		if (StringHelper.isEmpty(phpne)) {
			getController().prompt(request, response, PromptLevel.ERROR,
					"手机号码错误");
			sendRedirect(request, response,
					getController().getViewURI(request, Safetymsg.class));
			return;
		} else if (StringHelper.isEmpty(code)) {
			getController().prompt(request, response, PromptLevel.ERROR,
					"验证码错误");
			sendRedirect(request, response,
					getController().getViewURI(request, Safetymsg.class));
			return;
		} else {
			Session session = serviceSession.getSession();
			VerifyCodeAuthentication verfycode = new VerifyCodeAuthentication();
			verfycode.setVerifyCodeType("pband");
			verfycode.setVerifyCode(code);
			try {
				session.authenticateVerifyCode(verfycode);
			} catch (AuthenticationException e) {
				getController().prompt(request, response, PromptLevel.ERROR,
						"验证码错误");
				sendRedirect(request, response,
						getController().getViewURI(request, Safetymsg.class));
				return;
			}

			if (safetyManage.isPhone(phpne)) {
				getController().prompt(request, response, PromptLevel.ERROR,
						"手机号码已存在");
				sendRedirect(request, response,
						getController().getViewURI(request, Safetymsg.class));
				return;
			}
			session.invalidVerifyCode("eband");
			safetyManage.updatePhone(phpne);
			sendRedirect(request, response,
					getController().getViewURI(request, Safetymsg.class));
		}

		/**实名认证抽奖跳转;
		try {
			 String DateStr2 = "2014-12-04 10:00:00";
          //10点开放
			 DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	         Date date1 =dateFormat.parse(DateStr2);
	         Date datem =new Date();
	         String mpsa = dateFormat.format(datem);
	         Date date2 =dateFormat.parse(mpsa);
	         int  mgm = date2.compareTo(date1);
	         
	         ConfigureProvider configureProvider = getResourceProvider()
	 				.getResource(ConfigureProvider.class);
	 				UserManage userManage = serviceSession.getService(UserManage.class);
	 				int awarcount = userManage.getYnrenameAward();
	 				if(awarcount>0 && mgm>=0 && System.currentTimeMillis() < 1418572800000l){
	 					String accountName = userManage.getAccountName();
	 					serviceSession.getSession().setAttribute("UpdateNameStatus" + accountName, "1");
	 					sendRedirect(request, response, configureProvider.format(URLVariable.REGISTER_REALNAMEAWARDS));
	 				}else{
	 					sendRedirect(request, response,
	 							getController().getViewURI(request, Safetymsg.class));
	 				}
	          
			 }catch(Exception e){	
	        	 
	         }**/
	}

}
