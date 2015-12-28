package com.dimeng.p2p.console.servlets.info.wzgg;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.modules.base.console.service.NoticeManage;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_INFO_WZGG_DELETE", name = "删除网站公告")
public class DeleteWzgg extends AbstractWzggServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processGet(request, response, serviceSession);
	}

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		NoticeManage manage = serviceSession.getService(NoticeManage.class);
		manage.delete(IntegerParser.parseArray(request.getParameterValues("id")));
		sendRedirect(request, response,
				getController().getURI(request, SearchWzgg.class));
	}

}
