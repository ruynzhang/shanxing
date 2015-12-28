package com.dimeng.p2p.console.servlets.spread.hdgl;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.modules.spread.console.service.ActivityManage;
import com.dimeng.p2p.modules.spread.console.service.entity.PartakePersonList;
import com.dimeng.p2p.modules.spread.console.service.entity.PartakeQuery;
import com.dimeng.p2p.modules.spread.console.service.entity.PartakeTotalInfo;
import com.dimeng.p2p.console.servlets.spread.AbstractSpreadServlet;
import com.dimeng.util.parser.IntegerParser;
import com.dimeng.util.parser.TimestampParser;
@Right(id = "P2P_C_SPREAD_HDGL_SEARCHCYR", name = "查询参与人列表")
public class SearchCyr extends AbstractSpreadServlet{

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
		ActivityManage manage = serviceSession.getService(ActivityManage.class);
		int id = IntegerParser.parse(request.getParameter("id"));
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
		PartakeQuery query = new PartakeQuery() {
			
			@Override
			public String userName() {
				return request.getParameter("userName");
			}
			
			@Override
			public Timestamp startTime() {
				return  TimestampParser.parse(request.getParameter("startTime"));
			}
			
			@Override
			public Timestamp endTime() {
				return TimestampParser.parse(request.getParameter("endTime"));
			}
			
		};

		PagingResult<PartakePersonList> result = manage.searchPartake(id, query, paging);
		request.setAttribute("result", result);
		PartakeTotalInfo totalInfo = manage.getPartakeTotalInfo(id);
		request.setAttribute("totalInfo", totalInfo);
		forwardView(request, response, getClass());
	}

}
