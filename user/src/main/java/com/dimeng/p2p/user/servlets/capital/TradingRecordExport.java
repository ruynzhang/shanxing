package com.dimeng.p2p.user.servlets.capital;

import java.sql.Timestamp;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.S61.enums.T6101_F03;
import com.dimeng.p2p.account.user.service.ZjlsManage;
import com.dimeng.p2p.account.user.service.entity.CapitalLs;
import com.dimeng.util.parser.DateParser;
import com.dimeng.util.parser.EnumParser;
import com.dimeng.util.parser.IntegerParser;

public class TradingRecordExport extends AbstractCapitalServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		ZjlsManage manage = serviceSession
				.getService(ZjlsManage.class);
		response.setHeader("Content-disposition", "attachment;filename="
				+ new Timestamp(System.currentTimeMillis()).getTime() + ".csv");
		response.setContentType("application/csv");
		int tradingType = IntegerParser.parse(request.getParameter("tt"));
		Date startTime = DateParser.parse(request.getParameter("startTime"));
		Date endTime = DateParser.parse(request.getParameter("endTime"));
		T6101_F03 f03 = EnumParser.parse(T6101_F03.class, request.getParameter("zhlx"));
		Paging paging = new Paging() {

			@Override
			public int getSize() {
				return Integer.MAX_VALUE;
			}

			@Override
			public int getCurrentPage() {
				return 1;
			}
		};
		PagingResult<CapitalLs> tradingRecords = manage.searchLs(
				tradingType, startTime, endTime,f03, paging);
		manage.export(tradingRecords.getItems(), response.getOutputStream(), "");
	}
	
	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}
}
