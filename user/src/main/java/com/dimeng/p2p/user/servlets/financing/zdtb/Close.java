package com.dimeng.p2p.user.servlets.financing.zdtb;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.modules.bid.user.service.ZdtbManage;
import com.dimeng.p2p.user.servlets.financing.AbstractFinancingServlet;

public class Close extends AbstractFinancingServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 6455695252942810932L;
	
	
	@Override
	protected void processGet(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		
		ZdtbManage autoUtilFinacingManage=serviceSession.getService(ZdtbManage.class);
		autoUtilFinacingManage.close();
		
		forward(request, response, getController().getURI(request, Index.class));
	}

}
