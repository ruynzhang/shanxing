package com.dimeng.p2p.console.servlets.info.kfzx;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.modules.base.console.service.CustomerServiceManage;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_INFO_KFZX_DELETE", name = "删除客户中心")
public class DeleteKfzx extends AbstractKfzxServlet {

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
		CustomerServiceManage manage = serviceSession
				.getService(CustomerServiceManage.class);
		manage.delete(IntegerParser.parseArray(request.getParameterValues("id")));
		sendRedirect(request, response,
				getController().getURI(request, SearchKfzx.class));
	}

}
