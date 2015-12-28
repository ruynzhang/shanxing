package com.dimeng.p2p.console.servlets.base.rank;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.S51.entities.T5127;
import com.dimeng.p2p.console.servlets.base.AbstractBaseServlet;
import com.dimeng.p2p.modules.base.console.service.RankManage;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_BASE_RANK_SEARCHRANK", isMenu = true, name = "等级信息列表")
public class SearchRank extends AbstractBaseServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		RankManage manage = serviceSession.getService(RankManage.class);
		Paging paging = new Paging() {

			@Override
			public int getSize() {
				return 10;
			}

			@Override
			public int getCurrentPage() {
				return IntegerParser
						.parse(request.getParameter(PAGING_CURRENT));
			}
		};
		T5127 entity = new T5127();
		entity.parse(request);
		PagingResult<T5127> result = manage.seach(entity, paging);
		request.setAttribute("result", result);
		forwardView(request, response, getClass());
	}

}
