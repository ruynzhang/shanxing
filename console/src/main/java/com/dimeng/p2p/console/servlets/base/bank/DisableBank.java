package com.dimeng.p2p.console.servlets.base.bank;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.LogicalException;
import com.dimeng.framework.service.exception.ParameterException;
import com.dimeng.p2p.console.servlets.base.AbstractBaseServlet;
import com.dimeng.p2p.modules.base.console.service.BankManage;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_BASE_DISABLEBANK", name = "停用银行")
public class DisableBank extends AbstractBaseServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		BankManage manage = serviceSession.getService(BankManage.class);
		int id = IntegerParser.parse(request.getParameter("id"));
		try {
			manage.disable(id);
			sendRedirect(request, response,
					getController().getURI(request, SearchBank.class));
		} catch (LogicalException | ParameterException e) {
			prompt(request, response, PromptLevel.WARRING, e.getMessage());
			processGet(request, response, serviceSession);
		}
	}
}
