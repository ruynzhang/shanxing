package com.dimeng.p2p.console.servlets.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.service.UserStatisticsManage;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.AbstractConsoleServlet;
import com.dimeng.p2p.modules.systematic.console.service.SysUserManage;
import com.dimeng.p2p.modules.systematic.console.service.entity.IndexCount;
import com.dimeng.p2p.variables.P2PConst;

public class Index extends AbstractConsoleServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		SysUserManage index = serviceSession.getService(SysUserManage.class);
		IndexCount indexCount = index.getIndexCount();
		boolean isOneLogin = index.isOneLogin();
		UserStatisticsManage userStatisticsManage = serviceSession
				.getService(UserStatisticsManage.class);
		indexCount.todayLoginUser = userStatisticsManage.getLoginCount(null,
				P2PConst.DB_USER_SESSION);
		indexCount.onlineUser = userStatisticsManage
				.getOnlineCount(P2PConst.DB_USER_SESSION);
		request.setAttribute("indexCount", indexCount);
		request.setAttribute("isOneLogin", isOneLogin);
		forwardView(request, response, Index.class);
	}

}
