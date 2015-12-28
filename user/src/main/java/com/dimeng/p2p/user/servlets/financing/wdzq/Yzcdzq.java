package com.dimeng.p2p.user.servlets.financing.wdzq;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.PagingServlet;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.user.servlets.financing.AbstractFinancingServlet;
@PagingServlet(itemServlet = Yzcdzq.class)
public class Yzcdzq extends AbstractFinancingServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 19842188160942532L;

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		
	}

}
