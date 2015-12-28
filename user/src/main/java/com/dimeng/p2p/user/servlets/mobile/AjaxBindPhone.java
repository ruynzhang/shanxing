package com.dimeng.p2p.user.servlets.mobile;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.session.Session;
import com.dimeng.framework.http.session.authentication.AuthenticationException;
import com.dimeng.framework.http.session.authentication.VerifyCodeAuthentication;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.account.user.service.SafetyManage;
import com.dimeng.util.StringHelper;

public class AjaxBindPhone extends AbstractMobileServlet {

	private static final long serialVersionUID = 1L;
	
	@Override
	protected boolean mustAuthenticated() {
		return true;
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
		String phpne = request.getParameter("binphpne");
		String code = request.getParameter("bphoneCode");
		if(StringHelper.isEmpty(phpne) || !phpne.matches("^(13|15|18|14|17)[0-9]{9}$")){
			print(response, "手机号码不正确");
			return;
		}
		if (StringHelper.isEmpty(code)) {
			print(response, "验证码错误");
			return;
		}
		Session session = serviceSession.getSession();
		VerifyCodeAuthentication verfycode = new VerifyCodeAuthentication();
		verfycode.setVerifyCodeType("PHONEVERIFYCODE");
		verfycode.setVerifyCode(code);
		try {
			session.authenticateVerifyCode(verfycode);
		} catch (AuthenticationException e) {
			print(response, "验证码错误");
			return;
		}
		SafetyManage safetyManage = serviceSession.getService(SafetyManage.class);
		if (safetyManage.isPhone(phpne)) {
			print(response, "手机号码已存在");
			return;
		}
		safetyManage.updatePhone(phpne);
		print(response, "认证成功");
	}
	
	public void print(HttpServletResponse response,String msg) throws IOException{
		response.setContentType("text/html;charset="
				+ getResourceProvider().getCharset());
		response.getWriter().print(msg);
		response.getWriter().flush();
	}

}