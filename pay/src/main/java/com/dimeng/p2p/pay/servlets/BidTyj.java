package com.dimeng.p2p.pay.servlets;

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
import com.dimeng.p2p.modules.bid.pay.service.TyjManage;
import com.dimeng.p2p.order.TenderOrderExecutor;
import com.dimeng.p2p.variables.defines.URLVariable;
import com.dimeng.util.parser.BigDecimalParser;
import com.dimeng.util.parser.IntegerParser;

/**
 * 投标
 */
public class BidTyj extends AbstractPayServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		//final ConfigureProvider configureProvider = getConfigureProvider();
		final BigDecimal amount = BigDecimalParser.parse(request
				    .getParameter("amount"));
		int loanId = IntegerParser.parse(request.getParameter("loanId"));
		TyjManage tyjMange = serviceSession.getService(TyjManage.class);
		//判断可投金额
		if(!tyjMange.isFullBidtyj(loanId)){
			int orderId=0;
			//没有满标
			synchronized (BidTyj.class) {
				//如果没满标一个一个的下订单
				if(!tyjMange.isFullBidtyj(loanId)){
					
					orderId = tyjMange.bidtyj(loanId, amount);
					serviceSession.commit();
					
				}
			}
			if(orderId<=0){
				throw new LogicalException("投标生成订单失败!");
			}
			getController().prompt(request, response, PromptLevel.INFO,
						"恭喜你，投标成功");
			sendRedirect(request, response, getURL(loanId));
			
		}
		
		
	}

	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		getResourceProvider().log(throwable);
		int loanId = IntegerParser.parse(request.getParameter("loanId"));
		if (throwable instanceof ParameterException
				|| throwable instanceof SQLException) {
			getController().prompt(request, response, PromptLevel.ERROR,
					"系统繁忙，请您稍后再试");
			sendRedirect(request, response, getURL(loanId));
		} else if (throwable instanceof LogicalException) {
			getController().prompt(request, response, PromptLevel.WARRING,
					throwable.getMessage());
			sendRedirect(request, response, getURL(loanId));
		} else {
			super.onThrowable(request, response, throwable);
		}
	}

	protected String getURL(int loanId) throws IOException {
		ResourceProvider resourceProvider = getResourceProvider();
		final ConfigureProvider configureProvider = resourceProvider
				.getResource(ConfigureProvider.class);
		StringBuilder url = new StringBuilder(
				configureProvider.format(URLVariable.FINANCING_SBTZTYZ_XQ));
		url.append(Integer.toString(loanId)).append(
				resourceProvider.getSystemDefine().getRewriter()
						.getViewSuffix());
		return url.toString();
	}

}
