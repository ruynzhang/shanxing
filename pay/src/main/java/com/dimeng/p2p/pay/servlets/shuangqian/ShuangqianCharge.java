package com.dimeng.p2p.pay.servlets.shuangqian;

import java.io.PrintWriter;
import java.math.BigDecimal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.PaymentInstitution;
import com.dimeng.p2p.modules.account.pay.service.ChargeManage;
import com.dimeng.p2p.modules.account.pay.service.entity.ChargeOrder;
import com.dimeng.p2p.order.ChargeOrderExecutor;
import com.dimeng.p2p.pay.util.MD5Util;
import com.dimeng.p2p.variables.defines.PayVariavle;
import com.dimeng.p2p.variables.defines.SystemVariable;
import com.dimeng.util.parser.BigDecimalParser;

public class ShuangqianCharge extends AbstractShuangqianServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		BigDecimal amount = BigDecimalParser.parse(request
				.getParameter("amount"));
		ChargeManage manage = serviceSession.getService(ChargeManage.class);
		ChargeOrder order = manage.addOrder(amount,
				PaymentInstitution.SHUANGQIAN.getInstitutionCode());
		serviceSession.commit();
		String location = createShuangqianUrl(order);
		getResourceProvider().getResource(ChargeOrderExecutor.class).submit(
				order.id, null);
		PrintWriter writer = response.getWriter();
		writer.print(location);
		writer.flush();
		writer.close();
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

		StringBuilder builder = new StringBuilder();
		builder.append("<form action=\"");
		builder.append(configureProvider.format(PayVariavle.SHUANGQIANPAY_URL));
		builder.append("\" method=\"post\">");
		builder.append("<input type=\"hidden\" name=\"MerNo\" value=\"");
		builder.append(MerNo);
		builder.append("\" />");
		builder.append("<input type=\"hidden\" name=\"BillNo\" value=\"");
		builder.append(order.id);
		builder.append("\" />");
		builder.append("<input type=\"hidden\" name=\"Amount\" value=\"");
		builder.append(orderAmount);
		builder.append("\" />");
		builder.append("<input type=\"hidden\" name=\"PayType\" value=\"");
		builder.append(PayType);
		builder.append("\" />");
		builder.append("<input type=\"hidden\" name=\"ReturnURL\" value=\"");
		builder.append(ReturnURL);
		builder.append("\" />");
		builder.append("<input type=\"hidden\" name=\"NotifyURL\" value=\"");
		builder.append(NotifyURL);
		builder.append("\" />");
		builder.append("<input type=\"hidden\" name=\"MD5info\" value=\"");
		builder.append(MD5info);
		builder.append("\" />");
		builder.append("<input type=\"hidden\" name=\"MerRemark\" value=\"");
		builder.append(MerRemark);
		builder.append("\" />");
		builder.append("<input type=\"hidden\" name=\"Products\" value=\"");
		builder.append(Products);
		builder.append("\" />");
		builder.append("</form>");
		builder.append("<script type=\"text/javascript\">");
		builder.append("document.forms[0].submit();");
		builder.append("</script>");
		return builder.toString();
	}
}
