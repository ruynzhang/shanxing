package com.dimeng.p2p.console.servlets.finance.jgbyj;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.common.enums.OrganizationType;
import com.dimeng.p2p.modules.finance.console.service.JgbyjglManage;
import com.dimeng.p2p.modules.finance.console.service.entity.Jgfxbyj;
import com.dimeng.p2p.modules.finance.console.service.query.JgfxbyjglQuery;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.util.parser.EnumParser;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_FINANCE_EXPORTJGBYJ", name = "机构风险备用金管理导出")
public class ExportJgbyj extends AbstractFinanceServlet {
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
		PagingResult<Jgfxbyj> result = jgbyjglManage.search(
				new JgfxbyjglQuery() {

					@Override
					public OrganizationType getType() {
						return EnumParser.parse(OrganizationType.class,
								request.getParameter("type"));
					}

					@Override
					public String getOrganizationName() {
						return request.getParameter("name");
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
