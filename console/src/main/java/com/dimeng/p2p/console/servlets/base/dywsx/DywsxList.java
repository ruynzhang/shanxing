package com.dimeng.p2p.console.servlets.base.dywsx;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.S62.entities.T6213;
import com.dimeng.p2p.S62.entities.T6214;
import com.dimeng.p2p.console.servlets.base.AbstractBaseServlet;
import com.dimeng.p2p.modules.base.console.service.DywlxManage;
import com.dimeng.p2p.modules.base.console.service.DywsxManage;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_BASE_DYWSXLIST", isMenu = true, name = "抵押物属性管理")
public class DywsxList extends AbstractBaseServlet {
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
		DywsxManage dywsxManage = serviceSession.getService(DywsxManage.class);
		DywlxManage dywlxManage = serviceSession.getService(DywlxManage.class);
		PagingResult<T6214> result = dywsxManage.search(IntegerParser.parse(request.getParameter("f02")), request.getParameter("f03"), 
			new Paging() {

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
		T6213[] dywType = dywlxManage.getDyws();
		request.setAttribute("result", result);
		request.setAttribute("dywType", dywType);
		forwardView(request, response, getClass());
	}
}
