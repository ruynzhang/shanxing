package com.dimeng.p2p.console.servlets.bid.grjkyx;

import java.sql.Timestamp;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.S62.enums.T6282_F11;
import com.dimeng.p2p.console.servlets.system.AbstractSystemServlet;
import com.dimeng.p2p.modules.bid.console.service.BidWillManage;
import com.dimeng.p2p.modules.bid.console.service.entity.Grjkyx;
import com.dimeng.p2p.modules.bid.console.service.query.GrIntentionQuery;
import com.dimeng.util.parser.DateParser;
import com.dimeng.util.parser.EnumParser;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_BUSI_DCGRJKYX", name = "导出个人借款意向")
public class DcGrjkyx extends AbstractSystemServlet {
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
		response.setHeader("Content-disposition", "attachment;filename=" + new Timestamp(System.currentTimeMillis()).getTime() + ".csv");
		response.setContentType("application/csv");
		BidWillManage bidWillManage = serviceSession.getService(BidWillManage.class);
		
		PagingResult<Grjkyx> loanIntentions = bidWillManage.searchPersonal(
				new GrIntentionQuery() {

					@Override
					public String getUserName() {
						return request.getParameter("userName");
					}

					@Override
					public int getType() {
						return IntegerParser.parse(request.getParameter("type"));
					}

					@Override
					public String getSheng() {
						return request.getParameter("sheng");
					}

					@Override
					public String getShi() {
						return request.getParameter("shi");
					}

					@Override
					public String getXian() {
						return request.getParameter("xian");
					}

					@Override
					public T6282_F11 getStatus() {
						return EnumParser.parse(T6282_F11.class,
								request.getParameter("loanIntentionState"));
					}

					@Override
					public Timestamp getCreateTimeStart() {
						Date date = DateParser.parse(request
								.getParameter("createTimeStart"));
						return date == null ? null : new Timestamp(date
								.getTime());
					}

					@Override
					public Timestamp getCreateTimeEnd() {
						Date date = DateParser.parse(request
								.getParameter("createTimeEnd"));
						return date == null ? null : new Timestamp(date
								.getTime());
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
		
		bidWillManage.export(loanIntentions.getItems(),
		response.getOutputStream(), "");
	}

}
