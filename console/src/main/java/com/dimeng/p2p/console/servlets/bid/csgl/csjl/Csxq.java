package com.dimeng.p2p.console.servlets.bid.csgl.csjl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;

@Right(id = "P2P_C_BUSI_CS_CSVIEW", name = "催收记录详情")
public class Csxq extends AbstractBidServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void processPost(final HttpServletRequest request,final HttpServletResponse response,
			final ServiceSession serviceSession) throws Throwable {
		
	}

}
