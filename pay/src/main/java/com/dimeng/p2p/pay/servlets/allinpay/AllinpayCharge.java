package com.dimeng.p2p.pay.servlets.allinpay;

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
import com.dimeng.p2p.order.ChargeOrderExecutor;
import com.dimeng.p2p.variables.defines.PayVariavle;
import com.dimeng.util.parser.BigDecimalParser;

public class AllinpayCharge extends AbstractAllinpayServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		BigDecimal amount = BigDecimalParser.parse(request
				.getParameter("amount"));
		ChargeManage manage = serviceSession.getService(ChargeManage.class);
		ChargeOrder order = manage.addOrder(amount,
				PaymentInstitution.ALLINPAY.getInstitutionCode());
		serviceSession.commit();
		String location = createAllinpayUrl(newAllinpayOrder(order));
		getResourceProvider().getResource(ChargeOrderExecutor.class).submit(
				order.id, null);
		sendRedirect(request, response, location);
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
}
