package com.dimeng.p2p.console.servlets.finance.order;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.console.servlets.base.AbstractBaseServlet;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.p2p.modules.account.console.service.OrderManager;
import com.dimeng.p2p.modules.account.console.service.entity.Order;
import com.dimeng.p2p.modules.account.console.service.query.OrderQuery;
import com.dimeng.util.parser.IntegerParser;
import com.dimeng.util.parser.TimestampParser;

@Right(id = "P2P_C_FINANCE_ORDERLIST", isMenu = true, name = "订单管理")
public class OrderList extends AbstractFinanceServlet {
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
		OrderManager orderManager = serviceSession
				.getService(OrderManager.class);
		PagingResult<Order> result = orderManager.search(new OrderQuery() {

			@Override
			public String getUserName() {
				return request.getParameter("userName");
			}

			@Override
			public Timestamp getEndStart() {
				return TimestampParser.parse(request.getParameter("endStart"));
			}

			@Override
			public Timestamp getCreateStart() {
				return TimestampParser.parse(request
						.getParameter("createStart"));
			}

			@Override
			public int getType() {
				return IntegerParser.parse(request.getParameter("type"));
			}
		}, new Paging() {

			@Override
			public int getSize() {
				return 10;
			}

			@Override
			public int getCurrentPage() {
				return IntegerParser.parse(request
						.getParameter(AbstractBaseServlet.PAGING_CURRENT));
			}
		});
		request.setAttribute("result", result);
		forwardView(request, response, getClass());
	}
}
