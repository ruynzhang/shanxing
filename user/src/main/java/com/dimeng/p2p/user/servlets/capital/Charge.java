package com.dimeng.p2p.user.servlets.capital;

import java.io.IOException;
import java.math.BigDecimal;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.resource.ResourceRegister;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.LogicalException;
import com.dimeng.framework.service.exception.ParameterException;
import com.dimeng.p2p.modules.capital.user.service.ChargeManage;
import com.dimeng.p2p.variables.defines.URLVariable;

public class Charge extends AbstractCapitalServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {

		ChargeManage manage = serviceSession.getService(ChargeManage.class);

		BigDecimal amount = new BigDecimal(request.getParameter("amount"));
		String type = request.getParameter("type");

		request.setAttribute("amount", amount);
		request.setAttribute("type", type);

		int orderNo = manage.addOrder(amount, type);
		if (orderNo > 0) {
			ConfigureProvider configureProvider = ResourceRegister
					.getResourceProvider(getServletContext()).getResource(
							ConfigureProvider.class);
			sendRedirect(request, response,
					configureProvider.format(URLVariable.PAY_INDEX) + "?o="
							+ orderNo);
			return;
		} else {
			sendRedirect(request, response,
					getController().getViewURI(request, getClass()));
			return;
		}
	}

	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		if (throwable instanceof LogicalException
				|| throwable instanceof ParameterException) {
			sendRedirect(request, response,
					getController().getViewURI(request, getClass()));
		}
	}

}
