package com.dimeng.p2p.console.servlets.bid.grjkyx;

import java.sql.Timestamp;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.S62.entities.T6211;
import com.dimeng.p2p.S62.enums.T6282_F11;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.modules.bid.console.service.BidManage;
import com.dimeng.p2p.modules.bid.console.service.BidWillManage;
import com.dimeng.p2p.modules.bid.console.service.entity.Grjkyx;
import com.dimeng.p2p.modules.bid.console.service.query.GrIntentionQuery;
import com.dimeng.util.parser.DateParser;
import com.dimeng.util.parser.EnumParser;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_BUSI_GRJKYXLIST", isMenu = true, name = "个人借款意向管理")
public class GrjkyxList extends AbstractBidServlet {
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
		BidWillManage bidWillManage = serviceSession.getService(BidWillManage.class);
		BidManage bidManage = serviceSession.getService(BidManage.class);
		T6211[] t6211s = bidManage.getBidType();
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
						return 10;
					}

					@Override
					public int getCurrentPage() {
						return IntegerParser.parse(request
								.getParameter(PAGING_CURRENT));
					}
				});

		request.setAttribute("loanIntentions", loanIntentions);
		request.setAttribute("t6211s", t6211s);

		forwardView(request, response, getClass());
	}

}
