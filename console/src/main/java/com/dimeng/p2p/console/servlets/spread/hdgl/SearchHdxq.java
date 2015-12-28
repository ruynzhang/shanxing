package com.dimeng.p2p.console.servlets.spread.hdgl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.modules.spread.console.service.ActivityManage;
import com.dimeng.p2p.modules.spread.console.service.entity.ActivityList;
import com.dimeng.p2p.console.servlets.spread.AbstractSpreadServlet;
import com.dimeng.util.parser.IntegerParser;
@Right(id = "P2P_C_SPREAD_HDGL_SEARCHHDXQ", name = "查询活动详情")
public class SearchHdxq extends AbstractSpreadServlet{

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
		ActivityManage manage = serviceSession.getService(ActivityManage.class);
		int id = IntegerParser.parse(request.getParameter("id"));
		ActivityList result = manage.getActivity(id);
		request.setAttribute("result", result);
		forwardView(request, response, getClass());
	}

}
