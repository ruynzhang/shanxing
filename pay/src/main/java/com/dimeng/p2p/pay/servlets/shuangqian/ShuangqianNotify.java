package com.dimeng.p2p.pay.servlets.shuangqian;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.resource.ResourceRegister;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.order.ChargeOrderExecutor;
import com.dimeng.p2p.pay.servlets.AbstractPayServlet;
import com.dimeng.p2p.pay.util.MD5Util;
import com.dimeng.p2p.variables.defines.PayVariavle;
import com.dimeng.util.parser.IntegerParser;

public class ShuangqianNotify extends AbstractPayServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		ConfigureProvider configureProvider = ResourceRegister
				.getResourceProvider(getServletContext()).getResource(
						ConfigureProvider.class);
		String MD5key = configureProvider
				.format(PayVariavle.SHUANGQIANPAY_MD5KEY);
		try {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();

			String MerNo = request.getParameter("MerNo");
			String BillNo = request.getParameter("BillNo");
			String Amount = request.getParameter("Amount");
			String Succeed = request.getParameter("Succeed");
			String Result = request.getParameter("Result");
			String MD5info = request.getParameter("MD5info");
			MD5Util md5util = new MD5Util();
			String md5str = md5util.signMap(new String[] { Amount, BillNo,
					MerNo, Succeed }, MD5key, "RES");
			if (MD5info.equals(md5str)) {
				if (Succeed.equals("88")) {
					Map<String, String> params = new HashMap<>();
					params.put("paymentOrderId", BillNo);
					getResourceProvider()
							.getResource(ChargeOrderExecutor.class).confirm(
									IntegerParser.parse(BillNo), params);
					out.print("<script>window.close();</script>");
				} else {
					out.print(Result);
				}
			} else {
				out.print("电子签名错误");
			}
			out.flush();
			out.close();
		} catch (Exception e) {
			getResourceProvider().log(e);
		}
	}

	@Override
	protected boolean mustAuthenticated() {
		return false;
	}

}
