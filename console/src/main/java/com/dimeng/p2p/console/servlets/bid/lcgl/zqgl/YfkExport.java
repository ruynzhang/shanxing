package com.dimeng.p2p.console.servlets.bid.lcgl.zqgl;

import java.sql.Timestamp;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.modules.financial.console.service.CreditorManage;
import com.dimeng.p2p.modules.financial.console.service.entity.Creditor;
import com.dimeng.p2p.modules.financial.console.service.query.CreditorQuery;
import com.dimeng.util.parser.DateParser;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_BUSI_YFKEXPORT",  name = "回收中的债权导出")
public class YfkExport extends AbstractBidServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}
	
	@Override
	protected void processPost(final HttpServletRequest request,final HttpServletResponse response,
			final ServiceSession serviceSession) throws Throwable {
		CreditorManage creditorManage = serviceSession.getService(CreditorManage.class);
		response.setHeader("Content-disposition", "attachment;filename="
				+ new Timestamp(System.currentTimeMillis()).getTime() + ".csv");
		response.setContentType("application/csv");
		PagingResult<Creditor> creditors = creditorManage.creditorYfkSearch(new CreditorQuery() {
			
			@Override
			public String getUserName() {
				return request.getParameter("userName");
			}
			
			@Override
			public String getCreditorId() {
				return request.getParameter("creditorId");
			}
			
			@Override
			public Timestamp getCreateTimeStart() {
				Date date = DateParser.parse(request
						.getParameter("createTimeStart"));
				return date == null ? null : new Timestamp(date.getTime());
			}
			
			@Override
			public Timestamp getCreateTimeEnd() {
				Date date = DateParser.parse(request
						.getParameter("createTimeEnd"));
				return date == null ? null : new Timestamp(date.getTime());
			}
		}, new Paging() {
			
			@Override
			public int getSize() {
				return Integer.MAX_VALUE;
			}

			@Override
			public int getCurrentPage() {
				return IntegerParser.parse(request.getParameter(PAGING_CURRENT));
			}
		});
		creditorManage.export(creditors.getItems(), response.getOutputStream(), "");
	}

}
