package com.dimeng.p2p.console.servlets.base.rank;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S51.entities.T5127;
import com.dimeng.p2p.console.servlets.base.AbstractBaseServlet;
import com.dimeng.p2p.modules.base.console.service.RankManage;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_BASE_RANK_UPDATERANK", name = "修改等级信息")
public class UpdateRank extends AbstractBaseServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		RankManage manage = serviceSession.getService(RankManage.class);
		int id = IntegerParser.parse(request.getParameter("id"));
		T5127 rank = manage.get(id);
		request.setAttribute("rank", rank);
		forwardView(request, response, getClass());
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		RankManage manage = serviceSession.getService(RankManage.class);
		T5127 entity = new T5127();
		entity.parse(request);
		manage.update(entity);
		sendRedirect(request, response,
				getController().getURI(request, SearchRank.class));
	}

}
