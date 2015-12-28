package com.dimeng.p2p.console.servlets.bid.lcgl.yxlcjh;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.modules.financial.console.service.PlanMoneyManage;
import com.dimeng.p2p.modules.financial.console.service.entity.PlanMoney;
import com.dimeng.p2p.modules.financial.console.service.query.PlanMoneyQuery;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_BUSINESS_YXLCJHLIST", isMenu=true, name = "优选理财计划")
public class PlanMoneyList extends AbstractBidServlet {
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
		
		PagingResult<PlanMoney> planMoneys = planMoneyManage.planMoneySearch(new PlanMoneyQuery() {
			
			@Override
			public String getState() {
				return request.getParameter("state");
			}
			
			@Override
			public String getPlanName() {
				return request.getParameter("planName");
			}
		}, new Paging() {
			
			@Override
			public int getSize() {
				return 10;
			}

			@Override
			public int getCurrentPage() {
				return IntegerParser.parse(request.getParameter(PAGING_CURRENT));
			}
		});
		 
		request.setAttribute("planMoneys", planMoneys);
		
		forwardView(request, response, getClass());
	}

}
