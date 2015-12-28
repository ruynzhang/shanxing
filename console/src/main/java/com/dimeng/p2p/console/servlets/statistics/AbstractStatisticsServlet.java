package com.dimeng.p2p.console.servlets.statistics;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.AbstractConsoleServlet;

/**
 * 统计管理模块抽象Servlet
 * 
 */
public abstract class AbstractStatisticsServlet extends AbstractConsoleServlet {

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
		forwardView(request, response, getClass());
	}
}
