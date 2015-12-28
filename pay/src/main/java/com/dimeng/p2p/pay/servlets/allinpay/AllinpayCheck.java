package com.dimeng.p2p.pay.servlets.allinpay;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.allinpay.ets.client.PaymentResult;
import com.allinpay.ets.client.SecurityUtil;
import com.allinpay.ets.client.StringUtil;
import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.resource.ResourceRegister;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S65.enums.T6501_F03;
import com.dimeng.p2p.modules.account.pay.service.entity.ChargeOrder;
import com.dimeng.p2p.order.ChargeOrderExecutor;
import com.dimeng.p2p.variables.defines.PayVariavle;
import com.dimeng.util.ObjectHelper;

public class AllinpayCheck extends AbstractAllinpayServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected boolean mustAuthenticated() {
		return false;
	}

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		ConfigureProvider configureProvider = ResourceRegister
				.getResourceProvider(getServletContext()).getResource(
						ConfigureProvider.class);
		String mermberId = configureProvider
				.getProperty(PayVariavle.ALLINPAY_MERCHANTID); // 商户id
		String md5Key = configureProvider
				.getProperty(PayVariavle.ALLINPAY_MD5_KEY); // 商户的MD5 Key

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();

		ChargeOrder order = ObjectHelper.convert(request.getAttribute("order"),
				ChargeOrder.class);
		if (order == null) {
			out.print("查询的订单不存在！");
			out.flush();
			out.close();
			return;
		}
		if (order.status == T6501_F03.CG) {
			out.print("订单已支付成功,无需再更新状态！");
			out.flush();
			out.close();
			return;
		}
		// getResourceProvider().getResource(ChargeOrderExecutor.class).submit(
		// order.id, null);
		String orderDatetime = new SimpleDateFormat("yyyyMMddHHmmss")
				.format(order.orderTime);
		String queryDatetime = new SimpleDateFormat("yyyyMMddHHmmss")
				.format(new Date(System.currentTimeMillis()));

		StringBuffer bufSignSrc = new StringBuffer();
		StringUtil.appendSignPara(bufSignSrc, "merchantId", mermberId);
		StringUtil.appendSignPara(bufSignSrc, "version", "v1.5");
		StringUtil.appendSignPara(bufSignSrc, "signType", signType);
		StringUtil.appendSignPara(bufSignSrc, "orderNo",
				Integer.toString(order.id));
		StringUtil.appendSignPara(bufSignSrc, "orderDatetime", orderDatetime);
		StringUtil.appendSignPara(bufSignSrc, "queryDatetime", queryDatetime);
		StringUtil.appendLastSignPara(bufSignSrc, "key", md5Key);
		String signSrc = bufSignSrc.toString();
		String sign = SecurityUtil.MD5Encode(signSrc);

		Map<String, String> result = new HashMap<String, String>();
		try {
			StringBuilder builder = new StringBuilder(
					configureProvider.getProperty(PayVariavle.ALLINPAY_URL));
			builder.append("?merchantId=");
			builder.append(mermberId);
			builder.append("&version=");
			builder.append("v1.5");
			builder.append("&signType=");
			builder.append(signType);
			builder.append("&orderNo=");
			builder.append(order.id);
			builder.append("&orderDatetime=");
			builder.append(orderDatetime);
			builder.append("&queryDatetime=");
			builder.append(queryDatetime);
			builder.append("&signMsg=");
			builder.append(sign);

			URL url = new URL(builder.toString());
			HttpURLConnection httpURLConnection = (HttpURLConnection) url
					.openConnection();
			httpURLConnection.setRequestMethod("POST");
			httpURLConnection.setDoOutput(true);
			httpURLConnection.setDoInput(true);
			httpURLConnection.setUseCaches(false);

			httpURLConnection.getOutputStream().write(
					builder.toString().getBytes());

			httpURLConnection.getOutputStream().flush();
			httpURLConnection.getOutputStream().close();
			if (httpURLConnection.getResponseCode() == HttpURLConnection.HTTP_OK) {
				InputStream in = httpURLConnection.getInputStream();
				BufferedReader bufferedReader = new BufferedReader(
						new InputStreamReader(in));

				StringBuffer temp = new StringBuffer();
				String line = bufferedReader.readLine();
				while (line != null) {
					temp.append(line).append("\r\n");
					line = bufferedReader.readLine();
				}
				bufferedReader.close();

				String ecod = httpURLConnection.getContentEncoding();
				if (ecod == null)
					ecod = "UTF-8";
				String strResponse = temp.toString();

				// 解析查询返回结果
				strResponse = URLDecoder.decode(strResponse, ecod);
				String[] parameters = strResponse.split("&");
				for (int i = 0; i < parameters.length; i++) {
					String msg = parameters[i];
					int index = msg.indexOf('=');
					if (index > 0) {
						String name = msg.substring(0, index);
						String value = msg.substring(index + 1);
						result.put(name, value);
					}
				}

				// 查询结果会以Server方式通知商户(同支付返回)；
				// 若无法取得Server通知结果，可以通过解析查询返回结果，更新订单状态(参考如下).
				if (null != result.get("ERRORCODE")) {
					// 未查询到订单
					out.print("订单未提交到通联支付系统");
				} else {
					// 查询到订单
					String payResult = result.get("payResult");
					if (payResult.equals("1")) {
						// 支付成功，验证签名
						PaymentResult paymentResult = new PaymentResult();
						paymentResult.setMerchantId(result.get("merchantId"));
						paymentResult.setVersion(result.get("version"));
						paymentResult.setLanguage(result.get("language"));
						paymentResult.setSignType(result.get("signType"));
						paymentResult.setPayType(result.get("payType"));
						paymentResult.setIssuerId(result.get("issuerId"));
						paymentResult.setPaymentOrderId(result
								.get("paymentOrderId"));
						paymentResult.setOrderNo(result.get("orderNo"));
						paymentResult.setOrderDatetime(result
								.get("orderDatetime"));
						paymentResult.setOrderAmount(result.get("orderAmount"));
						paymentResult.setPayAmount(result.get("payAmount"));
						paymentResult.setPayDatetime(result.get("payDatetime"));
						paymentResult.setPayResult(result.get("payResult"));
						paymentResult.setErrorCode(result.get("errorCode"));
						paymentResult.setReturnDatetime(result
								.get("returnDatetime"));
						paymentResult.setKey(md5Key);
						paymentResult.setSignMsg(result.get("signMsg"));
						paymentResult.setCertPath(getCert(getServletContext()));

						boolean verifyResult = paymentResult.verify();

						if (verifyResult) {
							out.print("<p>订单状态更正成功，已成功修改您的账户数据，请查看确认。</p>");
							Map<String, String> pps = new HashMap<>();
							pps.put("paymentOrderId", result.get("paymentOrderId"));
							getResourceProvider().getResource(ChargeOrderExecutor.class).confirm(
									order.id, pps);
						} else {
							out.print("订单支付成功，验签失败！更新订单状态失败，有问题请与客服联系！");
						}
					} else {
						out.print("订单支付结果：失败");
					}
				}
			}
			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
			out.print(e);
		}
	}

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}
}
