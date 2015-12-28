package com.dimeng.p2p.console.servlets.finance.jgbyj;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.common.enums.CreditStatus;
import com.dimeng.p2p.modules.finance.console.service.JgbyjglManage;
import com.dimeng.p2p.modules.finance.console.service.entity.JgywRecord;
import com.dimeng.p2p.modules.finance.console.service.query.JgywmxQuery;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.util.parser.EnumParser;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_FINANCE_EXPORTYWDETAIL", name = "机构风险备用金业务导出")
public class ExportYwDetail extends AbstractFinanceServlet {
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
		JgbyjglManage jgbyjglManage = serviceSession
				.getService(JgbyjglManage.class);
		response.setHeader("Content-disposition", "attachment;filename="
				+ new Timestamp(System.currentTimeMillis()).getTime() + ".csv");
		response.setContentType("application/csv");
		PagingResult<JgywRecord> result = jgbyjglManage.searchJgywmx(
				new JgywmxQuery() {

					@Override
					public String getTitle() {
						return request.getParameter("title");
					}

					@Override
					public CreditStatus getStatus() {
						return EnumParser.parse(CreditStatus.class,
								request.getParameter("status"));
					}

					@Override
					public String getAccount() {
						return request.getParameter("account");
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
		jgbyjglManage.export(result.getItems(), response.getOutputStream(), "");
	}
}
