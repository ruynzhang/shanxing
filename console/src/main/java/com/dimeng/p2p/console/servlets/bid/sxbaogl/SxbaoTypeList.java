package com.dimeng.p2p.console.servlets.bid.sxbaogl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.S62.entities.SxbaoType;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.service.SxbaoManage;
import com.dimeng.util.parser.IntegerParser;

//@Right(id = "P2P_C_FINANCE_SXBAOTYPELIST", name = "善行宝类型列表")
public class SxbaoTypeList extends AbstractBidServlet{
	
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void processGet(final HttpServletRequest request, HttpServletResponse response, ServiceSession serviceSession) throws Throwable {
		SxbaoManage sxbaoManage = serviceSession.getService(SxbaoManage.class);
		PagingResult<SxbaoType> result = sxbaoManage.searchType(new Paging() {
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
	protected void processPost(HttpServletRequest request, HttpServletResponse response, ServiceSession serviceSession) throws Throwable {
		processGet(request, response, serviceSession);
	}
}
