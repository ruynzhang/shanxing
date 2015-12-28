package com.dimeng.p2p.pay.servlets.allinpay;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.allinpay.ets.client.PaymentResult;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.order.ChargeOrderExecutor;
import com.dimeng.util.parser.IntegerParser;

public class AllinpayNotify extends AbstractAllinpayServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();

		String merchantId = request.getParameter("merchantId");
		String version = request.getParameter("version");
		String language = request.getParameter("language");
		String signType = request.getParameter("signType");
		String payType = request.getParameter("payType");
		String issuerId = request.getParameter("issuerId");
		String paymentOrderId = request.getParameter("paymentOrderId");
		String orderNo = request.getParameter("orderNo");
		String orderDatetime = request.getParameter("orderDatetime");
		String orderAmount = request.getParameter("orderAmount");
		String payDatetime = request.getParameter("payDatetime");
		String payAmount = request.getParameter("payAmount");
		String payResult = request.getParameter("payResult");
		String errorCode = request.getParameter("errorCode");
		String returnDatetime = request.getParameter("returnDatetime");
		String signMsg = request.getParameter("signMsg");

		// 验签是商户为了验证接收到的报文数据确实是支付网关发送的。
		// 构造订单结果对象，验证签名。
		PaymentResult paymentResult = new PaymentResult();
		paymentResult.setMerchantId(merchantId);
		paymentResult.setVersion(version);
		paymentResult.setLanguage(language);
		paymentResult.setSignType(signType);
		paymentResult.setPayType(payType);
		paymentResult.setIssuerId(issuerId);
		paymentResult.setPaymentOrderId(paymentOrderId);
		paymentResult.setOrderNo(orderNo);
		paymentResult.setOrderDatetime(orderDatetime);
		paymentResult.setOrderAmount(orderAmount);
		paymentResult.setPayDatetime(payDatetime);
		paymentResult.setPayAmount(payAmount);
		paymentResult.setPayResult(payResult);
		paymentResult.setErrorCode(errorCode);
		paymentResult.setReturnDatetime(returnDatetime);
		// signMsg为服务器端返回的签名值。
		paymentResult.setSignMsg(signMsg);
		// signType为"1"时，必须设置证书路径。
		paymentResult.setCertPath(getCert(getServletContext()));// 读取通联公钥证书存放路径
		// 验证签名：返回true代表验签成功；否则验签失败。
		boolean verifyResult = paymentResult.verify();
		// 验签成功，还需要判断订单状态，为"1"表示支付成功。
		boolean paySuccess = verifyResult && payResult.equals("1");

		if (paySuccess) {
			Map<String, String> params = new HashMap<>();
			params.put("paymentOrderId", paymentOrderId);
			getResourceProvider().getResource(ChargeOrderExecutor.class)
					.confirm(IntegerParser.parse(orderNo), params);
			out.print("<script>window.close();</script>");
		} else {
			out.print("订单未支付成功，请重新再试");
		}
		out.flush();
	}

}
