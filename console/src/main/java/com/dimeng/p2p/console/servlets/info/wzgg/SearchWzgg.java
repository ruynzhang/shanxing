package com.dimeng.p2p.console.servlets.info.wzgg;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.common.enums.NoticePublishStatus;
import com.dimeng.p2p.common.enums.NoticeType;
import com.dimeng.p2p.modules.base.console.service.NoticeManage;
import com.dimeng.p2p.modules.base.console.service.entity.NoticeRecord;
import com.dimeng.p2p.modules.base.console.service.query.NoticeQuery;
import com.dimeng.util.parser.EnumParser;
import com.dimeng.util.parser.IntegerParser;
import com.dimeng.util.parser.TimestampParser;

@Right(id = "P2P_C_INFO_WZGG_SEARCH", isMenu = true, name = "网站公告")
public class SearchWzgg extends AbstractWzggServlet {

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

		NoticeManage manage = serviceSession.getService(NoticeManage.class);
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
		NoticeQuery query = new NoticeQuery() {

			@Override
			public Timestamp getCreateTimeEnd() {
				return TimestampParser.parse(request
						.getParameter("createTimeEnd"));
			}

			@Override
			public Timestamp getCreateTimeStart() {
				return TimestampParser.parse(request
						.getParameter("createTimeStart"));
			}

			@Override
			public NoticePublishStatus getPublishStatus() {
				return EnumParser.parse(NoticePublishStatus.class,
						request.getParameter("publishStatus"));
			}

			@Override
			public String getPublisherName() {
				return request.getParameter("publisherName");
			}

			@Override
			public String getTitle() {
				return request.getParameter("title");
			}

			@Override
			public NoticeType getType() {
				return EnumParser.parse(NoticeType.class,
						request.getParameter("type"));
			}

			@Override
			public Timestamp getUpdateTimeEnd() {
				return TimestampParser.parse(request
						.getParameter("updateTimeEnd"));
			}

			@Override
			public Timestamp getUpdateTimeStart() {
				return TimestampParser.parse(request
						.getParameter("updateTimeStart"));
			}

		};
		PagingResult<NoticeRecord> result = manage.search(query, paging);
		request.setAttribute("result", result);
		forwardView(request, response, getClass());

	}

}
