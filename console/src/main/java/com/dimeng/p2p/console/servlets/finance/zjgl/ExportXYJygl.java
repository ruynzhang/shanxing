package com.dimeng.p2p.console.servlets.finance.zjgl;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.p2p.modules.account.console.service.FundsXYManage;
import com.dimeng.p2p.modules.account.console.service.entity.FundsXYJYView;
import com.dimeng.p2p.modules.account.console.service.query.FundsJYQuery;
import com.dimeng.util.parser.IntegerParser;
import com.dimeng.util.parser.TimestampParser;

@Right(id = "P2P_C_FINANCE_EXPORTXYJYGL", name = "信用水导出")
public class ExportXYJygl extends AbstractFinanceServlet {
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
		response.setHeader("Content-disposition", "attachment;filename="
				+ new Timestamp(System.currentTimeMillis()).getTime() + ".csv");
		response.setContentType("application/csv");
		FundsXYManage fundsXYManage = serviceSession
				.getService(FundsXYManage.class);
		PagingResult<FundsXYJYView> result = fundsXYManage.xyjlSearch(
				new FundsJYQuery() {

					@Override
					public int getType() {
						return IntegerParser.parse(request.getParameter("type"));
					}

					@Override
					public Timestamp getStartPayTime() {
						return TimestampParser.parse(request
								.getParameter("startPayTime"));
					}

					@Override
					public Timestamp getEndPayTime() {
						return TimestampParser.parse(request
								.getParameter("endPayTime"));
					}

					@Override
					public int getId() {
						return IntegerParser.parse(request.getParameter("id"));
					}
				}, new Paging() {

					@Override
					public int getSize() {
						return Integer.MAX_VALUE;
					}

					@Override
					public int getCurrentPage() {
						return IntegerParser.parse(request
								.getParameter(PAGING_CURRENT));
					}
				});

		fundsXYManage.export(result.getItems(), response.getOutputStream(), "");
	}

}
