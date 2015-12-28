package com.dimeng.p2p.pay.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;

public class Withdraw extends AbstractPayServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
//		final BigDecimal amount = BigDecimalParser.parse(request
//				.getParameter("amount"));
//		final int cardId = IntegerParser.parse(request.getParameter("cardId"));
//		WithdrawManage manage = serviceSession.getService(WithdrawManage.class);
//		final String bankCard = StringHelper.decode(manage.getBankCard(cardId));
//		final String usrCustId = manage.getUserCustId();
//		final T6503 t6503 = manage.addOrder(bankCard, amount);
//		String location = manage.createWithdrawUri(new WithdrawCond() {
//
//			@Override
//			public String usrCustId() {
//				return usrCustId;
//			}
//
//			@Override
//			public String transAmt() {
//				return amount.setScale(2, BigDecimal.ROUND_HALF_UP).toString();
//			}
//
//			@Override
//			public String servFeeAccId() {
//				return "MDT000001";
//			}
//
//			@Override
//			public String servFee() {
//				return t6503.F04.setScale(2, BigDecimal.ROUND_HALF_UP)
//						.toString();
//			}
//
//			@Override
//			public String retUrl() {
//				try {
//					return getConfigureProvider().format(HuifuVariable.HF_TG_WITHDRAW);
//				} catch (Exception e) {
//				}
//				return null;
//			}
//
//			@Override
//			public String ordId() {
//				return String.valueOf(t6503.F01);
//			}
//
//			@Override
//			public String openAcctId() {
//				return bankCard;
//			}
//
//			@Override
//			public String merPriv() {
//				return null;
//			}
//		});
//		serviceSession.commit();
//		sendRedirect(request, response, location);
	}

	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		throwable.printStackTrace();
	}

}
