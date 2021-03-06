package com.dimeng.p2p.console.servlets.base.dywlx;

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
import com.dimeng.p2p.S62.entities.T6213;
import com.dimeng.p2p.console.servlets.base.AbstractBaseServlet;
import com.dimeng.p2p.modules.base.console.service.DywlxManage;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_BASE_DYWLXVIEW", name = "修改抵押物类型")
public class ViewDywlx extends AbstractBaseServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		DywlxManage manage = serviceSession.getService(DywlxManage.class);
		int id = IntegerParser.parse(request.getParameter("id"));
		T6213 entity = manage.get(id);
		request.setAttribute("entity", entity);
		forwardView(request, response, getClass());
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			final HttpServletResponse response,
			final ServiceSession serviceSession) throws Throwable {
		DywlxManage manage = serviceSession.getService(DywlxManage.class);
		T6213 t6213 = new T6213();
		t6213.parse(request);
		manage.update(t6213);
		sendRedirect(request, response, getController().getURI(request, DywlxList.class));
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
					getController().getURI(request, ViewDywlx.class));

		} else if (throwable instanceof LogicalException
				|| throwable instanceof ParameterException) {
			getController().prompt(request, response, PromptLevel.WARRING,
					throwable.getMessage());
			sendRedirect(request, response,
					getController().getURI(request, ViewDywlx.class));
		} else {
			super.onThrowable(request, response, throwable);
			sendRedirect(request, response,
					getController().getURI(request, ViewDywlx.class));
		}
	}

}
