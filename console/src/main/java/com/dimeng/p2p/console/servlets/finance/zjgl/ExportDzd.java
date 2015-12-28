package com.dimeng.p2p.console.servlets.finance.zjgl;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.p2p.modules.account.console.service.FundsDzdManage;
import com.dimeng.p2p.modules.account.console.service.entity.ExcelParameter;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_FINANCE_TJBBDZD", name = "统计报表对账单")
public class ExportDzd extends AbstractFinanceServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request, HttpServletResponse response, ServiceSession serviceSession) throws Throwable {
		processPost(request, response, serviceSession);
	}

	@Override
	protected void processPost(final HttpServletRequest request, final HttpServletResponse response, final ServiceSession serviceSession) throws Throwable {
		// 定义,初始化
		ExcelParameter excelParameter = new ExcelParameter();
		String fileName = new Timestamp(System.currentTimeMillis()).getTime() + ".xls";
		FundsDzdManage manage = serviceSession.getService(FundsDzdManage.class);
		String serverPath = request.getSession().getServletContext().getRealPath("/");
		String webInforSec = "WEB-INF\\upload\\xls\\";
		String writePath = serverPath + webInforSec + fileName;
		excelParameter.setWritePath(writePath);

		// 参数获取
		int zjId = IntegerParser.parse(request.getParameter("id"));// 资金Id
		String endTime = request.getParameter("endTime");
		String startTime = request.getParameter("startTime");

		// 开始下载
		manage.download(zjId, startTime, endTime, excelParameter, response);
	}
}