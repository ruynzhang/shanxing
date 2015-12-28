package com.dimeng.p2p.user.servlets.mobile;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.codec.digest.UnixCrypt;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.account.user.service.SafetyManage;
import com.dimeng.p2p.account.user.service.entity.Safety;
import com.dimeng.p2p.utlis.JfResource;
import com.dimeng.util.StringHelper;

public class UpdTxPassword extends AbstractMobileServlet {

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
		SafetyManage safetyManage = serviceSession.getService(SafetyManage.class);
		Safety sa = safetyManage.get();
		String oldpassword = request.getParameter("old");
		String newpassword = request.getParameter("new");
		try {
			safetyManage.isUpdateTxmm();
			if (StringHelper.isEmpty(oldpassword)) {
				print(response, "输入原密码");
				return;
			} 
			if (StringHelper.isEmpty(newpassword)) {
				print(response, "输入新密码");
				return;
			} 
			if (!UnixCrypt.crypt(oldpassword,DigestUtils.sha256Hex(oldpassword)).equals(sa.txpassword)) {
				safetyManage.udpatetxSize();
				print(response, "原密码错误");
				return;
			} 
			if(sa.password.equals(UnixCrypt.crypt(newpassword,DigestUtils.sha256Hex(newpassword)))){
				print(response, "不能和登录密码相同");
				return;
			} 
			safetyManage.updateTxpassword(UnixCrypt.crypt(newpassword,DigestUtils.sha256Hex(newpassword)));
			print(response, "提现密码修改成功");
			JfResource jfResource = getResourceProvider().getResource(JfResource.class);
			jfResource.addCredits(sa.username, 3, null, true);
		} catch (Throwable e) {
			print(response, e.getMessage());
		}
	}
	
	public void print(HttpServletResponse response,String msg) throws IOException{
		response.setContentType("text/html;charset="
				+ getResourceProvider().getCharset());
		response.getWriter().print(msg);
		response.getWriter().flush();
	}
}
