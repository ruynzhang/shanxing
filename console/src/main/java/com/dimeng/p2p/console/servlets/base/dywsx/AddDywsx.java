package com.dimeng.p2p.console.servlets.base.dywsx;

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
import com.dimeng.p2p.S62.entities.T6214;
import com.dimeng.p2p.console.servlets.base.AbstractBaseServlet;
import com.dimeng.p2p.modules.base.console.service.DywlxManage;
import com.dimeng.p2p.modules.base.console.service.DywsxManage;

@Right(id = "P2P_C_BASE_DYWSXADD", name = "新增抵押物属性")
public class AddDywsx extends AbstractBaseServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		DywlxManage dywlxManage = serviceSession.getService(DywlxManage.class);
		T6213[] dywType = dywlxManage.getDyws();
		request.setAttribute("dywType", dywType);
		forwardView(request, response, getClass());
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			final HttpServletResponse response,
			final ServiceSession serviceSession) throws Throwable {
		DywsxManage manage = serviceSession.getService(DywsxManage.class);
		T6214 t6214 = new T6214();
		t6214.parse(request);
		manage.add(t6214);
		sendRedirect(request, response, getController().getURI(request, DywsxList.class));
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
					getController().getURI(request, AddDywsx.class));

		} else if (throwable instanceof LogicalException
				|| throwable instanceof ParameterException) {
			getController().prompt(request, response, PromptLevel.WARRING,
					throwable.getMessage());
			sendRedirect(request, response,
					getController().getURI(request, AddDywsx.class));
		} else {
			super.onThrowable(request, response, throwable);
			sendRedirect(request, response,
					getController().getURI(request, AddDywsx.class));
		}
	}

}
