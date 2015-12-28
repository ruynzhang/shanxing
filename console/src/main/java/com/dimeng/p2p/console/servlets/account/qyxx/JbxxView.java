package com.dimeng.p2p.console.servlets.account.qyxx;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.account.AbstractAccountServlet;
import com.dimeng.p2p.modules.account.console.service.EnterpriseManage;
import com.dimeng.p2p.modules.account.console.service.entity.AT6161;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_ACCOUNT_QYJBXXVIEW", name = "查询企业帐号详情")
public class JbxxView extends AbstractAccountServlet {

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
		EnterpriseManage manage = serviceSession.getService(EnterpriseManage.class);
		int userId = IntegerParser.parse(request.getParameter("userId"));
		AT6161 t6161Info = manage.getEnterprise(userId);
		
		request.setAttribute("t6161Info", t6161Info);
		forwardView(request, response, getClass());
	}
}
