package com.dimeng.p2p.console.servlets.finance.fksh;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.resource.ResourceProvider;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.LogicalException;
import com.dimeng.framework.service.exception.ParameterException;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.p2p.escrow.huichao.service.CancelManage;
import com.dimeng.p2p.modules.bid.console.service.TenderCancelManage;
import com.dimeng.p2p.order.TenderCancelExecutor;
import com.dimeng.p2p.service.RedPacketManage;
import com.dimeng.p2p.variables.defines.SystemVariable;
import com.dimeng.util.parser.BooleanParser;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_FINANCE_NOTLOAN", name = "放款审核不放款")
public class NotLoan extends AbstractFinanceServlet {
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
		try {
			int id = IntegerParser.parse(request.getParameter("id"));
			CancelManage cancelManage=serviceSession.getService(CancelManage.class);
			if(!cancelManage.queryOrder(id, this.getResourceProvider())){
				throw new LogicalException("已经放款过了,不能再进行不放款处理!");
			}
			TenderCancelManage tenderCancelManage = serviceSession
					.getService(TenderCancelManage.class);
			
			String des = request.getParameter("des");
			int[] orderIds = tenderCancelManage.cancel(id, des);
			serviceSession.commit();
			if (orderIds != null) {
				ResourceProvider resourceProvider = getResourceProvider();
				ConfigureProvider configureProvider = resourceProvider
						.getResource(ConfigureProvider.class);
				Boolean tg = BooleanParser.parseObject(configureProvider
						.getProperty(SystemVariable.SFZJTG));
				TenderCancelExecutor executor = getResourceProvider()
						.getResource(TenderCancelExecutor.class);
				for (int orderId : orderIds) {
					executor.submit(orderId, null);
					if (!tg) {
						executor.confirm(orderId, null);
					}
				}
			}
			
			ResourceProvider resourceProvider = getResourceProvider();
			RedPacketManage redPacketManage = serviceSession.getService(RedPacketManage.class);
			redPacketManage.opRedPacket(resourceProvider,serviceSession, id, false);
			
			sendRedirect(request, response,
					getController().getURI(request, FkshList.class));
		} catch (Throwable throwable) {
			if (throwable instanceof LogicalException
					|| throwable instanceof ParameterException) {
				getController().prompt(request, response, PromptLevel.WARRING,
						throwable.getMessage());
				sendRedirect(request, response,
						getController().getURI(request, FkshList.class));
			} else {
				super.onThrowable(request, response, throwable);
			}
		}
	}
}
