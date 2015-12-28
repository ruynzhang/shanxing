package com.dimeng.p2p.console.servlets.finance.txgl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.LogicalException;
import com.dimeng.framework.service.exception.ParameterException;
import com.dimeng.p2p.S61.enums.T6130_F09;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.p2p.modules.account.console.service.UserWithdrawalsManage;
import com.dimeng.p2p.modules.account.console.service.entity.UserWithdrawals;
import com.dimeng.p2p.variables.defines.SystemVariable;
import com.dimeng.util.parser.BooleanParser;
import com.dimeng.util.parser.EnumParser;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_FINANCE_CHECKTXGL", name = "提现管理审核")
public class Check extends AbstractFinanceServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		UserWithdrawalsManage extraction = serviceSession
				.getService(UserWithdrawalsManage.class);
		int id = IntegerParser.parse(request.getParameter("id"));
		UserWithdrawals txglRecord = extraction.get(id);
		request.setAttribute("txglRecord", txglRecord);
		super.processGet(request, response, serviceSession);
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			final HttpServletResponse response,
			final ServiceSession serviceSession) throws Throwable {
		UserWithdrawalsManage extraction = serviceSession
				.getService(UserWithdrawalsManage.class);
		int id = IntegerParser.parse(request.getParameter("id"));
		String check_reason = request.getParameter("check_reason");
		T6130_F09 status = EnumParser.parse(T6130_F09.class,
				request.getParameter("status"));
		ConfigureProvider configureProvider = getResourceProvider()
				.getResource(ConfigureProvider.class);
		boolean tg = BooleanParser.parse(configureProvider
				.getProperty(SystemVariable.SFZJTG));
		try {
			extraction.check(status == T6130_F09.DFK, check_reason, id);
			if (status == T6130_F09.DFK) {
				sendRedirect(request, response,
						getController().getURI(request, Shtg.class));
			} else {
//				if (tg) {
//					WithdrawManage withdrawManage = serviceSession
//							.getService(WithdrawManage.class);
//					withdrawManage.cancle(id);
//				}
				sendRedirect(request, response,
						getController().getURI(request, Txsb.class));
			}
		} catch (Throwable throwable) {
			if (throwable instanceof ParameterException
					|| throwable instanceof LogicalException) {
				getController().prompt(request, response, PromptLevel.WARRING,
						throwable.getMessage());
				processGet(request, response, serviceSession);
			} else {
				super.onThrowable(request, response, throwable);
			}
		}
	}
}
