package com.dimeng.p2p.console.servlets.info.yqlj;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.modules.base.console.service.FriendlyLinkManage;
import com.dimeng.p2p.modules.base.console.service.entity.FriendlyLinkRecord;
import com.dimeng.p2p.modules.base.console.service.query.FriendlyLinkQuery;
import com.dimeng.util.parser.IntegerParser;
import com.dimeng.util.parser.TimestampParser;

@Right(id = "P2P_C_INFO_YQLJ_SEARCH", isMenu = true, name = "友情链接")
public class SearchYqlj extends AbstractYqljServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processGet(request, response, serviceSession);
	}

	@Override
	protected void processGet(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {

		FriendlyLinkManage manage = serviceSession
				.getService(FriendlyLinkManage.class);
		final Paging paging = new Paging() {

			@Override
			public int getSize() {

				return 10;
			}

			@Override
			public int getCurrentPage() {
				return IntegerParser
						.parse(request.getParameter(PAGING_CURRENT));
			}
		};

		FriendlyLinkQuery query = new FriendlyLinkQuery() {

			@Override
			public Timestamp getUpdateTimeStart() {
				return TimestampParser.parse(request
						.getParameter("updateTimeStart"));
			}

			@Override
			public Timestamp getUpdateTimeEnd() {
				return TimestampParser.parse(request
						.getParameter("updateTimeEnd"));
			}

			@Override
			public String getPublisherName() {
				return request.getParameter("publisherName");
			}

			@Override
			public String getName() {
				return request.getParameter("name");
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
		};
		PagingResult<FriendlyLinkRecord> result = manage.search(query, paging);
		request.setAttribute("result", result);
		forwardView(request, response, getClass());

	}

}
