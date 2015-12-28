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
import com.dimeng.p2p.S61.enums.T6101_F03;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.p2p.modules.account.console.service.FundsJYManage;
import com.dimeng.p2p.modules.account.console.service.entity.FundsJYView;
import com.dimeng.p2p.modules.account.console.service.entity.UserTotle;
import com.dimeng.p2p.modules.account.console.service.query.FundsJYQuery;
import com.dimeng.util.parser.IntegerParser;
import com.dimeng.util.parser.TimestampParser;

@Right(id = "P2P_C_FINANCE_ZJJYJLLIST", name = "资金管理交易记录")
public class ZJjyList extends AbstractFinanceServlet {
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
		FundsJYManage fundsJYManage = serviceSession
				.getService(FundsJYManage.class);

		int id = IntegerParser.parse(request.getParameter("id"));
		String loginName = request.getParameter("name");
		T6101_F03 t6101_F03 = fundsJYManage.getType(id);
		List<T5122> tradeTypes = fundsJYManage.getTradeTypes();
		PagingResult<FundsJYView> result = fundsJYManage.search(
				new FundsJYQuery() {

					@Override
					public int getType() {
						return IntegerParser.parse(request.getParameter("type"));
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
		UserTotle userTotle = fundsJYManage.getUserTotle(id);
		userTotle.loginName = loginName;
		request.setAttribute("t6101_F03", t6101_F03);
		request.setAttribute("id", id);
		request.setAttribute("result", result);
		request.setAttribute("userTotle", userTotle);
		request.setAttribute("tradeTypes",
				tradeTypes.toArray(new T5122[tradeTypes.size()]));
		forwardView(request, response, getClass());
	}
}
