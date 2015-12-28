package com.dimeng.p2p.console.servlets.account.staff;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.account.AbstractAccountServlet;
import com.dimeng.p2p.modules.account.console.service.StaffManage;
import com.dimeng.p2p.modules.account.console.service.entity.Staff;

/**
 * 获得用户信息
 * @author yangjh
 *
 */
public class GetStaff extends AbstractAccountServlet {

	private static final long serialVersionUID = 1L;
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			final HttpServletResponse response,
			final ServiceSession serviceSession) throws Throwable {
		StaffManage manage = serviceSession.getService(StaffManage.class);
		String phone=request.getParameter("str");
		//根据手机查询用户信息
		Staff entity=manage.getUserByPhone(phone);
		String str="1";
		if(null!=entity){
			str=entity.userName+","+entity.ucode;
		}
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().print(str); 
	}

}
