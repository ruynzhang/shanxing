package com.dimeng.p2p.console.servlets.finance.trade;

import java.sql.Timestamp;

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

@Right(id = "P2P_C_FINANCE_TRADEEXPORT", name = "导出转账明细")
public class TradeExport extends AbstractFinanceServlet {

	private static final long serialVersionUID = 1L;
	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		response.setHeader("Content-disposition", "attachment;filename="
				+ new Timestamp(System.currentTimeMillis()).getTime() + ".csv");
		response.setContentType("application/csv");
		TradeManage manage = serviceSession.getService(TradeManage.class);
		TradeVo query = new TradeVo();
		query.parse(request);//设置界面传来的参数
		PagingResult<TradeVo> list = manage.search(query, new Paging() {
			@Override
			public int getSize() {
				return 9999999;
			}
			@Override
			public int getCurrentPage() {
				return IntegerParser.parse(request.getParameter(PAGING_CURRENT));
			}
		});
		manage.exportTrade(list!=null?list.getItems():null, response.getOutputStream()); //导出数据
	}
	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}
}
