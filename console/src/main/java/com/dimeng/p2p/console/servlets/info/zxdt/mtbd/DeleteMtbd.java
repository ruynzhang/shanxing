package com.dimeng.p2p.console.servlets.info.zxdt.mtbd;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.info.AbstractInformationServlet;
import com.dimeng.p2p.modules.base.console.service.ArticleManage;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_INFO_MTBD_DELETE", name = "删除媒体报道")
public class DeleteMtbd extends AbstractInformationServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(final HttpServletRequest request,
			final HttpServletResponse response,
			final ServiceSession serviceSession) throws Throwable {
		ArticleManage articleManage = serviceSession
				.getService(ArticleManage.class);
		articleManage.delete(IntegerParser.parseArray(request
				.getParameterValues("id")));
		sendRedirect(request, response,
				getController().getURI(request, SearchMtbd.class));
	}

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}

}
