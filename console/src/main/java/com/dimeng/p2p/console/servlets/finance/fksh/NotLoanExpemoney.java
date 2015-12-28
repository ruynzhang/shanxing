package com.dimeng.p2p.console.servlets.finance.fksh;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.LogicalException;
import com.dimeng.framework.service.exception.ParameterException;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.p2p.escrow.huichao.service.TenderTybManage;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_FINANCE_NOTLOANEXPEMONEY", name = "体验金不放款操作")
public class NotLoanExpemoney extends AbstractFinanceServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}

	/* (non-Javadoc)
	 * @see com.dimeng.p2p.console.servlets.AbstractConsoleServlet#processPost(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse, com.dimeng.framework.service.ServiceSession)
	 */
	@Override
	protected void processPost(final HttpServletRequest request,
			final HttpServletResponse response,
			final ServiceSession serviceSession) throws Throwable {
		try {
			TenderTybManage tendertybManage = serviceSession
					.getService(TenderTybManage.class);
			// 标ID
			int id = IntegerParser.parse(request.getParameter("id"));
			// 进行流标处理
			tendertybManage.Notloan(serviceSession,id);
			serviceSession.commit();
			  this.prompt(request, response, PromptLevel.WARRING, "不放款操作成功");
			
			sendRedirect(request, response,
					getController().getURI(request, TybshList.class));
		} catch (Throwable throwable) {
			if (throwable instanceof LogicalException
					|| throwable instanceof ParameterException) {
				getController().prompt(request, response, PromptLevel.WARRING,
						throwable.getMessage());
				sendRedirect(request, response,
						getController().getURI(request, TybshList.class));
			} else {
				super.onThrowable(request, response, throwable);
			}
		}
	}
	
	
}
