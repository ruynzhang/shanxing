package com.dimeng.p2p.user.servlets.account.ccxx;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.S61.entities.T6113;
import com.dimeng.p2p.account.user.service.UserBaseManage;
import com.dimeng.p2p.user.servlets.account.AbstractAccountServlet;
import com.dimeng.util.parser.IntegerParser;


public class Ccxx extends AbstractAccountServlet{
	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		UserBaseManage userManage = serviceSession.getService(UserBaseManage.class);
		PagingResult<T6113> result = userManage.seachCcxx(new Paging() {
			
			@Override
			public int getSize() {
				return 10;
			}
			
			@Override
			public int getCurrentPage() {
				return IntegerParser.parse(request.getParameter(PAGING_CURRENT));
			}
		});
		request.setAttribute("result", result);
		forwardView(request, response, getClass());
	}

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}
}
