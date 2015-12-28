package com.dimeng.p2p.console.servlets.base.bank;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.LogicalException;
import com.dimeng.framework.service.exception.ParameterException;
import com.dimeng.p2p.S50.entities.T5020;
import com.dimeng.p2p.console.servlets.base.AbstractBaseServlet;
import com.dimeng.p2p.modules.base.console.service.BankManage;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_BASE_UPDATEBANK", name = "修改银行")
public class UpdateBank extends AbstractBaseServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		BankManage manage = serviceSession.getService(BankManage.class);
		int id = IntegerParser.parse(request.getParameter("id"));
		T5020 bank = manage.get(id);
		request.setAttribute("bank", bank);
		forwardView(request, response, getClass());
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		BankManage manage = serviceSession.getService(BankManage.class);
		int id = IntegerParser.parse(request.getParameter("id"));
		String name = request.getParameter("name");
		String code = request.getParameter("code");
		if (name == null) {
			getController().prompt(request, response, PromptLevel.WARRING,
					"银行名称不能为空");
			processGet(request, response, serviceSession);
			return;
		}
		try {
			manage.update(id, name, code);
			sendRedirect(request, response,
					getController().getURI(request, SearchBank.class));
		} catch (LogicalException | ParameterException e) {
			prompt(request, response, PromptLevel.WARRING, e.getMessage());
			processGet(request, response, serviceSession);
		}
	}

}
