package com.dimeng.p2p.console.servlets.account.kfxx;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.p2p.console.servlets.account.AbstractAccountServlet;
import com.dimeng.p2p.modules.account.console.service.KhjlManage;
import com.dimeng.p2p.modules.account.console.service.entity.Grxx;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_ACCOUNT_KFXX_KFLIST", isMenu=true, name = "客户信息列表")
public class KfList extends AbstractAccountServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			final HttpServletResponse response,
			final ServiceSession serviceSession) throws Throwable {
		KhjlManage manage = serviceSession.getService(KhjlManage.class);
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
		Grxx grxx = new Grxx();
		grxx.parse(request);
		request.setAttribute("list", manage.search(grxx, paging));
		forwardView(request, response, getClass());
	}

}
