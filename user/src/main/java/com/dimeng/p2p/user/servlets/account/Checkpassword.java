package com.dimeng.p2p.user.servlets.account;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.codec.digest.UnixCrypt;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.account.user.service.SafetyManage;
import com.dimeng.p2p.account.user.service.entity.Safety;
import com.dimeng.util.StringHelper;

public class Checkpassword extends AbstractAccountServlet{
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, final ServiceSession serviceSession)
			throws Throwable {
		
		SafetyManage safetyManage = serviceSession.getService(SafetyManage.class);
		Safety sa = safetyManage.get();
		 PrintWriter out=response.getWriter();
		 String value = request.getParameter("value");
		if(StringHelper.isEmpty(value)){
			out.write("01");
			return;
		}
		String password = UnixCrypt.crypt(value,
				DigestUtils.sha256Hex(value));
		
		if(!password.equals(sa.txpassword)){
			out.write("01");
			return;	
		}
		
	}
	
}
