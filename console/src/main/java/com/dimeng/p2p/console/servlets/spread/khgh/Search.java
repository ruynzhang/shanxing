package com.dimeng.p2p.console.servlets.spread.khgh;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.p2p.console.servlets.system.AbstractSystemServlet;
import com.dimeng.p2p.modules.base.console.service.KhghManage;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_SPREAD_KHGH_SEARCH", isMenu = true, name = "客户关怀列表")
public class Search extends AbstractSystemServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		request.setAttribute("result", 
				serviceSession.getService(KhghManage.class).search(new Paging() {
					@Override
					public int getSize() {
						return 10;
					}
		
					@Override
					public int getCurrentPage() {
						return IntegerParser.parse(request.getParameter("paging.current"));
					}
		}));
		forwardView(request, response, Search.class);
	}
}
