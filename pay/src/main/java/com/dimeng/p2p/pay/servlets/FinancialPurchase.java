package com.dimeng.p2p.pay.servlets;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.resource.ResourceProvider;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.LogicalException;
import com.dimeng.framework.service.exception.ParameterException;
import com.dimeng.p2p.modules.bid.pay.service.FinancialPurchaseManage;
import com.dimeng.p2p.order.FinancialPurchaseExecutor;
import com.dimeng.p2p.variables.defines.URLVariable;
import com.dimeng.util.parser.BigDecimalParser;
import com.dimeng.util.parser.IntegerParser;

public class FinancialPurchase extends AbstractPayServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		BigDecimal amount = BigDecimalParser.parse(request
				.getParameter("gmMoney"));
		int yxId = IntegerParser.parse(request.getParameter("yxId"));
		FinancialPurchaseManage manage = serviceSession
				.getService(FinancialPurchaseManage.class);
		int orderId = manage.addOrder(yxId, amount);
		serviceSession.commit();
		FinancialPurchaseExecutor executor = getResourceProvider().getResource(
				FinancialPurchaseExecutor.class);
		executor.submit(orderId, null);
		executor.confirm(orderId, null);
		getController().prompt(request, response, PromptLevel.INFO, "恭喜你，投标成功");
		sendRedirect(request, response, getURL(yxId));
	}

	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		getResourceProvider().log(throwable.getMessage());
		int yxId = IntegerParser.parse(request.getParameter("yxId"));
		if (throwable instanceof ParameterException
				|| throwable instanceof SQLException) {
			throwable.printStackTrace();
			getController().prompt(request, response, PromptLevel.ERROR,
					"系统繁忙，请您稍后再试");
			sendRedirect(request, response, getURL(yxId));

		} else if (throwable instanceof LogicalException) {
			getController().prompt(request, response, PromptLevel.WARRING,
					throwable.getMessage());
			sendRedirect(request, response, getURL(yxId));
		} else {
			super.onThrowable(request, response, throwable);
		}
	}

	protected String getURL(int yxId) throws IOException {
		ResourceProvider resourceProvider = getResourceProvider();
		final ConfigureProvider configureProvider = resourceProvider
				.getResource(ConfigureProvider.class);
		StringBuilder url = new StringBuilder(
				configureProvider.format(URLVariable.FINANCING_YX_XQ));
		url.append(Integer.toString(yxId)).append(
				resourceProvider.getSystemDefine().getRewriter()
						.getViewSuffix());
		return url.toString();
	}
}
