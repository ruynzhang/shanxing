package com.dimeng.p2p.console.servlets.finance.yhzjgl;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.common.enums.UserType;
import com.dimeng.p2p.modules.finance.console.service.YhzjManage;
import com.dimeng.p2p.modules.finance.console.service.entity.YhzjglRecord;
import com.dimeng.p2p.modules.finance.console.service.query.YhzjglRecordQuery;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.util.parser.EnumParser;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_FINANCE_EXPORTYHZJGL", name = "用户资金管理导出")
public class ExportYhzjgl extends AbstractFinanceServlet {
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
		YhzjManage yhzjManage = serviceSession.getService(YhzjManage.class);
		response.setHeader("Content-disposition", "attachment;filename="
				+ new Timestamp(System.currentTimeMillis()).getTime() + ".csv");
		response.setContentType("application/csv");
		PagingResult<YhzjglRecord> result = yhzjManage.serarch(
				new YhzjglRecordQuery() {

					@Override
					public UserType getUserType() {
						return EnumParser.parse(UserType.class,
								request.getParameter("userType"));
					}

					@Override
					public String getUserName() {
						return request.getParameter("userName");
					}

					@Override
					public String getLoginName() {
						return request.getParameter("loginName");
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
		yhzjManage.export(result.getItems(), response.getOutputStream(), "");
	}
}
