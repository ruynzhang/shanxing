package com.dimeng.p2p.console.servlets.finance.zjgl;

import java.sql.Timestamp;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.S51.entities.T5122;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.p2p.modules.account.console.service.FundsXYManage;
import com.dimeng.p2p.modules.account.console.service.entity.FundsXYJYView;
import com.dimeng.p2p.modules.account.console.service.query.FundsJYQuery;
import com.dimeng.util.parser.IntegerParser;
import com.dimeng.util.parser.TimestampParser;

@Right(id = "P2P_C_FINANCE_XYJLLIST", name = "信用交易记录")
public class XYjlList extends AbstractFinanceServlet {
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
		FundsXYManage fundsXYManage=serviceSession.getService(FundsXYManage.class);
		int id = IntegerParser.parse(request.getParameter("id"));
		List<T5122>  tradeTypes=fundsXYManage.getTradeTypes();
		PagingResult<FundsXYJYView> result = fundsXYManage.xyjlSearch(
				new FundsJYQuery() {

					@Override
					public int getType() {
						return  IntegerParser.parse(request.getParameter("type"));
					}

					@Override
					public Timestamp getStartPayTime() {
						return TimestampParser.parse(request
								.getParameter("startPayTime"));
					}

					@Override
					public Timestamp getEndPayTime() {
						return TimestampParser.parse(request
								.getParameter("endPayTime"));
					}

					@Override
					public int getId() {
						return IntegerParser.parse(request.getParameter("id"));
					}
				}, new Paging() {

					@Override
					public int getSize() {
						return 10;
					}

					@Override
					public int getCurrentPage() {
						return IntegerParser.parse(request
								.getParameter(PAGING_CURRENT));
					}
				});
		request.setAttribute("id", id);
		request.setAttribute("result", result);
		request.setAttribute("tradeTypes",tradeTypes.toArray(new T5122[tradeTypes.size()]));
		forwardView(request, response, getClass());
	}

}
