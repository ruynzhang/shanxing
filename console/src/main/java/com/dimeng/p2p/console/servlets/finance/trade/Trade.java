package com.dimeng.p2p.console.servlets.finance.trade;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.p2p.modules.account.console.service.TradeManage;
import com.dimeng.p2p.modules.account.console.service.entity.TradeVo;

@Right(id = "P2P_C_FINANCE_TRADE", name = "转账")
public class Trade extends AbstractFinanceServlet {
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
		TradeManage manage = serviceSession.getService(TradeManage.class);
		TradeVo vo=manage.getTrade(null);
		request.setAttribute("tradeVo", vo);
		forwardView(request, response, getClass());
	}
}