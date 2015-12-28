package com.dimeng.p2p.console.servlets.bid.sxbaogl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S62.entities.SxbaoType;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.service.SxbaoManage;

public class AddSxbaoType extends AbstractBidServlet {

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void processGet(HttpServletRequest request, HttpServletResponse response, ServiceSession serviceSession) throws Throwable {
		super.processGet(request, response, serviceSession);
	}
	
	@Override
	protected void processPost(HttpServletRequest request, HttpServletResponse response, ServiceSession serviceSession) throws Throwable {
		SxbaoType type = new SxbaoType();
		type.parse(request);
		SxbaoManage sxbaoManage = serviceSession.getService(SxbaoManage.class);
		sxbaoManage.addType(type);
		getController().prompt(request, response, PromptLevel.WARRING,
				"保存成功");
		processGet(request, response, serviceSession);
	}
}
