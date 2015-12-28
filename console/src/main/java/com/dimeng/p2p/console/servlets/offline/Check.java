package com.dimeng.p2p.console.servlets.offline;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.LogicalException;
import com.dimeng.framework.service.exception.ParameterException;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.modules.bid.console.service.OfflineManage;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_OFFLINE_CHECK", name = "标的审核通过")
public class Check extends AbstractBidServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -268955794485557959L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		int loanId = IntegerParser.parse(request.getParameter("loanId"));
		int userId = IntegerParser.parse(request.getParameter("userId"));
		OfflineManage OfflineManage = serviceSession
				.getService(OfflineManage.class);
		try {
			OfflineManage.through(loanId);
			sendRedirect(request, response,
					getController().getURI(request, OfflineLoanList.class));
		} catch (Throwable throwable) {
			if (throwable instanceof LogicalException
					|| throwable instanceof ParameterException) {
				getController().prompt(request, response, PromptLevel.WARRING,
						throwable.getMessage());
				sendRedirect(request, response,
						getController().getURI(request, DetailAnnexWz.class)
								+ "?loanId=" + loanId + "&userId=" + userId);
			} else {
				super.onThrowable(request, response, throwable);
			}
		}
	}
}
