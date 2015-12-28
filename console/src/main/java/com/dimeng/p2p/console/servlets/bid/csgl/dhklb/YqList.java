package com.dimeng.p2p.console.servlets.bid.csgl.dhklb;

import java.sql.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.common.enums.IsHovestatus;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.modules.bid.console.service.CollectionManage;
import com.dimeng.p2p.modules.bid.console.service.entity.Less30;
import com.dimeng.p2p.modules.bid.console.service.entity.StayRefundGather;
import com.dimeng.p2p.modules.bid.console.service.query.Less30Query;
import com.dimeng.util.parser.EnumParser;
import com.dimeng.util.parser.IntegerParser;
import com.dimeng.util.parser.SQLDateParser;

@Right(id = "P2P_C_BUSI_CS_DHKLIST", isMenu = true, name = "待还款列表")
public class YqList extends AbstractBidServlet {
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
		CollectionManage collectionManage = serviceSession
				.getService(CollectionManage.class);
		StayRefundGather stayRefundGather = collectionManage
				.findStayRefundGather();
		PagingResult<Less30> less30s = collectionManage.less30Search(
				new Less30Query() {

					@Override
					public String getUserName() {
						return request.getParameter("userName");
					}

					@Override
					public IsHovestatus getState() {
						return EnumParser.parse(IsHovestatus.class,
								request.getParameter("state"));
					}

					@Override
					public String getLoanRecordTitle() {
						return request.getParameter("loanRecordTitle");
					}

					@Override
					public Date getCreateTimeStart() {
						return SQLDateParser.parse(request
								.getParameter("createTimeStart"));
					}

					@Override
					public Date getCreateTimeEnd() {
						return SQLDateParser.parse(request
								.getParameter("createTimeEnd"));
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

		request.setAttribute("stayRefundGather", stayRefundGather);
		request.setAttribute("less30s", less30s);

		forwardView(request, response, getClass());
	}

}
