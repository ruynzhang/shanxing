package com.dimeng.p2p.console.servlets.base.xydj;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.LogicalException;
import com.dimeng.framework.service.exception.ParameterException;
import com.dimeng.p2p.S51.entities.T5124;
import com.dimeng.p2p.console.servlets.base.AbstractBaseServlet;
import com.dimeng.p2p.modules.base.console.service.CreditLevelManage;

@Right(id = "P2P_C_BASE_XYDJADD", name = "新增信用等级")
public class AddXydj extends AbstractBaseServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		forwardView(request, response, getClass());
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			final HttpServletResponse response,
			final ServiceSession serviceSession) throws Throwable {
		CreditLevelManage creditLevelManage = serviceSession
				.getService(CreditLevelManage.class);
		T5124 t5124 = new T5124();
		t5124.parse(request);
		creditLevelManage.add(t5124);
		sendRedirect(request, response,
				getController().getURI(request, XydjList.class));
	}

	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		getResourceProvider().log(throwable.getMessage());
		if (throwable instanceof SQLException) {
			throwable.printStackTrace();
			getController().prompt(request, response, PromptLevel.ERROR,
					"系统繁忙，请您稍后再试");
			sendRedirect(request, response,
					getController().getURI(request, AddXydj.class));

		} else if (throwable instanceof LogicalException
				|| throwable instanceof ParameterException) {
			getController().prompt(request, response, PromptLevel.WARRING,
					throwable.getMessage());
			sendRedirect(request, response,
					getController().getURI(request, AddXydj.class));
		} else {
			super.onThrowable(request, response, throwable);
			sendRedirect(request, response,
					getController().getURI(request, AddXydj.class));
		}
	}

}
