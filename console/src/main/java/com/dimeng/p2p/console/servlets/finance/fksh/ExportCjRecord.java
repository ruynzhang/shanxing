package com.dimeng.p2p.console.servlets.finance.fksh;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.p2p.modules.bid.console.service.FkshManage;
import com.dimeng.p2p.modules.bid.console.service.entity.CjRecord;
import com.dimeng.p2p.modules.bid.console.service.query.CjRecordQuery;
import com.dimeng.util.parser.IntegerParser;
import com.dimeng.util.parser.TimestampParser;

@Right(id = "P2P_C_FINANCE_EXPORCJRECORD", name = "放款成交记录导出")
public class ExportCjRecord extends AbstractFinanceServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			final HttpServletResponse response,
			final ServiceSession serviceSession) throws Throwable {
		FkshManage fkshManage = serviceSession.getService(FkshManage.class);
		response.setHeader("Content-disposition", "attachment;filename="
				+ new Timestamp(System.currentTimeMillis()).getTime() + ".csv");
		response.setContentType("application/csv");
		PagingResult<CjRecord> result = fkshManage.search(new CjRecordQuery() {

			@Override
			public int getType() {
				return IntegerParser.parse(request.getParameter("type"));
			}

			@Override
			public Timestamp getStartTime() {
				return TimestampParser.parse(request.getParameter("startTime"));
			}

			@Override
			public String getUserName() {
				return request.getParameter("loanName");
			}

			@Override
			public Timestamp getEndTime() {
				return TimestampParser.parse(request.getParameter("endTime"));
			}
		}, new Paging() {
			@Override
			public int getSize() {
				return Integer.MAX_VALUE;
			}

			@Override
			public int getCurrentPage() {
				return IntegerParser
						.parse(request.getParameter(PAGING_CURRENT));
			}
		});
		fkshManage.export(result.getItems(), response.getOutputStream(), "");
	}
}
