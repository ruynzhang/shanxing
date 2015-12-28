package com.dimeng.p2p.user.servlets.capital;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.LogicalException;
import com.dimeng.p2p.S61.enums.T6101_F03;
import com.dimeng.p2p.account.user.service.TxManage;
import com.dimeng.util.StringHelper;
import com.dimeng.util.parser.IntegerParser;

public class Withdraw extends AbstractCapitalServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		int cardId = IntegerParser.parse(request.getParameter("cardId"));
		BigDecimal amount = new BigDecimal(request.getParameter("amount"));
		getController().prompt(request, response, PromptLevel.WARRING,
				request.getParameter("amount"));
		String withdrawPsd = request.getParameter("withdrawPsd");
		if (StringHelper.isEmpty(withdrawPsd)) {
			getController().prompt(request, response, PromptLevel.INFO,
					"提现密码为空");
			processGet(request, response, serviceSession);
			return;
		}

		TxManage manage = serviceSession.getService(TxManage.class);
		manage.withdraw(amount, withdrawPsd, cardId, T6101_F03.WLZH);
		getController().clearPrompts(request, response, PromptLevel.WARRING);
		getController().prompt(request, response, PromptLevel.INFO,
				"提现申请成功，请等待工作人员审核！");
		sendRedirect(request, response,
				getController().getViewURI(request, Withdraw.class));
	}

	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		 throwable.printStackTrace();
		if (throwable instanceof NumberFormatException) {
			sendRedirect(request, response,
					getController().getViewURI(request, Withdraw.class));
		}
		if (throwable instanceof LogicalException) {
			getController().prompt(request, response, PromptLevel.INFO,
					throwable.getMessage());
			sendRedirect(request, response,
					getController().getViewURI(request, Withdraw.class));
		}
		if(throwable instanceof SQLException){
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		}
	}
}
