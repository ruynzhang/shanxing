package com.dimeng.p2p.console.servlets.spread.tgxq;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.modules.spread.console.service.SpreadManage;
import com.dimeng.p2p.modules.spread.console.service.entity.SpreadDetailList;
import com.dimeng.p2p.modules.spread.console.service.entity.SpreadDetailQuery;
import com.dimeng.p2p.console.servlets.spread.AbstractSpreadServlet;
import com.dimeng.util.parser.IntegerParser;
import com.dimeng.util.parser.TimestampParser;
@Right(id = "P2P_C_SPREAD_TGXQ_SEARCH", isMenu=true, name = "推广详情列表")
public class SearchTgxq extends AbstractSpreadServlet{

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
		SpreadDetailQuery query = new SpreadDetailQuery() {
			
			@Override
			public String userName() {
				return request.getParameter("userName");
			}
			
			@Override
			public Timestamp startTime() {
				return TimestampParser.parse(request.getParameter("startTime"));
			}
			
			@Override
			public String personUserName() {
				return request.getParameter("personUserName");
			}
			
			@Override
			public String personName() {
				return request.getParameter("personName");
			}
			
			@Override
			public int personID() {
				return IntegerParser.parse(request.getParameter("personID"));
			}
			
			@Override
			public String name() {
				return request.getParameter("name");
			}
			
			@Override
			public int id() {
				return IntegerParser.parse(request.getParameter("id"));
			}
			
			@Override
			public Timestamp endTime() {
				return TimestampParser.parse(request.getParameter("endTime"));
			}
		};
		PagingResult<SpreadDetailList> result = manage.searchSpreadDetailList(query, paging);
		request.setAttribute("result", result);
		forwardView(request, response, getClass());
	}


}
