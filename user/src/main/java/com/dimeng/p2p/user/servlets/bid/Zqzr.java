package com.dimeng.p2p.user.servlets.bid;

import java.io.IOException;
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
import com.dimeng.p2p.modules.bid.user.service.TenderTransferManage;
import com.dimeng.p2p.order.TenderExchangeExecutor;
import com.dimeng.p2p.variables.defines.SystemVariable;
import com.dimeng.p2p.variables.defines.URLVariable;
import com.dimeng.util.parser.BooleanParser;
import com.dimeng.util.parser.IntegerParser;

public class Zqzr extends AbstractBidServlet {

	private static final long serialVersionUID = 904758214711922809L;

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		ResourceProvider resourceProvider = getResourceProvider();
		final ConfigureProvider configureProvider = resourceProvider
				.getResource(ConfigureProvider.class);
		try {
			int zcbId = IntegerParser.parse(request.getParameter("zqzrId"));
			TenderTransferManage transferManage = serviceSession
					.getService(TenderTransferManage.class);
			int orderId = transferManage.purchase(zcbId);
			serviceSession.commit();
			Boolean tg = BooleanParser.parseObject(configureProvider
					.getProperty(SystemVariable.SFZJTG));
			TenderExchangeExecutor executor = getResourceProvider()
					.getResource(TenderExchangeExecutor.class);
			executor.submit(orderId, null);
			if (!tg) {
				executor.confirm(orderId, null);
			}
			getController().prompt(request, response, PromptLevel.INFO,
					"恭喜你，购买成功");
			sendRedirect(request, response,
					configureProvider.format(URLVariable.FINANCING_ZQZR));
		} catch (Throwable throwable) {
			if (throwable instanceof LogicalException
					|| throwable instanceof ParameterException) {
				getController().prompt(request, response, PromptLevel.WARRING,
						throwable.getMessage());
				sendRedirect(request, response,
						configureProvider.format(URLVariable.FINANCING_ZQZR));
			} else {
				super.onThrowable(request, response, throwable);
			}
		}
	}

	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		ResourceProvider resourceProvider = getResourceProvider();
		final ConfigureProvider configureProvider = resourceProvider
				.getResource(ConfigureProvider.class);
		getResourceProvider().log(throwable);
		if (throwable instanceof ParameterException
				|| throwable instanceof SQLException) {
			getController().prompt(request, response, PromptLevel.ERROR,
					"系统繁忙，请您稍后再试");
			sendRedirect(request, response,
					configureProvider.format(URLVariable.FINANCING_ZQZR));
		} else if (throwable instanceof LogicalException) {
			getController().prompt(request, response, PromptLevel.WARRING,
					throwable.getMessage());
			sendRedirect(request, response,
					configureProvider.format(URLVariable.FINANCING_ZQZR));
		} else {
			super.onThrowable(request, response, throwable);
		}
	}

}
