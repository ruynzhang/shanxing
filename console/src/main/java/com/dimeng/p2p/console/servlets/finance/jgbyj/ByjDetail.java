package com.dimeng.p2p.console.servlets.finance.jgbyj;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.common.enums.TradeType;
import com.dimeng.p2p.modules.finance.console.service.JgbyjglManage;
import com.dimeng.p2p.modules.finance.console.service.entity.JgfxbyjDetail;
import com.dimeng.p2p.modules.finance.console.service.entity.JgfxbyjRecord;
import com.dimeng.p2p.modules.finance.console.service.query.JgfxbyjglDetailQuery;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.util.parser.EnumParser;
import com.dimeng.util.parser.IntegerParser;
import com.dimeng.util.parser.TimestampParser;

@Right(id = "P2P_C_FINANCE_BYJDETAIL", name = "机构风险备用金明细")
public class ByjDetail extends AbstractFinanceServlet {
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
		JgbyjglManage jgbyjglManage = serviceSession
				.getService(JgbyjglManage.class);
		int id = IntegerParser.parse(request.getParameter("id"));
		JgfxbyjRecord jgfxbyjRecord = jgbyjglManage.getJgfxbyjRecord(id);
		PagingResult<JgfxbyjDetail> result = jgbyjglManage.serarchDetail(
				new JgfxbyjglDetailQuery() {

					@Override
					public TradeType getType() {
						return EnumParser.parse(TradeType.class,
								request.getParameter("type"));
					}

					@Override
					public Timestamp getStartDateTime() {
						return TimestampParser.parse(request
								.getParameter("startDateTime"));
					}

					@Override
					public Timestamp getEndDatetime() {
						return TimestampParser.parse(request
								.getParameter("endDateTime"));
					}

					@Override
					public int getId() {
						return IntegerParser.parse(request.getParameter("id"));
					}

					@Override
					public String getUserName() {
						return request.getParameter("userName");
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
		getController().prompt(request, response, PromptLevel.WARRING,
				request.getParameter("message"));
		request.setAttribute("id", id);
		request.setAttribute("jgfxbyjRecord", jgfxbyjRecord);
		request.setAttribute("result", result);
		forwardView(request, response, getClass());
	}
}
