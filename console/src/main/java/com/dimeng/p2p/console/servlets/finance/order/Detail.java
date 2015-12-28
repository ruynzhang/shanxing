package com.dimeng.p2p.console.servlets.finance.order;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S65.entities.T6550;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.p2p.modules.account.console.service.OrderManager;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_FINANCE_DETAILORDER", isMenu = true, name = "订单异常日志详情")
public class Detail extends AbstractFinanceServlet {
	private static final long serialVersionUID = 1L;

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
		int id = IntegerParser.parse(request.getParameter("id"));
		OrderManager orderManager = serviceSession
				.getService(OrderManager.class);
		T6550 t6550 = orderManager.get(id);
		request.setAttribute("t6550", t6550);
		forwardView(request, response, getClass());
	}
}
