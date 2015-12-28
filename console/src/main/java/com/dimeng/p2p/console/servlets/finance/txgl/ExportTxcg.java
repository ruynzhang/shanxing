package com.dimeng.p2p.console.servlets.finance.txgl;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.S61.enums.T6110_F06;
import com.dimeng.p2p.S61.enums.T6130_F09;
import com.dimeng.p2p.modules.account.console.service.UserWithdrawalsManage;
import com.dimeng.p2p.modules.account.console.service.entity.UserWithdrawals;
import com.dimeng.p2p.modules.account.console.service.query.TxglRecordQuery;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.util.parser.EnumParser;
import com.dimeng.util.parser.IntegerParser;
import com.dimeng.util.parser.TimestampParser;

@Right(id = "P2P_C_FINANCE_EXPORTTXGL", name = "导出提现记录")
public class ExportTxcg extends AbstractFinanceServlet {
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
		UserWithdrawalsManage extraction = serviceSession
				.getService(UserWithdrawalsManage.class);
		response.setHeader("Content-disposition", "attachment;filename="
				+ new Timestamp(System.currentTimeMillis()).getTime() + ".csv");
		response.setContentType("application/csv");
		PagingResult<UserWithdrawals> result = extraction.search(
				new TxglRecordQuery() {

					@Override
					public String getYhm() {
						return request.getParameter("yhm");
					}

					@Override
					public String getYhkh() {
						return request.getParameter("yhkh");
					}

					@Override
					public Timestamp getStartExtractionTime() {
						return TimestampParser.parse(request
								.getParameter("startExtractonTime"));
					}

					@Override
					public Timestamp getEndExtractionTime() {
						return TimestampParser.parse(request
								.getParameter("endExtractionTime"));
					}

					@Override
					public int getBankId() {
						return IntegerParser.parse(request
								.getParameter("bankId"));
					}

					@Override
					public T6130_F09 getStatus() {
						return T6130_F09.YFK;
					}

					@Override
					public T6110_F06 getUserType() {
						return EnumParser.parse(T6110_F06.class,
								request.getParameter("userType"));
					}

					@Override
					public String getLsh() {
						return request.getParameter("lsh");
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
		extraction.exportYtx(result.getItems(), response.getOutputStream(), "");
	}
}
