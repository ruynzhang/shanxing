package com.dimeng.p2p.console.servlets.account.staff;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.account.AbstractAccountServlet;
import com.dimeng.p2p.modules.account.console.service.StaffManage;
import com.dimeng.p2p.modules.account.console.service.entity.Staff;

@Right(id = "P2P_C_ACCOUNT_ADDSTAFF", name = "新增员工")
public class AddStaff extends AbstractAccountServlet {
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
		try {
			StaffManage manage = serviceSession.getService(StaffManage.class);
			Staff entity=new Staff();
			entity.parse(request);//设置界面传来的参数
			//加添内部员工信息
			manage.addUser(serviceSession,entity);
			//返回列表界面
			sendRedirect(request, response,getController().getURI(request, YgList.class));
		} catch (Exception e) {
			prompt(request, response, PromptLevel.ERROR, e.getMessage());
			processGet(request, response, serviceSession);
		}
	}
}
