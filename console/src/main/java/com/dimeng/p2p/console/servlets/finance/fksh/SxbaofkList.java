package com.dimeng.p2p.console.servlets.finance.fksh;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.S62.entities.SxbaoFksh;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.p2p.service.SxbaoManage;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_FINANCE_SXBAOFKLIST", name = "善行宝放款审核列表")
public class SxbaofkList extends AbstractFinanceServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request, HttpServletResponse response, ServiceSession serviceSession) throws Throwable {
		processPost(request, response, serviceSession);
	}

	@Override
	protected void processPost(final HttpServletRequest request, HttpServletResponse response, ServiceSession serviceSession) throws Throwable {
		SxbaoManage sxbaoManage = serviceSession.getService(SxbaoManage.class);
		PagingResult<SxbaoFksh> result = sxbaoManage.searchSxbaoFksh(new Paging() {
			@Override
			public int getSize() {
				return 10;
			}

			@Override
			public int getCurrentPage() {
				return IntegerParser.parse(request.getParameter(PAGING_CURRENT));
			}
		});
		request.setAttribute("result", result);
		forwardView(request, response, getClass());
	}
}
