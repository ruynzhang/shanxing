package com.dimeng.p2p.pay.servlets;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.PaymentInstitution;
import com.dimeng.p2p.S65.enums.T6501_F03;
import com.dimeng.p2p.modules.account.pay.service.ChargeManage;
import com.dimeng.p2p.modules.account.pay.service.entity.ChargeOrder;
import com.dimeng.p2p.pay.servlets.allinpay.AllinpayCheck;
import com.dimeng.p2p.pay.servlets.huichao.HuiChaoCheck;
import com.dimeng.p2p.pay.util.MD5Util;
import com.dimeng.p2p.variables.defines.PayVariavle;
import com.dimeng.util.parser.IntegerParser;

/**
 * 充值查询
 */
public class Check extends AbstractPayServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		response.setContentType("text/html; charset=utf-8");
		int o = IntegerParser.parse(request.getParameter("o"));
		ChargeManage manage = serviceSession.getService(ChargeManage.class);
		ChargeOrder order = manage.getOrder(o);
		if (order == null || order.payCompanyCode <= 0) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			return;
		}
		if (order.status == T6501_F03.CG) {
			PrintWriter out = response.getWriter();
			out.print("订单已支付成功");
			out.flush();
			out.close();
			return;
		}
		manage.updateOrder(o);
		serviceSession.commit();
		if (PaymentInstitution.ALLINPAY.getInstitutionCode() == order.payCompanyCode) {
			request.setAttribute("order", order);
			forwardController(request, response, AllinpayCheck.class);
			return;
		} else if (PaymentInstitution.SHUANGQIAN.getInstitutionCode() == order.payCompanyCode) {
			sendRedirect(request, response, sqCheckUrl(order.id));
			return;
		}else if(PaymentInstitution.HUICHAO.getInstitutionCode()== order.payCompanyCode){
			request.setAttribute("orderId", order.id);
			request.setAttribute("orderTime", order.orderTime);
			this.forwardController(request, response, HuiChaoCheck.class);
			return ;
		}
	}
	
	protected String sqCheckUrl(int orderId) throws Exception{
		ConfigureProvider configureProvider = getConfigureProvider();
		StringBuilder builder = new StringBuilder(
				configureProvider.format(PayVariavle.SHUANGQIANPAY_CHECK_URL));
		String BillNo = Integer.toString(orderId);
		String MerNo = configureProvider
				.format(PayVariavle.SHUANGQIANPAY_MERNO);
		String MerUrl = configureProvider
				.format(PayVariavle.SHUANGQIANPAY_CHECKRETURN_URL);
		String MD5key = configureProvider
				.format(PayVariavle.SHUANGQIANPAY_MD5KEY);
		MD5Util md5util = new MD5Util();
		String MD5info = md5util.signCheckMap(
				new String[] { BillNo, MerNo, MerUrl }, MD5key, "REQ");
		builder.append("?BillNo=");
		builder.append(BillNo);
		builder.append("&MerNo=");
		builder.append(MerNo);
		builder.append("&MerUrl=");
		builder.append(MerUrl);
		builder.append("&MD5Info=");
		builder.append(MD5info);
		return builder.toString();
	}

}
