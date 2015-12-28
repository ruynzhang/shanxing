package com.dimeng.p2p.pay.servlets;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.allinpay.ets.client.RequestOrder;
import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.PaymentInstitution;
import com.dimeng.p2p.modules.account.pay.service.ChargeManage;
import com.dimeng.p2p.modules.account.pay.service.entity.ChargeOrder;
import com.dimeng.p2p.pay.servlets.huichao.HuiChaoContinue;
import com.dimeng.p2p.pay.util.MD5Util;
import com.dimeng.p2p.variables.defines.PayVariavle;
import com.dimeng.p2p.variables.defines.SystemVariable;
import com.dimeng.util.StringHelper;
import com.dimeng.util.parser.BigDecimalParser;
import com.dimeng.util.parser.IntegerParser;

public class Index extends AbstractPayServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		int payCompanyCode = IntegerParser.parse(request.getParameter("type"));
		BigDecimal amount = BigDecimalParser.parse(request
				.getParameter("amount"));
		int o = IntegerParser.parse(request.getParameter("o"));
		ChargeManage manage = serviceSession.getService(ChargeManage.class);
		ChargeOrder order = null;
		if (o > 0) {
			order = manage.getOrder(o);
		} else {
			order = manage.addOrder(amount, payCompanyCode);
		}
		if (order.payCompanyCode <= 0
				|| order.amount.compareTo(new BigDecimal(0)) <= 0) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			return;
		}
		String url = null;
		if (100 == order.payCompanyCode) {
			RequestOrder requestOrder = newAllinpayOrder(order);
			url = createAllinpayUrl(requestOrder);
		} else if (200 == order.payCompanyCode) {
			url = createShuangqianUrl(order);
		} else if (300 == order.payCompanyCode) {

		}else if(PaymentInstitution.HUICHAO.getInstitutionCode()==order.payCompanyCode){
			request.setAttribute("orderId", order.id);
			this.forwardController(request, response, HuiChaoContinue.class);
			return;
		} else {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			return;
		}
		if (StringHelper.isEmpty(url)) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			return;
		}
		sendRedirect(request, response, url);
	}

	protected RequestOrder newAllinpayOrder(ChargeOrder order) throws Throwable {
		final int inputCharset = 1; // 1:UTF-8 2:GBK
		final String version = "v1.0"; // v1.0 or v2.0
		final String signType = "1"; // 签名类型（1：证书 0：MD5)
		final String orderCurrency = "0"; // 0：人民币
		final String payType = "0"; // 支付方式（0：不指定 1：个人网银 4企业网银
									// 12快捷支付）
		final int language = 1;

		ConfigureProvider configureProvider = getConfigureProvider();
		RequestOrder requestOrder = new RequestOrder();
		requestOrder.setInputCharset(inputCharset);
		requestOrder.setPickupUrl(configureProvider
				.format(PayVariavle.ALLINPAY_RETURN_URL));// 商户上送的页面通知地址
		requestOrder.setReceiveUrl(configureProvider
				.format(PayVariavle.ALLINPAY_NOTIFY_URL));// 商户上送的后台通知地址
		requestOrder.setVersion(version);
		requestOrder.setSignType(Integer.parseInt(signType));
		requestOrder.setPayType(Integer.parseInt(payType));
		requestOrder.setMerchantId(configureProvider
				.format(PayVariavle.ALLINPAY_MERCHANTID));// 商户id
		requestOrder.setOrderNo(Integer.toString(order.id));
		long orderAmount = (order.amount.multiply(new BigDecimal(100)))
				.setScale(2).longValue();
		requestOrder.setOrderAmount(orderAmount);
		requestOrder.setOrderCurrency(orderCurrency);
		String orderDatetime = new SimpleDateFormat("yyyyMMddHHmmss")
				.format(order.orderTime);
		requestOrder.setOrderDatetime(orderDatetime);
		requestOrder.setOrderExpireDatetime(configureProvider
				.format(PayVariavle.ALLINPAY_ORDER_EXPIRE_DATETIME)); // 订单过期时间，单位为分
		requestOrder.setKey(configureProvider
				.format(PayVariavle.ALLINPAY_MD5_KEY)); // key为MD5密钥，密钥是在通联支付网关会员服务网站上设置。
		requestOrder.setLanguage(language);

		return requestOrder;
	}

	protected String createAllinpayUrl(RequestOrder requestOrder)
			throws Throwable {
		ConfigureProvider configureProvider = getConfigureProvider();
		StringBuilder builder = new StringBuilder(
				configureProvider.format(PayVariavle.ALLINPAY_URL));
		builder.append("?inputCharset=");
		builder.append(requestOrder.getInputCharset());
		builder.append("&pickupUrl=");
		builder.append(requestOrder.getPickupUrl());
		builder.append("&receiveUrl=");
		builder.append(requestOrder.getReceiveUrl());
		builder.append("&version=");
		builder.append(requestOrder.getVersion());
		builder.append("&signType=");
		builder.append(requestOrder.getSignType());
		builder.append("&merchantId=");
		builder.append(requestOrder.getMerchantId());
		builder.append("&orderNo=");
		builder.append(requestOrder.getOrderNo());
		builder.append("&orderAmount=");
		builder.append(requestOrder.getOrderAmount());
		builder.append("&orderCurrency=");
		builder.append(requestOrder.getOrderCurrency());
		builder.append("&orderDatetime=");
		builder.append(requestOrder.getOrderDatetime());
		builder.append("&orderExpireDatetime=");
		builder.append(requestOrder.getOrderExpireDatetime());
		builder.append("&payType=");
		builder.append(requestOrder.getPayType());
		builder.append("&language=");
		builder.append(requestOrder.getLanguage());
		builder.append("&signMsg=");
		builder.append(requestOrder.doSign());
		return builder.toString();
	}

	protected String createShuangqianUrl(ChargeOrder order) throws Throwable {
		ConfigureProvider configureProvider = getConfigureProvider();
		String MerNo = configureProvider
				.format(PayVariavle.SHUANGQIANPAY_MERNO);
		String MD5key = configureProvider
				.format(PayVariavle.SHUANGQIANPAY_MD5KEY);
		String ReturnURL = configureProvider
				.format(PayVariavle.SHUANGQIANPAY_RETURN_URL);
		String NotifyURL = configureProvider
				.format(PayVariavle.SHUANGQIANPAY_NOTIFY_URL);
		String PayType = configureProvider
				.format(PayVariavle.SHUANGQIANPAY_PAYTYPE);
		double orderAmount = order.amount.setScale(2, BigDecimal.ROUND_HALF_UP)
				.doubleValue();
		String Amount = Double.toString(orderAmount);
		String BillNo = Integer.toString(order.id);
		String MerRemark = "charge " + orderAmount;
		String Products = configureProvider.format(SystemVariable.SITE_DOMAIN);
		MD5Util md5util = new MD5Util();
		String MD5info = md5util.signMap(new String[] { Amount, BillNo, MerNo,
				ReturnURL }, MD5key, "REQ");

		StringBuilder builder = new StringBuilder(
				configureProvider.format(PayVariavle.SHUANGQIANPAY_URL));
		builder.append("?MerNo=");
		builder.append(MerNo);
		builder.append("&BillNo=");
		builder.append(order.id);
		builder.append("&Amount=");
		builder.append(orderAmount);
		builder.append("&PayType=");
		builder.append(PayType);
		builder.append("&ReturnURL=");
		builder.append(ReturnURL);
		builder.append("&NotifyURL=");
		builder.append(NotifyURL);
		builder.append("&MD5info=");
		builder.append(MD5info);
		builder.append("&MerRemark=");
		builder.append(MerRemark);
		builder.append("&Products=");
		builder.append(Products);
		return builder.toString();
	}
}
