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
import com.dimeng.p2p.pay.util.MD5Util;
import com.dimeng.p2p.variables.defines.PayVariavle;
import com.dimeng.util.StringHelper;
import com.dimeng.util.parser.IntegerParser;

public class ShuangqianCheck extends AbstractShuangqianServlet {

	private static final long serialVersionUID = 1L;
	
	private static Map<String, String> orderMap = new HashMap<>();
	private static Map<String, String> succeedMap = new HashMap<>();
	static{
		orderMap.put("0", "失败");
		orderMap.put("1", "成功");
		orderMap.put("2", "待处理");
		orderMap.put("3", "取消");
		orderMap.put("3", "结果未返回");
		
		succeedMap.put("success", "信息验证成功，订单查询过程完整");
		succeedMap.put("Error_01", "订单号为空，取消查询");
		succeedMap.put("Error_02", "商户号为空，取消查询");
		succeedMap.put("Error_03", "返回地址为空，取消查询");
		succeedMap.put("Error_04", "MD5加密字符串为空，取消查询");
		succeedMap.put("Error_05", "订单不存在，取消查询");
		succeedMap.put("Error_06", "商户不存在，取消查询");
		succeedMap.put("Error_07", "MD5加密字符串验证错误，取消查询");
		succeedMap.put("Error_08", "单号不唯一，取消查询");
	}
	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		ConfigureProvider configureProvider = ResourceRegister
				.getResourceProvider(getServletContext()).getResource(
						ConfigureProvider.class);
		String MD5key = configureProvider
				.getProperty(PayVariavle.SHUANGQIANPAY_MD5KEY);
		try {
			PrintWriter out = response.getWriter();

			String BillNo = request.getParameter("BillNo");
			String MerNo = request.getParameter("MerNo");
			String order = request.getParameter("order");
			String amount = request.getParameter("amount");
			String Date = request.getParameter("Date");
			String succeed = request.getParameter("succeed");
			String MD5ResultInfo = request.getParameter("MD5ResultInfo");

			MD5Util md5util = new MD5Util();
			String md5str = md5util.signCheckMap(new String[] { BillNo, Date, MerNo,
					amount, succeed}, MD5key, "RES");
			
			if(md5str.equals(MD5ResultInfo)){
				if("success".equals(succeed) && "1".equals(order)){
					Map<String, String> params = new HashMap<>();
					params.put("paymentOrderId", BillNo);
					getResourceProvider().getResource(ChargeOrderExecutor.class).confirm(
							IntegerParser.parse(BillNo), params);
				}
				if(!StringHelper.isEmpty(succeed)){
					out.print("<p>订单状态更正成功，已成功修改您的账户数据，请查看确认。</p>");
				}
			}
			if(!StringHelper.isEmpty(succeed)){
				out.print("<p>查询结果：");
				out.print(succeedMap.get(succeed));
				out.print("</p>");
			}
			if(!StringHelper.isEmpty(order)){
				out.print("<p>订单支付结果：");
				out.print(orderMap.get(order));
				out.print("</p>");
			}
		} catch (Exception e) {
			getResourceProvider().log(e);
		}
	}
	
	

}
