package com.dimeng.p2p.console.servlets.base.dywlx;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.S62.entities.T6213;
import com.dimeng.p2p.S62.enums.T6213_F03;
import com.dimeng.p2p.console.servlets.base.AbstractBaseServlet;
import com.dimeng.p2p.modules.base.console.service.DywlxManage;
import com.dimeng.util.parser.EnumParser;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_BASE_DYWLXLIST", isMenu = true, name = "抵押物类型管理")
public class DywlxList extends AbstractBaseServlet {
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
		DywlxManage manage = serviceSession.getService(DywlxManage.class);
		PagingResult<T6213> result = manage.search(request.getParameter("f02"), EnumParser.parse(T6213_F03.class, request.getParameter("f03")), 
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
		request.setAttribute("result", result);
		forwardView(request, response, getClass());
	}
}
