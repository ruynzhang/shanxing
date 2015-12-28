package com.dimeng.p2p.user.servlets.mobile;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.account.user.service.SafetyManage;
import com.dimeng.p2p.common.enums.AttestationState;
import com.dimeng.p2p.modules.gzt.service.NciicManage;
import com.dimeng.p2p.service.TasteActivityManage;
import com.dimeng.p2p.utlis.JfResource;
import com.dimeng.util.StringHelper;

public class UpdIdentity extends AbstractMobileServlet {

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
		String idcard = request.getParameter("idCard");
		String name = request.getParameter("name");
		try {
			SafetyManage safetyManage = serviceSession.getService(SafetyManage.class);
			if (StringHelper.isEmpty(idcard) || StringHelper.isEmpty(name)) {
				print(response, "用户名和身份证号码不能为空");
				return;
			}
			NciicManage nic = serviceSession.getService(NciicManage.class);
			boolean is = nic.check(idcard, name);
			if (!is) {
				print(response, "实名认证失败");
				return;
			}
			if (safetyManage.isIdcard(idcard)) {
				print(response, "该身份证已认证过！");
				return;
			}
			safetyManage.updateName(name, idcard,AttestationState.YYZ.name());
			print(response, "实名认证成功");
		} catch (Throwable e) {
			print(response, e.getMessage());
		}
		int userId=serviceSession.getSession().getAccountId();
		TasteActivityManage manage=serviceSession.getService(TasteActivityManage.class);
		/**积分处理*/
		JfResource jfResource = getResourceProvider().getResource(JfResource.class);
		jfResource.addCredits(manage.getUserName(userId), 2, "idcard="+idcard, true);
	}
	
	public void print(HttpServletResponse response,String msg) throws IOException{
		response.setContentType("text/html;charset="
				+ getResourceProvider().getCharset());
		response.getWriter().print(msg);
		response.getWriter().flush();
	}
}