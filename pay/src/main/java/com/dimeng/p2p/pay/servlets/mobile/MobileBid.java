package com.dimeng.p2p.pay.servlets.mobile;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.resource.ResourceProvider;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.LogicalException;
import com.dimeng.framework.service.exception.ParameterException;
import com.dimeng.p2p.escrow.huichao.service.FKOrder;
import com.dimeng.p2p.modules.bid.pay.service.TenderManage;
import com.dimeng.p2p.order.TenderOrderExecutor;
import com.dimeng.p2p.service.RedPacketManage;
import com.dimeng.p2p.variables.defines.SystemVariable;
import com.dimeng.util.parser.BigDecimalParser;
import com.dimeng.util.parser.BooleanParser;
import com.dimeng.util.parser.IntegerParser;

/**
 * 投标
 */
public class MobileBid extends AbstractMobileServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(HttpServletRequest request, HttpServletResponse response, ServiceSession serviceSession) throws Throwable {

		final ConfigureProvider configureProvider = getConfigureProvider();
		boolean tg = BooleanParser.parseObject(configureProvider.getProperty(SystemVariable.SFZJTG));
		final BigDecimal amount = BigDecimalParser.parse(request.getParameter("amount"));
		int loanId = IntegerParser.parse(request.getParameter("loanId"));
		int hbId = IntegerParser.parse(request.getParameter("hbId"));

		TenderManage tenderManage = serviceSession.getService(TenderManage.class);
		FKOrder fkOrder = serviceSession.getService(FKOrder.class);
		if (!fkOrder.isFullBid(loanId)) {
			TenderOrderExecutor executor = getResourceProvider().getResource(TenderOrderExecutor.class);
			int orderId = 0;
			//没有满标
			synchronized (MobileBid.class) {
				//如果没满标一个一个的下订单
				if (!fkOrder.isFullBid(loanId)) {
					orderId = tenderManage.bid(loanId, amount);
					serviceSession.commit();
				}
			}
			if (orderId <= 0) {
				throw new LogicalException("投标生成订单失败!");
			}
			executor.submit(orderId, null);
			//使用红包
			if (hbId > 0) {
				RedPacketManage redPacketManage = serviceSession.getService(RedPacketManage.class);
				redPacketManage.useRedPacket(serviceSession, loanId, orderId, hbId);
			}
			if (tg) {
				//executor.confirm(orderId, null);
				getController().prompt(request, response, PromptLevel.INFO, "恭喜你，投标成功");
				sendRedirect(request, response, getURL(loanId, request, true));
			} else {
				executor.confirm(orderId, null);
				getController().prompt(request, response, PromptLevel.INFO, "恭喜你，投标成功");
				sendRedirect(request, response, getURL(loanId, request, true));
			}
		}
	}

	@Override
	protected void onThrowable(HttpServletRequest request, HttpServletResponse response, Throwable throwable) throws ServletException, IOException {
		getResourceProvider().log(throwable);
		int loanId = IntegerParser.parse(request.getParameter("loanId"));
		if (throwable instanceof ParameterException || throwable instanceof SQLException) {
			getController().prompt(request, response, PromptLevel.ERROR, "系统繁忙，请您稍后再试");
			sendRedirect(request, response, getURL(loanId, request,false));
		} else if (throwable instanceof LogicalException) {
			getController().prompt(request, response, PromptLevel.ERROR, throwable.getMessage());
			sendRedirect(request, response, getURL(loanId, request, false));
		} else {
			super.onThrowable(request, response, throwable);
		}
	}

	protected String getURL(int loanId, HttpServletRequest request, boolean isSuccess) throws IOException {
		ResourceProvider resourceProvider = getResourceProvider();
		String systemSiteDomain = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
		final ConfigureProvider configureProvider = resourceProvider.getResource(ConfigureProvider.class);
		StringBuilder url = new StringBuilder(systemSiteDomain + "/mobile/bidDetail.html?id="+loanId+"&isSuccess="+isSuccess);
//		StringBuilder url = new StringBuilder(systemSiteDomain + "/bidDetail.html?id="+loanId+"&isSuccess="+isSuccess);
		return url.toString();
	}
}
