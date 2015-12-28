package com.dimeng.p2p.console.servlets.bid.lcgl.yxlcjh;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.modules.financial.console.service.PlanMoneyManage;
import com.dimeng.p2p.modules.financial.console.service.entity.PlanMoneyView;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_BUSINESS_YXLCJHVIEW", name = "查询优选理财计划详情")
public class ViewPlanMoney extends AbstractBidServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}
	
	@Override
	protected void processPost(final HttpServletRequest request,final HttpServletResponse response,
			final ServiceSession serviceSession) throws Throwable {
		PlanMoneyManage planMoneyManage = serviceSession.getService(PlanMoneyManage.class);
		int planMoneyId = IntegerParser.parse(request.getParameter("planMoneyId"));
		PlanMoneyView planMoneyView = planMoneyManage.findPlanMoneyView(planMoneyId);
		
		request.setAttribute("planMoneyView", planMoneyView);
		
		forwardView(request, response, getClass());
	}

}
