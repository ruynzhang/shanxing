package com.dimeng.p2p.user.servlets.account;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.codec.digest.UnixCrypt;

import com.dimeng.framework.http.servlet.Controller;
import com.dimeng.framework.http.session.authentication.AuthenticationException;
import com.dimeng.framework.resource.ResourceProvider;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.account.user.service.SafetyManage;
import com.dimeng.p2p.account.user.service.entity.Safety;
import com.dimeng.p2p.user.servlets.Login;
import com.dimeng.util.StringHelper;

public class pdatetxPasswordajx extends AbstractAccountServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, final ServiceSession serviceSession)
			throws Throwable {
		SafetyManage safetyManage = serviceSession
				.getService(SafetyManage.class);
		Safety sa = safetyManage.get();
		PrintWriter out=response.getWriter();
		String newpassword = request.getParameter("new");
		 String utype = request.getParameter("utp");
		String istrue = serviceSession.getSession().getAttribute(utype+"is");
		if(StringHelper.isEmpty(istrue)){
			 out.write("09");
			return;
		}else if (StringHelper.isEmpty(newpassword)) {
			out.write("00");
			return;
		} else {
			if(sa.password.equals(UnixCrypt.crypt(newpassword,DigestUtils.sha256Hex(newpassword)))){
				out.write("01");
				return;
			} else {
				safetyManage.updateTxpassword(UnixCrypt.crypt(newpassword,DigestUtils.sha256Hex(newpassword)));
				out.write("03");
				return;
			}
		}
	}
	
	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		
		ResourceProvider resourceProvider = getResourceProvider();
		resourceProvider.log(throwable);
		PrintWriter out=response.getWriter();
		out.write(throwable.getMessage());
		
		if (throwable instanceof AuthenticationException) {
			Controller controller = getController();
			controller.redirectLogin(request, response,
					controller.getViewURI(request, Login.class));
		}
		
	}

}
