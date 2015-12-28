package com.dimeng.p2p.console.servlets.account.staff;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.account.AbstractAccountServlet;
import com.dimeng.p2p.modules.account.console.service.StaffManage;

/**
 * 查找参数是否存在
 * @author yangjh
 *
 */
public class IsExist extends AbstractAccountServlet {

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
		int num=Integer.valueOf(request.getParameter("num"));
		String str=request.getParameter("str");
		//1.用户名 2.推广码 3.手机号
		boolean flag=manage.isExist(num, str);
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().print(flag);
	}
}