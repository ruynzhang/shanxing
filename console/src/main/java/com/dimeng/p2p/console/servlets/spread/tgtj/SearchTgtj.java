package com.dimeng.p2p.console.servlets.spread.tgtj;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.modules.spread.console.service.SpreadManage;
import com.dimeng.p2p.modules.spread.console.service.entity.SpreadTotalInfo;
import com.dimeng.p2p.modules.spread.console.service.entity.SpreadTotalList;
import com.dimeng.p2p.modules.spread.console.service.entity.SpreadTotalQuery;
import com.dimeng.p2p.console.servlets.spread.AbstractSpreadServlet;
import com.dimeng.util.parser.IntegerParser;
@Right(id = "P2P_C_SPREAD_TGTJ_SEARCH", isMenu=true, name = "推广奖励概要列表")
public class SearchTgtj extends AbstractSpreadServlet{

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		SpreadManage manage = serviceSession.getService(SpreadManage.class);
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
		
		SpreadTotalQuery query = new SpreadTotalQuery() {
			
			@Override
			public String userName() {
				return request.getParameter("userName");
			}
			
			@Override
			public String name() {
				return request.getParameter("name");
			}
			
			@Override
			public int id() {
				return IntegerParser.parse(request.getParameter("id"));
			}
		};
		PagingResult<SpreadTotalList> result = manage.searchTotalList(query, paging);
		SpreadTotalInfo totalInfo = manage.getSpreadTotal();
		request.setAttribute("result", result);
		request.setAttribute("totalInfo", totalInfo);
		forwardView(request, response, getClass());
		
	}


}
