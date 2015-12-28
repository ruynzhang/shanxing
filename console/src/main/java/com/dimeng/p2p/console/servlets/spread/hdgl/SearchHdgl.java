package com.dimeng.p2p.console.servlets.spread.hdgl;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.common.enums.ActivityStatus;
import com.dimeng.p2p.modules.spread.console.service.ActivityManage;
import com.dimeng.p2p.modules.spread.console.service.entity.ActivityList;
import com.dimeng.p2p.modules.spread.console.service.entity.ActivityQuery;
import com.dimeng.p2p.modules.spread.console.service.entity.ActivityTotalInfo;
import com.dimeng.p2p.console.servlets.spread.AbstractSpreadServlet;
import com.dimeng.util.parser.EnumParser;
import com.dimeng.util.parser.IntegerParser;
import com.dimeng.util.parser.TimestampParser;
@Right(id = "P2P_C_SPREAD_HDGL_SEARCHHDGL",isMenu=true, name = "活动管理")
public class SearchHdgl extends AbstractSpreadServlet{

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
		
		ActivityQuery query = new ActivityQuery() {
			
			@Override
			public String title() {
				return request.getParameter("title");
			}
			
			@Override
			public ActivityStatus status() {
				return EnumParser.parse(ActivityStatus.class, request.getParameter("status"));
			}
			
			@Override
			public Timestamp startTime() {
				return TimestampParser.parse(request.getParameter("startTime"));
			}
			
			@Override
			public Timestamp endTime() {
				return TimestampParser.parse(request.getParameter("endTime"));
			}
		};
		PagingResult<ActivityList> result = manage.searchActivity(query, paging);
		request.setAttribute("result", result);
		ActivityTotalInfo totalInfo = manage.getActivityTotalInfo();
		request.setAttribute("totalInfo", totalInfo);
		forwardView(request, response, getClass());
	}

	
	

}
