package com.dimeng.p2p.console.servlets.statistics;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.modules.statistics.console.service.FundsManage;
import com.dimeng.p2p.modules.statistics.console.service.entity.QuarterFunds;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_STATISTICS_FUNDSEXPORT", name = "平台资金数据导出")
public class FundsExport extends AbstractStatisticsServlet {

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		int year = IntegerParser.parse(request.getParameter("year"));
		response.setHeader("Content-disposition", "attachment;filename="
				+ new Timestamp(System.currentTimeMillis()).getTime() + ".csv");
		response.setContentType("application/csv");
		FundsManage manage = serviceSession.getService(FundsManage.class);
		QuarterFunds[] quarterFunds = manage.getQuarterFunds(year);
		manage.export(quarterFunds, response.getOutputStream(), "GBK");
	}
	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}
}
