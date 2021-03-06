package com.dimeng.p2p.console.servlets.account.staff;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.console.servlets.account.AbstractAccountServlet;
import com.dimeng.p2p.modules.account.console.service.StaffManage;
import com.dimeng.p2p.modules.account.console.service.entity.Staff;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_ACCOUNT_YGLIST", isMenu=true, name = "人事管理")
public class YgList extends AbstractAccountServlet {

	private static final long serialVersionUID = 3681923409247225644L;
	@Override
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
		Staff query = new Staff();
		query.parse(request);//设置界面传来的参数
		//内部员工分页对象
		PagingResult<Staff> list = manage.search(query, new Paging() {
			@Override
			public int getSize() {
				return 10;
			}
			@Override
			public int getCurrentPage() {
				return IntegerParser.parse(request.getParameter(PAGING_CURRENT));
			}
		});
		request.setAttribute("list", list);
		forwardView(request, response, getClass());
	}
	
}
