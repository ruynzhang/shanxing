package com.dimeng.p2p.console.servlets.base.rank;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.base.AbstractBaseServlet;
import com.dimeng.p2p.modules.base.console.service.RankManage;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_BASE_RANK_DISABLERANK", name = "停用等级")
public class DisableRank extends AbstractBaseServlet {

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
		int id = IntegerParser.parse(request.getParameter("id"));
		manage.updateTy(id);
		sendRedirect(request, response,
					getController().getURI(request, SearchRank.class));
		
	}
}
