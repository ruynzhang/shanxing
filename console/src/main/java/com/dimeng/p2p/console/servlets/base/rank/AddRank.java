package com.dimeng.p2p.console.servlets.base.rank;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S51.entities.T5127;
import com.dimeng.p2p.console.servlets.base.AbstractBaseServlet;
import com.dimeng.p2p.modules.base.console.service.RankManage;

@Right(id = "P2P_C_BASE_RANK_ADDRANK", name = "添加等级")
public class AddRank extends AbstractBaseServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		RankManage manage = serviceSession.getService(RankManage.class);
		T5127 entity = new T5127();
		entity.parse(request);
		manage.add(entity);
		sendRedirect(request, response,
				getController().getURI(request, SearchRank.class));
	}

}
