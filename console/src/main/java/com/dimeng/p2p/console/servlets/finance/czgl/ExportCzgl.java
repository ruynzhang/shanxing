package com.dimeng.p2p.console.servlets.finance.czgl;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.S61.enums.T6110_F06;
import com.dimeng.p2p.S61.enums.T6131_F07;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.p2p.modules.account.console.service.UserRechargeManage;
import com.dimeng.p2p.modules.account.console.service.entity.UserRecharge;
import com.dimeng.p2p.modules.account.console.service.query.CzglRecordQuery;
import com.dimeng.util.parser.EnumParser;
import com.dimeng.util.parser.IntegerParser;
import com.dimeng.util.parser.TimestampParser;

@Right(id = "P2P_C_FINANCE_EXPORTCZGL", name = "导出充值管理")
public class ExportCzgl extends AbstractFinanceServlet {
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
		UserRechargeManage userRechargeManage = serviceSession
				.getService(UserRechargeManage.class);
		response.setHeader("Content-disposition", "attachment;filename="
				+ new Timestamp(System.currentTimeMillis()).getTime() + ".csv");
		response.setContentType("application/csv");
		PagingResult<UserRecharge> result = userRechargeManage.serarch(
				new CzglRecordQuery() {
					@Override
					public String getPayType() {
						return request.getParameter("payType");
					}

					@Override
					public T6131_F07 getStatus() {
						return EnumParser.parse(T6131_F07.class,
								request.getParameter("status"));
					}

					@Override
					public Timestamp getStartRechargeTime() {
						return TimestampParser.parse(request
								.getParameter("startRechargeTime"));
					}

					@Override
					public String getSerialNumber() {
						return request.getParameter("serialNumber");
					}

					@Override
					public String getLoginName() {
						return request.getParameter("loginName");
					}

					@Override
					public Timestamp getEndRechargeTime() {
						return TimestampParser.parse(request
								.getParameter("endRechargeTime"));
					}

					@Override
					public T6110_F06 getUserType() {
						return EnumParser.parse(T6110_F06.class,
								request.getParameter("userType"));
					}
				}, new Paging() {
					@Override
					public int getSize() {
						return Integer.MAX_VALUE;
					}

					@Override
					public int getCurrentPage() {
						return IntegerParser.parse(request
								.getParameter(PAGING_CURRENT));
					}
				});
		userRechargeManage.export(result.getItems(),
				response.getOutputStream(), "");
	}
}
