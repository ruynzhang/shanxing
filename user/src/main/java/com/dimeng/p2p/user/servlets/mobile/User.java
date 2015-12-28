package com.dimeng.p2p.user.servlets.mobile;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.service.MobileManage;
import com.dimeng.p2p.vo.UserBase;

/**
 * 用户账户设置
 * @author yangjh
 *
 */
public class User extends AbstractMobileServlet {

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
		Map<String, Object> resultMap=new HashMap<String, Object>();
		MobileManage manage=serviceSession.getService(MobileManage.class);
		UserBase userBase=manage.getUserBase();
		Map<String, Object> userBaseInfo=manage.getUserBaseInfo();
		resultMap.put("userName", userBase.userName);
		resultMap.put("phone", userBase.phoneNumber);
		resultMap.put("idCard", userBaseInfo.get("realName"));
		resultMap.put("withdrawPsw", userBaseInfo.get("withdrawPsw"));
		request.setAttribute("resultMap", resultMap);
		forwardView(request, response, getClass());
	}

}
