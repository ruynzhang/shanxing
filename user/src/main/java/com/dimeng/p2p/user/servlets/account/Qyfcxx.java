package com.dimeng.p2p.user.servlets.account;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.p2p.account.user.service.QyBaseManage;
import com.dimeng.util.parser.IntegerParser;

public class Qyfcxx extends AbstractAccountServlet{

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		QyBaseManage manage = serviceSession.getService(QyBaseManage.class);
		Paging paging = new Paging() {
			
			@Override
			public int getSize() {
				return 10;
			}
			
			@Override
			public int getCurrentPage() {
				return IntegerParser.parse(request.getParameter(PAGING_CURRENT));
			}
		};
		request.setAttribute("result",manage.getQyfcxx(paging));
		forwardView(request, response, getClass());
		
		
	}

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

}
