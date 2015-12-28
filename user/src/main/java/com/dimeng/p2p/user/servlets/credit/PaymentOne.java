package com.dimeng.p2p.user.servlets.credit;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.LogicalException;
import com.dimeng.framework.service.exception.ParameterException;
import com.dimeng.p2p.modules.bid.user.service.TenderRepaymentManage;
import com.dimeng.p2p.order.TenderRepaymentExecutor;
import com.dimeng.p2p.variables.defines.SystemVariable;
import com.dimeng.util.parser.BooleanParser;
import com.dimeng.util.parser.IntegerParser;

public class PaymentOne extends AbstractCreditServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		int id = IntegerParser.parse(request.getParameter("id"));
		int number = IntegerParser.parse(request.getParameter("number"));
		TenderRepaymentManage manage = serviceSession
				.getService(TenderRepaymentManage.class);
		int[] orderIds = manage.repayment(id, number);
		serviceSession.commit();
		try {
			Boolean tg = BooleanParser.parseObject(getConfigureProvider()
					.getProperty(SystemVariable.SFZJTG));
			TenderRepaymentExecutor executor = getResourceProvider()
					.getResource(TenderRepaymentExecutor.class);
			if (orderIds != null && orderIds.length > 0) {
				for (int orderId : orderIds) {
					executor.submit(orderId, null);
					if (!tg) {
						executor.confirm(orderId, null);
					}
				}
			}
		} catch (Throwable e) {
			manage.updateT6252(id, number);
			throw e;
		}
		sendRedirect(request, response,
				getController().getViewURI(request, LoanDetail.class) + "?id="
						+ id);
	}

	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		int id = IntegerParser.parse(request.getParameter("id"));
		if (throwable instanceof ParameterException
				|| throwable instanceof SQLException) {
			throwable.printStackTrace();
			getController().prompt(request, response, PromptLevel.ERROR,
					"系统繁忙，请您稍后再试");
			sendRedirect(request, response,
					getController().getViewURI(request, LoanDetail.class)
							+ "?id=" + id);
		} else if (throwable instanceof LogicalException) {
			getController().prompt(request, response, PromptLevel.WARRING,
					throwable.getMessage());
			sendRedirect(request, response,
					getController().getViewURI(request, LoanDetail.class)
							+ "?id=" + id);
		} else {
			super.onThrowable(request, response, throwable);
		}
		getResourceProvider().log(throwable.getMessage());
	}
}
