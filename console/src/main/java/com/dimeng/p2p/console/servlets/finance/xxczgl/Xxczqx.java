package com.dimeng.p2p.console.servlets.finance.xxczgl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.p2p.modules.account.console.service.OfflineChargeManage;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_FINANCE_XXCZQX", name = "审核取消")
public class Xxczqx extends AbstractFinanceServlet {
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
		OfflineChargeManage chargeManage = serviceSession
				.getService(OfflineChargeManage.class);
		chargeManage.cancel(IntegerParser.parse(request.getParameter("id")));
		sendRedirect(request, response,
				getController().getURI(request, XxczglList.class));
	}
}
