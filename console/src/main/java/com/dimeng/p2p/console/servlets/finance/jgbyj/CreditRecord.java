package com.dimeng.p2p.console.servlets.finance.jgbyj;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.modules.finance.console.service.JgbyjglManage;
import com.dimeng.p2p.modules.finance.console.service.entity.Jgfxbyj;
import com.dimeng.p2p.modules.finance.console.service.entity.Jgxyjl;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.util.StringHelper;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_FINANCE_CREDITRECORD", name = "机构风险备用金信用记录")
public class CreditRecord extends AbstractFinanceServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			final HttpServletResponse response,
			final ServiceSession serviceSession) throws Throwable {
		JgbyjglManage jgbyjglManage = serviceSession
				.getService(JgbyjglManage.class);
		int id = IntegerParser.parse(request.getParameter("id"));
		String message = request.getParameter("message");
		if (!StringHelper.isEmpty(message)) {
			getController().prompt(request, response, PromptLevel.WARRING,
					message);
		}
		Jgfxbyj jgfxbyj = jgbyjglManage.getJgxbyj(id);
		Jgxyjl jgxyjl = jgbyjglManage.getJgxyjl(id);
		request.setAttribute("jgfxbyj", jgfxbyj);
		request.setAttribute("jgxyjl", jgxyjl);
		forwardView(request, response, getClass());
	}

	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		getResourceProvider().log(throwable.getMessage());
		super.onThrowable(request, response, throwable);
	}
}
