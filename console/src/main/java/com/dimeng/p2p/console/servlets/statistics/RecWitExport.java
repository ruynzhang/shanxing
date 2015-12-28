package com.dimeng.p2p.console.servlets.statistics;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.modules.statistics.console.service.RechargeWithdrawManage;
import com.dimeng.p2p.modules.statistics.console.service.entity.RecWit;
import com.dimeng.p2p.modules.statistics.console.service.entity.RecWitTotal;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_STATISTICS_RWEXPORT", name = "平台充值提现数据导出")
public class RecWitExport extends AbstractStatisticsServlet {

	private static final long serialVersionUID = 1L;
	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		int year = IntegerParser.parse(request.getParameter("year"));
		response.setHeader("Content-disposition", "attachment;filename="
				+ new Timestamp(System.currentTimeMillis()).getTime() + ".csv");
		response.setContentType("application/csv");
		RechargeWithdrawManage manage = serviceSession.getService(RechargeWithdrawManage.class);
		RecWit[] recWits = manage.getRechargeWithdraws(year);
		RecWitTotal recWitTotal = manage.getRecWitTotal(year);
		manage.export(recWits, recWitTotal, response.getOutputStream(), "GBK");
	}
	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}
}
