package com.dimeng.p2p.console.servlets.base.jylx;

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
import com.dimeng.p2p.S51.entities.T5122;
import com.dimeng.p2p.console.servlets.base.AbstractBaseServlet;
import com.dimeng.p2p.modules.base.console.service.TradeTypeManage;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_BASE_JYLXVIEW", name = "修改交易类型")
public class ViewJylx extends AbstractBaseServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		TradeTypeManage tradeTypeManage = serviceSession
				.getService(TradeTypeManage.class);
		int id = IntegerParser.parse(request.getParameter("id"));
		T5122 entity = tradeTypeManage.get(id);
		request.setAttribute("entity", entity);
		forwardView(request, response, getClass());
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			final HttpServletResponse response,
			final ServiceSession serviceSession) throws Throwable {
		TradeTypeManage tradeTypeManage = serviceSession
				.getService(TradeTypeManage.class);
		T5122 t5122 = new T5122();
		t5122.parse(request);
		tradeTypeManage.update(t5122);
		sendRedirect(request, response,
				getController().getURI(request, JylxList.class));
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
					getController().getURI(request, ViewJylx.class));

		} else if (throwable instanceof LogicalException
				|| throwable instanceof ParameterException) {
			getController().prompt(request, response, PromptLevel.WARRING,
					throwable.getMessage());
			sendRedirect(request, response,
					getController().getURI(request, ViewJylx.class));
		} else {
			super.onThrowable(request, response, throwable);
			sendRedirect(request, response,
					getController().getURI(request, ViewJylx.class));
		}
	}

}
