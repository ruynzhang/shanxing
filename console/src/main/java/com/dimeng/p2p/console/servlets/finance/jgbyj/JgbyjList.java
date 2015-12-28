package com.dimeng.p2p.console.servlets.finance.jgbyj;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.common.enums.OrganizationType;
import com.dimeng.p2p.modules.finance.console.service.JgbyjglManage;
import com.dimeng.p2p.modules.finance.console.service.entity.JgbyjStatistics;
import com.dimeng.p2p.modules.finance.console.service.entity.Jgfxbyj;
import com.dimeng.p2p.modules.finance.console.service.query.JgfxbyjglQuery;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.util.parser.EnumParser;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_FINANCE_JGBYJLIST", isMenu = true, name = "机构风险备用金管理")
public class JgbyjList extends AbstractFinanceServlet {
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
		JgbyjStatistics statistics = jgbyjglManage.getJgfxbyj();
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
						return 10;
					}

					@Override
					public int getCurrentPage() {
						return IntegerParser.parse(request
								.getParameter(PAGING_CURRENT));
					}
				});
		request.setAttribute("statistics", statistics);
		request.setAttribute("result", result);
		forwardView(request, response, getClass());
	}
}
