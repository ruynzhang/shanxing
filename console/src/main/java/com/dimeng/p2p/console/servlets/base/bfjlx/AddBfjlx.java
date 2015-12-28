package com.dimeng.p2p.console.servlets.base.bfjlx;

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
import com.dimeng.p2p.S62.entities.T6212;
import com.dimeng.p2p.console.servlets.base.AbstractBaseServlet;
import com.dimeng.p2p.modules.base.console.service.BfjlxManage;

@Right(id = "P2P_C_BASE_BFJLXADD", name = "新增标附件类型")
public class AddBfjlx extends AbstractBaseServlet {
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
		BfjlxManage manage = serviceSession.getService(BfjlxManage.class);
		T6212 t6212 = new T6212();
		t6212.parse(request);
		manage.add(t6212);
		sendRedirect(request, response, getController().getURI(request, BfjlxList.class));
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
					getController().getURI(request, AddBfjlx.class));

		} else if (throwable instanceof LogicalException
				|| throwable instanceof ParameterException) {
			getController().prompt(request, response, PromptLevel.WARRING,
					throwable.getMessage());
			sendRedirect(request, response,
					getController().getURI(request, AddBfjlx.class));
		} else {
			super.onThrowable(request, response, throwable);
			sendRedirect(request, response,
					getController().getURI(request, AddBfjlx.class));
		}
	}

}
