package com.dimeng.p2p.front.servlets;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.LogicalException;
import com.dimeng.framework.service.exception.ParameterException;
import com.dimeng.p2p.account.front.service.UserManage;

public class CheckNameExists extends AbstractFrontServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected boolean mustAuthenticated() {
		return false;
	}

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		response.setContentType("text/html;charset="
				+ getResourceProvider().getCharset());
		String accountName = request.getParameter("accountName");
		UserManage userManager = serviceSession.getService(UserManage.class);
		boolean isResult = userManager.isAccountExists(accountName);
		response.getWriter().print(isResult);
		response.getWriter().flush();
	}

	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		if (throwable instanceof SQLException
				|| throwable instanceof ParameterException
				|| throwable instanceof LogicalException) {
			getController().prompt(request, response, PromptLevel.ERROR,
					throwable.getMessage());
			throwable.getStackTrace();
			sendRedirect(request, response,
					getController().getViewURI(request, Register.class));
		} else {
			super.onThrowable(request, response, throwable);
		}
	}
}
