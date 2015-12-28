package com.dimeng.p2p.console.servlets.finance.ptfxbyjgl;

import java.math.BigDecimal;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.LogicalException;
import com.dimeng.framework.service.exception.ParameterException;
import com.dimeng.p2p.modules.finance.console.service.PtfxbyjManage;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.util.StringHelper;
import com.dimeng.util.parser.BigDecimalParser;

@Right(id = "P2P_C_FINANCE_WITHDRAWALPTBYJ", name = "平台风险备用金提现")
public class WithdrawalPtbyj extends AbstractFinanceServlet {
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
		PtfxbyjManage ptfxbyjManage = serviceSession
				.getService(PtfxbyjManage.class);
		BigDecimal ammount = BigDecimalParser.parse(request
				.getParameter("ammount"));
		String remark = request.getParameter("remark");
		String message = "";
		try {
			ptfxbyjManage.withdrawal(ammount, remark);
		} catch (Throwable t) {
			if (t instanceof ParameterException
					|| t instanceof LogicalException) {
				message = t.getMessage();
			} else {
				super.onThrowable(request, response, t);
				return;
			}
		}
		StringBuffer sb = new StringBuffer(getController().getURI(request,
				PtfxbyjglList.class));
		if (!StringHelper.isEmpty(message)) {
			sb.append("?message=" + URLEncoder.encode(message, "UTF-8"));
		}
		sendRedirect(request, response, sb.toString());
	}
}
