package com.dimeng.p2p.console.servlets.system.smsinfo;

import java.sql.Timestamp;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.common.ExpemonintBean;
import com.dimeng.p2p.common.SmsRecord;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.p2p.modules.bid.console.service.FkshManage;
import com.dimeng.p2p.modules.bid.console.service.query.FkshQuery;
import com.dimeng.p2p.modules.systematic.console.service.SmsManage;
import com.dimeng.util.parser.IntegerParser;
import com.dimeng.util.parser.TimestampParser;

@Right(id = "P2P_C_SYS_SMSINFOEXPORT", name = "短信发送管理导出")
public class SmsinfoExport extends AbstractFinanceServlet {

	private static final long serialVersionUID = 1L;
	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		response.setHeader("Content-disposition", "attachment;filename="
				+ new Timestamp(System.currentTimeMillis()).getTime() + ".csv");
		response.setContentType("application/csv");
		
		SmsManage smsManage = serviceSession.getService(SmsManage.class);
		String mobile = request.getParameter("mobile");
		String beginTime = request.getParameter("createTimeStart");
		String endTime = request.getParameter("createTimeEnd");
		SmsRecord[] list = smsManage.sesmsExport(mobile, beginTime, endTime);
		
		smsManage.exporsmsrecord(list, response.getOutputStream(), "GBK");//导出数据
	}
	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}
}
