package com.dimeng.p2p.console.servlets.finance.xxczgl;

import java.sql.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.S71.enums.T7150_F05;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.p2p.modules.account.console.service.OfflineChargeManage;
import com.dimeng.p2p.modules.account.console.service.entity.OfflineChargeRecord;
import com.dimeng.p2p.modules.account.console.service.query.OfflineChargeQuery;
import com.dimeng.util.parser.IntegerParser;
import com.dimeng.util.parser.SQLDateParser;

@Right(id = "P2P_C_FINANCE_XXCZGLLIST", isMenu = true, name = "线下充值管理")
public class XxczglList extends AbstractFinanceServlet {
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
		OfflineChargeManage chargeManage = serviceSession
				.getService(OfflineChargeManage.class);
		PagingResult<OfflineChargeRecord> result = chargeManage.search(
				new OfflineChargeQuery() {

					@Override
					public T7150_F05 getStatus() {
						return T7150_F05.parse(request.getParameter("status"));
					}

					@Override
					public Date getCreateStartDate() {
						return SQLDateParser.parse(request
								.getParameter("startTime"));
					}

					@Override
					public Date getCreateEndDate() {
						return SQLDateParser.parse(request
								.getParameter("endTime"));
					}

					@Override
					public String getAccount() {
						return request.getParameter("account");
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

		request.setAttribute("result", result);
		forwardView(request, response, getClass());
	}
}
