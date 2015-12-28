package com.dimeng.p2p.console.servlets.account.staff;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.account.AbstractAccountServlet;
import com.dimeng.p2p.modules.account.console.service.StaffManage;
import com.dimeng.p2p.modules.account.console.service.entity.Staff;

/**
 * 添加内部员工信息
 * @author yangjh
 *
 */
@Right(id = "P2P_C_ACCOUNT_ADDYG", name = "晋升员工")
public class AddYg extends AbstractAccountServlet {

	private static final long serialVersionUID = 1L;
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		forwardView(request, response, getClass());
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			final HttpServletResponse response,
			final ServiceSession serviceSession) throws Throwable {
		StaffManage manage = serviceSession.getService(StaffManage.class);
		Staff entity=new Staff();
		entity.parse(request);//设置界面传来的参数
		manage.add(entity);//加添内部员工信息
		//返回列表界面
		sendRedirect(request, response,getController().getURI(request, YgList.class));
	}
}
