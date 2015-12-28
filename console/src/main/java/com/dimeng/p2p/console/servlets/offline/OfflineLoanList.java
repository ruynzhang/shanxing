package com.dimeng.p2p.console.servlets.offline;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.S62.entities.T6211;
import com.dimeng.p2p.S62.enums.T6230_F20;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.modules.bid.console.service.OfflineManage;
import com.dimeng.p2p.modules.bid.console.service.entity.Bid;
import com.dimeng.p2p.modules.bid.console.service.query.LoanQuery;
import com.dimeng.util.parser.EnumParser;
import com.dimeng.util.parser.IntegerParser;
import com.dimeng.util.parser.TimestampParser;

@Right(id = "P2P_C_OFFLINE_LOANLIST", name = "标的管理", isMenu = true)
public class OfflineLoanList extends AbstractBidServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -268955794485557959L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		OfflineManage OfflineManage = serviceSession.getService(OfflineManage.class);
		T6211[] t6211s = OfflineManage.getBidType();
		PagingResult<Bid> result = OfflineManage.search(new LoanQuery() {

			@Override
			public int getType() {
				return IntegerParser.parse(request.getParameter("type"));
			}

			@Override
			public T6230_F20 getStatus() {
				return EnumParser.parse(T6230_F20.class,
						request.getParameter("status"));
			}

			@Override
			public String getName() {
				return request.getParameter("name");
			}

			@Override
			public String getLoanTitle() {
				return request.getParameter("title");
			}

			@Override
			public Timestamp getCreateTimeStart() {
				return TimestampParser.parse(request
						.getParameter("createTimeStart"));
			}

			@Override
			public Timestamp getCreateTimeEnd() {
				return TimestampParser.parse(request
						.getParameter("createTimeEnd"));
			}
		}, new Paging() {

			@Override
			public int getSize() {
				return 10;
			}

			@Override
			public int getCurrentPage() {
				return IntegerParser.parse(request.getParameter(PAGING_CURRENT));
			}
		});
		request.setAttribute("result", result);
		request.setAttribute("t6211s", t6211s);
		forwardView(request, response, getClass());
	}
}
