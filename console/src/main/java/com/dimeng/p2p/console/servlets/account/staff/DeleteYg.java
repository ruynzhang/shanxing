package com.dimeng.p2p.console.servlets.account.staff;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.account.AbstractAccountServlet;
import com.dimeng.p2p.modules.account.console.service.StaffManage;

/**
 * 删除内部员工信息
 * @author yangjh
 *
 */
@Right(id = "P2P_C_ACCOUNT_DELETEYG", name = "删除员工信息")
public class DeleteYg extends AbstractAccountServlet {

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
		//根据id删除内部员工信息
		manage.delete(Integer.parseInt(request.getParameter("id")));
		//返回列表界面
		sendRedirect(request, response,getController().getURI(request, YgList.class));
	}
}
