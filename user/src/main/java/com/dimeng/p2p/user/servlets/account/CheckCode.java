package com.dimeng.p2p.user.servlets.account;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.session.Session;
import com.dimeng.framework.http.session.authentication.AuthenticationException;
import com.dimeng.framework.http.session.authentication.VerifyCodeAuthentication;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.util.StringHelper;

public class CheckCode extends AbstractAccountServlet{
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, final ServiceSession serviceSession)
			throws Throwable {
		 PrintWriter out=response.getWriter();
		//校验对象
		 String codeType = request.getParameter("ctp");
		 if(StringHelper.isEmpty(codeType)){
			 out.write("01");
			 return; 
		 }
		String evenString = request.getParameter("evencheck");
		
		String code = request.getParameter("code");
		
		if(StringHelper.isEmpty(evenString)){
			out.write("01");
			return;
		}else if(StringHelper.isEmpty(code)){
			out.write("02");
			return;
		}else{
			Session session = serviceSession.getSession();
			VerifyCodeAuthentication verfycode = new VerifyCodeAuthentication();
			verfycode.setVerifyCodeType(codeType);
			verfycode.setVerifyCode(code);
			try {
				session.authenticateVerifyCode(verfycode);
			} catch (AuthenticationException e) {
				out.write("03");
				return;
			}
			session.invalidVerifyCode(codeType);
			serviceSession.getSession().setAttribute(codeType+"is", "true");
		}
		
	}
	
}
