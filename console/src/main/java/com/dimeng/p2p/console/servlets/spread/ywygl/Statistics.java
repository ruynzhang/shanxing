package com.dimeng.p2p.console.servlets.spread.ywygl;

import java.math.BigDecimal;
import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.console.servlets.spread.AbstractSpreadServlet;
import com.dimeng.p2p.modules.salesman.console.service.SalesmanManage;
import com.dimeng.p2p.modules.salesman.console.service.entity.Customers;
import com.dimeng.p2p.modules.salesman.console.service.query.CustomersQuery;
import com.dimeng.util.parser.IntegerParser;
import com.dimeng.util.parser.TimestampParser;
@Right(id = "P2P_C_SPREAD_TGXQ_SEARCH", isMenu=true, name = "业务员信息")
public class Statistics extends AbstractSpreadServlet{

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
		SalesmanManage manage = serviceSession.getService(SalesmanManage.class);
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
		
		CustomersQuery customersQuery = new CustomersQuery() {
			@Override
			public String ywyId() {
				return request.getParameter("ywyId");
			}
			
			@Override
			public String tel() {
				return request.getParameter("tel");
			}
			
			@Override
			public Timestamp startTime() {
				return TimestampParser.parse(request.getParameter("startTime"));
			}
			
			@Override
			public String name() {
				return request.getParameter("name");
			}
			
			@Override
			public Timestamp endTime() {
				return TimestampParser.parse(request.getParameter("endTime"));
			}
		};
		PagingResult<Customers> result = manage.search(customersQuery, paging);
		
		
		BigDecimal ljTotle= manage.ljTotle(customersQuery);
		request.setAttribute("result", result);
		request.setAttribute("ljTotle", ljTotle);
		forwardView(request, response, getClass());
	}


}
