package com.dimeng.p2p.console.servlets.finance.fksh;

import java.sql.Timestamp;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.common.ExpemonintBean;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.p2p.modules.bid.console.service.FkshManage;
import com.dimeng.p2p.modules.bid.console.service.query.FkshQuery;
import com.dimeng.util.parser.IntegerParser;
import com.dimeng.util.parser.TimestampParser;

@Right(id = "P2P_C_FINANCE_EXPEMOINTEXPORT", name = "体验利息导出")
public class ExpemointExport extends AbstractFinanceServlet {

	private static final long serialVersionUID = 1L;
	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		response.setHeader("Content-disposition", "attachment;filename="
				+ new Timestamp(System.currentTimeMillis()).getTime() + ".csv");
		response.setContentType("application/csv");
		
		FkshManage fkshManage = serviceSession.getService(FkshManage.class);
		ExpemonintBean[] list = fkshManage.seproemonInt(new FkshQuery() {
			@Override
			public Timestamp getStartExpireDatetime() {
				return TimestampParser.parse(request.getParameter("startExpireDatetime"));
			}

			@Override
			public Timestamp getEndExpireDatetime() {
				return TimestampParser.parse(request
						.getParameter("endExpireDatetime"));
			}

			@Override
			public String getAccount() {
				return request.getParameter("account");
			}

			@Override
			public int getType() {
				return IntegerParser.parse(request.getParameter("type"));
			}

			@Override
			public String getZqId() {
				return request.getParameter("zqId");
			}});
		fkshManage.exporExpoinbes(list, response.getOutputStream(), "GBK");//导出数据
	}
	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}
}
