package com.dimeng.p2p.console.servlets.finance.jgbyj;

import java.io.IOException;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.common.enums.RestoreStatus;
import com.dimeng.p2p.modules.finance.console.service.DfsdzqManage;
import com.dimeng.p2p.modules.finance.console.service.entity.Dfsdzq;
import com.dimeng.p2p.modules.finance.console.service.entity.DfsdzqRecord;
import com.dimeng.p2p.modules.finance.console.service.query.DfsdzqRecordQuery;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.util.parser.EnumParser;
import com.dimeng.util.parser.IntegerParser;
import com.dimeng.util.parser.TimestampParser;

@Right(id = "P2P_C_FINANCE_JGDFSDZQLIST", name = "机构垫付所得债权")
public class JgDfsdzqList extends AbstractFinanceServlet {
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
		DfsdzqManage dfsdzqManage = serviceSession
				.getService(DfsdzqManage.class);
		final int id = IntegerParser.parse(request.getParameter("id"));
		Dfsdzq dfsdzq = dfsdzqManage.getPlatformPaymentInfo(id);
		PagingResult<DfsdzqRecord> result = dfsdzqManage.search(id,
				new DfsdzqRecordQuery() {

					@Override
					public RestoreStatus getStatus() {
						return EnumParser.parse(RestoreStatus.class,
								request.getParameter("status"));
					}

					@Override
					public Timestamp getStartPaymentTime() {
						return TimestampParser.parse(request
								.getParameter("startPaymentTime"));
					}

					@Override
					public String getLoginName() {
						return request.getParameter("loginName");
					}

					@Override
					public Timestamp getEndPaymentTime() {
						return TimestampParser.parse(request
								.getParameter("endPaymentTime"));
					}

					@Override
					public int getZqId() {
						return IntegerParser.parse(request.getParameter("zqId"));
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
		request.setAttribute("dfsdzq", dfsdzq);
		request.setAttribute("result", result);
		forwardView(request, response, getClass());
	}

	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		super.onThrowable(request, response, throwable);
	}
}
