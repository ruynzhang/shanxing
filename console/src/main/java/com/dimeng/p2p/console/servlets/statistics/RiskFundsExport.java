package com.dimeng.p2p.console.servlets.statistics;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.modules.statistics.console.service.RiskFundsManage;
import com.dimeng.p2p.modules.statistics.console.service.entity.QuarterFunds;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_STATISTICS_RFEXPORT", name = "平台风险保证金数据导出")
public class RiskFundsExport extends AbstractStatisticsServlet {

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		int year = IntegerParser.parse(request.getParameter("year"));
		int orgId = IntegerParser.parse(request.getParameter("orgId"));
		response.setHeader("Content-disposition", "attachment;filename="
				+ new Timestamp(System.currentTimeMillis()).getTime() + ".csv");
		response.setContentType("application/csv");
		RiskFundsManage manage = serviceSession.getService(RiskFundsManage.class);
		QuarterFunds[] quarterFunds = manage.getQuarterFunds(orgId,year);
		manage.export(quarterFunds, response.getOutputStream(), "GBK");
	}
	
	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}

}
