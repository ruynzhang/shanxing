package com.dimeng.p2p.console.servlets.bid.sxbaogl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S62.entities.SxbaoConfig;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.service.SxbaoManage;

public class OutSxbao extends AbstractBidServlet{

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void processGet(HttpServletRequest request, HttpServletResponse response, ServiceSession serviceSession) throws Throwable {
		processPost(request, response, serviceSession);
	}
	
	@Override
	protected void processPost(HttpServletRequest request, HttpServletResponse response, ServiceSession serviceSession) throws Throwable {
		Long cid = Long.valueOf(request.getParameter("id"));
		SxbaoManage sxbaoManage = serviceSession.getService(SxbaoManage.class);
		serviceSession.openTransactions();
		SxbaoConfig sxbaoConfig = sxbaoManage.findConfigById(cid);
		
	}
}
