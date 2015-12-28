package com.dimeng.p2p.user.servlets.bid;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.resource.ResourceProvider;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.LogicalException;
import com.dimeng.framework.service.exception.ParameterException;
import com.dimeng.p2p.modules.bid.user.service.BidManage;
import com.dimeng.p2p.order.AdvanceExecutor;
import com.dimeng.p2p.user.servlets.fxbyj.Dbywmx;
import com.dimeng.p2p.user.servlets.fxbyj.Dfzq;
import com.dimeng.p2p.variables.defines.SystemVariable;
import com.dimeng.util.parser.BooleanParser;
import com.dimeng.util.parser.IntegerParser;

/**
 * 垫付
 * 
 * @author gaoshaolong
 * 
 */
public class Sbdf extends AbstractBidServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -3297138790344438598L;

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		try {
			BidManage bidManage = serviceSession.getService(BidManage.class);
			int loanId = IntegerParser.parse(request.getParameter("loanId"));
			ResourceProvider resourceProvider = getResourceProvider();
			ConfigureProvider configureProvider = resourceProvider
					.getResource(ConfigureProvider.class);
			AdvanceExecutor advanceExecutor = getResourceProvider()
					.getResource(AdvanceExecutor.class);
			Boolean tg = BooleanParser.parseObject(configureProvider
					.getProperty(SystemVariable.SFZJTG));
			List<Integer> orderIds = bidManage.addOrder(loanId);
			bidManage.updateOrderStatus(orderIds);
			serviceSession.commit();
			if (orderIds != null) {
				for (Integer orderId : orderIds) {
					advanceExecutor.submit(orderId, null);
					if (!tg) {
						advanceExecutor.confirm(orderId, null);
					}
				}
			}
			getController().prompt(request, response, PromptLevel.INFO, "操作成功");
			sendRedirect(request, response,
					getController().getURI(request, Dfzq.class));
		} catch (Throwable throwable) {
			if (throwable instanceof LogicalException
					|| throwable instanceof ParameterException) {
				getController().prompt(request, response, PromptLevel.WARRING,
						throwable.getMessage());
				sendRedirect(request, response,
						getController().getURI(request, Dbywmx.class));
			} else {
				super.onThrowable(request, response, throwable);
			}
		}
	}
}
