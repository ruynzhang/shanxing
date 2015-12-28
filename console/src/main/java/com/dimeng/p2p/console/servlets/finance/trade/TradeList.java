package com.dimeng.p2p.console.servlets.finance.trade;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.p2p.modules.account.console.service.TradeManage;
import com.dimeng.p2p.modules.account.console.service.entity.TradeVo;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_FINANCE_TRADELIST", isMenu = true, name = "转账管理")
public class TradeList extends AbstractFinanceServlet {
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
		TradeManage manage = serviceSession.getService(TradeManage.class);
		TradeVo query = new TradeVo();
		query.parse(request);//设置界面传来的参数
		PagingResult<TradeVo> list = manage.search(query, new Paging() {
			@Override
			public int getSize() {
				return 10;
			}
			@Override
			public int getCurrentPage() {
				return IntegerParser.parse(request.getParameter(PAGING_CURRENT));
			}
		});
		request.setAttribute("list", list);
		forwardView(request, response, getClass());
	}
}
