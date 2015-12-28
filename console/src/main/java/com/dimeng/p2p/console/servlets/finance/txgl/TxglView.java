package com.dimeng.p2p.console.servlets.finance.txgl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.p2p.modules.account.console.service.UserWithdrawalsManage;
import com.dimeng.p2p.modules.account.console.service.entity.UserWithdrawals;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_FINANCE_TXGLVIEW", name = "提现管理查看")
public class TxglView extends AbstractFinanceServlet {
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
		UserWithdrawalsManage extraction = serviceSession
				.getService(UserWithdrawalsManage.class);
		int id = IntegerParser.parse(request.getParameter("id"));
		UserWithdrawals txglRecord = extraction.get(id);
		request.setAttribute("txglRecord", txglRecord);
		forwardView(request, response, getClass());
	}
}
