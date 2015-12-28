package com.dimeng.p2p.console.servlets.spread.ywygl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.spread.AbstractSpreadServlet;
import com.dimeng.p2p.modules.salesman.console.service.SalesmanManage;
import com.dimeng.p2p.modules.salesman.console.service.entity.Salesman;
@Right(id = "P2P_C_SPREAD_TGXQ_XG", isMenu=true, name = "跳转修改业务员信息")
public class UpdateSalesman extends AbstractSpreadServlet{

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		
		final SalesmanManage manage = serviceSession.getService(SalesmanManage.class);
		Salesman salesman = manage.search(request.getParameter("ywyId"));
		
		request.setAttribute("salesman", salesman);
		forwardView(request, response, getClass());
	}
}
