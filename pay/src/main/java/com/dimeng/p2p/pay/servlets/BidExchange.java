package com.dimeng.p2p.pay.servlets;

import java.io.IOException;
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
import com.dimeng.p2p.pay.servlets.huichao.ZQExchange;
import com.dimeng.p2p.variables.defines.URLVariable;

public class BidExchange extends AbstractPayServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		this.forwardController(request, response, ZQExchange.class);
//		int zcbId = IntegerParser.parse(request.getParameter("zqzrId"));
//		BidExchangeManage manage = serviceSession
//				.getService(BidExchangeManage.class);
//		final int orderId = manage.purchase(zcbId);
//		final T6507 t6507 = manage.selectT6507(orderId);
//		final T6501 t6501 = manage.selectT6501(orderId);
//		final String buyCustId = manage.getUserCustId(t6507.F03);
//		final String bidDetails = manage.bidDetails(orderId);
//		serviceSession.commit();
//		TenderExchangeExecutor executor = getResourceProvider().getResource(
//				TenderExchangeExecutor.class);
//		executor.submit(orderId, null);
//		String location = manage.createBidExchangeUri(new BidExchangeCond() {

//			@Override
//			public String sellCustId() {
//				return null;
//			}

//			@Override
//			public String retUrl() {
//				try {
//					return getConfigureProvider().format(HuifuVariable.HF_TG_EXCHAGE);
//				} catch (Exception e) {
//				}
//				return null;
//			}
//
//			@Override
//			public String ordId() {
//				return String.valueOf(orderId);
//			}
//
//			@Override
//			public String ordDate() {
//				return DateParser.format(t6501.F04, "yyyyMMdd");
//			}
//
//			@Override
//			public String fee() {
//				return t6507.F06.setScale(2, BigDecimal.ROUND_HALF_UP)
//						.toString();
//			}
//
//			@Override
//			public String divDetails() {
//				StringBuilder builder = new StringBuilder();
//				builder.append("[{\"DivAcctId\":\"MDT000001\",\"DivAmt\":\"");
//				builder.append(t6507.F06.setScale(2, BigDecimal.ROUND_HALF_UP)
//						.toString());
//				builder.append("\"}]");
//				return builder.toString();
//			}
//
//			@Override
//			public String creditDealAmt() {
//				return t6507.F05.setScale(2, BigDecimal.ROUND_HALF_UP)
//						.toString();
//			}
//
//			@Override
//			public String creditAmt() {
//				return t6507.F04.setScale(2, BigDecimal.ROUND_HALF_UP)
//						.toString();
//			}
//
//			@Override
//			public String buyCustId() {
//				return buyCustId;
//			}
//
//			@Override
//			public String bidDetails() {
//				return bidDetails;
//			}
//		}, t6507);
//		sendRedirect(request, response, location);
	}

	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		ResourceProvider resourceProvider = getResourceProvider();
		final ConfigureProvider configureProvider = resourceProvider
				.getResource(ConfigureProvider.class);
		getResourceProvider().log(throwable);
		if (throwable instanceof ParameterException
				|| throwable instanceof SQLException) {
			getController().prompt(request, response, PromptLevel.ERROR,
					"系统繁忙，请您稍后再试");
			sendRedirect(request, response,
					configureProvider.format(URLVariable.FINANCING_ZQZR));
		} else if (throwable instanceof LogicalException) {
			getController().prompt(request, response, PromptLevel.WARRING,
					throwable.getMessage());
			sendRedirect(request, response,
					configureProvider.format(URLVariable.FINANCING_ZQZR));
		} else {
			super.onThrowable(request, response, throwable);
		}
	}

}
