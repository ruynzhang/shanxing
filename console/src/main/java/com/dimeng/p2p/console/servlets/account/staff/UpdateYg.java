package com.dimeng.p2p.console.servlets.account.staff;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.account.AbstractAccountServlet;
import com.dimeng.p2p.modules.account.console.service.StaffManage;
import com.dimeng.p2p.modules.account.console.service.entity.Staff;

/**
 * 修改内部员工信息
 * @author yangjh
 *
 */
@Right(id = "P2P_C_ACCOUNT_UPDATEYG", name = "修改员工信息")
public class UpdateYg extends AbstractAccountServlet{
	
	private static final long serialVersionUID = 1L;
	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		StaffManage manage = serviceSession.getService(StaffManage.class);
		String id=request.getParameter("id");
		//根据id查询内部员工信息
		Staff entity= manage.queryById(Integer.parseInt(id));
		request.setAttribute("entity", entity);
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
			manage.update(entity);//更新信息
			sendRedirect(request, response,getController().getURI(request, YgList.class));
		} catch (Exception e) {
			prompt(request, response, PromptLevel.ERROR, e.getMessage());
			processGet(request, response, serviceSession);
		}
	}

}
