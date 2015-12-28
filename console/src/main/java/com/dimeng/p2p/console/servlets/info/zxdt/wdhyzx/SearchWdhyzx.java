package com.dimeng.p2p.console.servlets.info.zxdt.wdhyzx;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.S50.enums.T5011_F02;
import com.dimeng.p2p.common.enums.ArticlePublishStatus;
import com.dimeng.p2p.console.servlets.info.AbstractInformationServlet;
import com.dimeng.p2p.modules.base.console.service.ArticleManage;
import com.dimeng.p2p.modules.base.console.service.entity.ArticleRecord;
import com.dimeng.p2p.modules.base.console.service.query.ArticleQuery;
import com.dimeng.util.parser.EnumParser;
import com.dimeng.util.parser.IntegerParser;
import com.dimeng.util.parser.TimestampParser;

@Right(id = "P2P_C_INFO_WDHYZX_SEARCH", isMenu = true, name = "网贷行业资讯")
public class SearchWdhyzx extends AbstractInformationServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		ArticleManage manage = serviceSession.getService(ArticleManage.class);
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
		ArticleQuery query = new ArticleQuery() {

			@Override
			public T5011_F02 getType() {
				return T5011_F02.WDHYZX;
			}

			@Override
			public String getTitle() {
				return request.getParameter("title");
			}

			@Override
			public String getSummary() {
				return request.getParameter("summary");
			}

			@Override
			public String getSource() {
				return request.getParameter("source");
			}

			@Override
			public String getPublisherName() {
				return request.getParameter("publisherName");
			}

			@Override
			public Timestamp getPublishTimeStart() {
				return TimestampParser.parse(request
						.getParameter("publishTimeStart"));
			}

			@Override
			public Timestamp getPublishTimeEnd() {
				return TimestampParser.parse(request
						.getParameter("publishTimeEnd"));
			}

			@Override
			public ArticlePublishStatus getPublishStatus() {
				return EnumParser.parse(ArticlePublishStatus.class,
						request.getParameter("status"));
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
		PagingResult<ArticleRecord> result = manage.search(query, paging);
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
