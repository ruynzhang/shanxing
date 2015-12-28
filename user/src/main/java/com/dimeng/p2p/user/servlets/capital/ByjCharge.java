package com.dimeng.p2p.user.servlets.capital;

import java.math.BigDecimal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.LogicalException;
import com.dimeng.framework.service.exception.ParameterException;
import com.dimeng.p2p.account.user.service.FxbyjManage;
import com.dimeng.p2p.order.BondExecutor;
import com.dimeng.p2p.user.servlets.Index;
import com.dimeng.util.parser.BigDecimalParser;

public class ByjCharge extends AbstractCapitalServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(final HttpServletRequest request,
			final HttpServletResponse response,
			final ServiceSession serviceSession) throws Throwable {
		try {
			FxbyjManage fxbyjManage = serviceSession
					.getService(FxbyjManage.class);
			BigDecimal amount = BigDecimalParser.parse(request
					.getParameter("amount"));
			int orderId = fxbyjManage.recharge(amount);
			serviceSession.commit();
			BondExecutor bondExecutor = getResourceProvider().getResource(
					BondExecutor.class);
			bondExecutor.submit(orderId, null);
			bondExecutor.confirm(orderId, null);
			sendRedirect(request, response,
					getController().getURI(request, Index.class));
		} catch (Throwable throwable) {
			if (throwable instanceof LogicalException
					|| throwable instanceof ParameterException) {
				getController().prompt(request, response, PromptLevel.WARRING,
						throwable.getMessage());
				sendRedirect(request, response,
						getController().getViewURI(request, getClass()));
			}
		}
	}
}
