package com.dimeng.p2p.console.servlets.info.yjbg;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.common.enums.PerformanceReportPublishStatus;
import com.dimeng.p2p.modules.base.console.service.PerformanceReportManage;
import com.dimeng.p2p.modules.base.console.service.entity.PerformanceReportRecord;
import com.dimeng.p2p.modules.base.console.service.query.PerformanceReportQuery;
import com.dimeng.util.parser.EnumParser;
import com.dimeng.util.parser.IntegerParser;
import com.dimeng.util.parser.TimestampParser;

@Right(id = "P2P_C_INFO_YJBG_SEARCH", isMenu = true, name = "业绩报告")
public class SearchYjbg extends AbstractYjbgServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(final HttpServletRequest request,
			final HttpServletResponse response,
			final ServiceSession serviceSession) throws Throwable {
		PerformanceReportManage manage = serviceSession
				.getService(PerformanceReportManage.class);
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

		PerformanceReportQuery query = new PerformanceReportQuery() {

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
			public String getTitle() {
				return request.getParameter("title");
			}

			@Override
			public String getPublisherName() {
				return request.getParameter("publisherName");
			}

			@Override
			public PerformanceReportPublishStatus getPublishStatus() {
				return EnumParser.parse(PerformanceReportPublishStatus.class,
						request.getParameter("publishStatus"));
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
		PagingResult<PerformanceReportRecord> result = manage.search(query,
				paging);
		request.setAttribute("result", result);
		forwardView(request, response, getClass());
	}

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}

}
