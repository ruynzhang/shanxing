package com.dimeng.p2p.user.servlets.capital;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.p2p.account.user.service.OrderManage;
import com.dimeng.util.parser.IntegerParser;
import com.dimeng.util.parser.TimestampParser;

public class OrderServlet extends AbstractCapitalServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		OrderManage service=serviceSession.getService(OrderManage.class);
		Paging paging=new Paging(){
			public int getCurrentPage(){
					return IntegerParser.parse(request.getParameter(PAGING_CURRENT));
			}
			
			public int getSize(){
					return 10;
			}
		};
		int type = IntegerParser.parse(request.getParameter("type")); 
		Timestamp startTime = TimestampParser.parse(request.getParameter("startTime"));
		Timestamp endTime = TimestampParser.parse(request.getParameter("endTime"));
		request.setAttribute("reslut", service.search(type,startTime,endTime,paging));
		forwardView(request, response, getClass());
	}

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
		
	}
	

}
