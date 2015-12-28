package com.dimeng.p2p.console.servlets.base.xydj;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.S51.entities.T5124;
import com.dimeng.p2p.S51.enums.T5124_F05;
import com.dimeng.p2p.console.servlets.base.AbstractBaseServlet;
import com.dimeng.p2p.modules.base.console.service.CreditLevelManage;
import com.dimeng.p2p.modules.base.console.service.query.CreditLevelQuery;
import com.dimeng.util.parser.EnumParser;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_BASE_XYDJLIST", isMenu = true, name = "信用等级管理")
public class XydjList extends AbstractBaseServlet {
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
		CreditLevelManage creditLevelManage = serviceSession
				.getService(CreditLevelManage.class);
		PagingResult<T5124> result = creditLevelManage.search(
				new CreditLevelQuery() {

					@Override
					public String getName() {
						return request.getParameter("name");
					}

					@Override
					public T5124_F05 getStatus() {
						return EnumParser.parse(T5124_F05.class,
								request.getParameter("status"));
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

		request.setAttribute("result", result);
		forwardView(request, response, getClass());
	}

}
