package com.dimeng.p2p.console.servlets.finance.yhzjgl;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.common.enums.TradingType;
import com.dimeng.p2p.modules.finance.console.service.YhjyjlManage;
import com.dimeng.p2p.modules.finance.console.service.entity.Yhjyjl;
import com.dimeng.p2p.modules.finance.console.service.entity.YhjyjlRecord;
import com.dimeng.p2p.modules.finance.console.service.query.YhjyjlRecordQuery;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.util.parser.EnumParser;
import com.dimeng.util.parser.IntegerParser;
import com.dimeng.util.parser.TimestampParser;

@Right(id = "P2P_C_FINANCE_YHJYJLLIST", name = "用户资金管理交易记录")
public class YhjyjlList extends AbstractFinanceServlet {
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
		YhjyjlManage yhjyjlManage = serviceSession
				.getService(YhjyjlManage.class);
		int id = IntegerParser.parse(request.getParameter("id"));
		Yhjyjl yhjyjl = yhjyjlManage.getUserTradeInfo(id);
		PagingResult<YhjyjlRecord> result = yhjyjlManage.search(
				new YhjyjlRecordQuery() {

					@Override
					public TradingType getType() {
						return EnumParser.parse(TradingType.class,
								request.getParameter("type"));
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
		request.setAttribute("yhjyjl", yhjyjl);
		forwardView(request, response, getClass());
	}

}
