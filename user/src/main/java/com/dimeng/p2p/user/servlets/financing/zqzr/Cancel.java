package com.dimeng.p2p.user.servlets.financing.zqzr;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.LogicalException;
import com.dimeng.framework.service.exception.ParameterException;
import com.dimeng.p2p.modules.bid.user.service.ZqzrManage;
import com.dimeng.p2p.user.servlets.financing.AbstractFinancingServlet;
import com.dimeng.util.parser.IntegerParser;

public class Cancel extends AbstractFinancingServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 121208103597863010L;

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		ZqzrManage finacingManage=serviceSession.getService(ZqzrManage.class);
		finacingManage.cancel(IntegerParser.parse(request.getParameter("zcbId")));
		sendRedirect(request, response, getController().getViewURI(request, Zqzrz.class));
	}
	
	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		getResourceProvider().log(throwable);
		if (throwable instanceof SQLException) {
			getController().prompt(request, response, PromptLevel.ERROR,
					"系统繁忙，请您稍后再试");
			sendRedirect(request, response, getController().getViewURI(request, Zqzrz.class));
		} else if (throwable instanceof LogicalException || throwable instanceof ParameterException) {
			getController().prompt(request, response, PromptLevel.WARRING,
					throwable.getMessage());
			sendRedirect(request, response, getController().getViewURI(request, Zqzrz.class));
		} else {
			super.onThrowable(request, response, throwable);
		}
	}

}
