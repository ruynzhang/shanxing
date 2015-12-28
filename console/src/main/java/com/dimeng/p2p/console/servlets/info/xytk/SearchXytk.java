package com.dimeng.p2p.console.servlets.info.xytk;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.common.enums.TermType;
import com.dimeng.p2p.console.servlets.info.gggl.AbstractAdvertiseServlet;
import com.dimeng.p2p.modules.base.console.service.TermManage;
import com.dimeng.p2p.modules.base.console.service.entity.TermRecord;
import com.dimeng.p2p.modules.base.console.service.query.TermQuery;
import com.dimeng.util.parser.EnumParser;
import com.dimeng.util.parser.IntegerParser;
import com.dimeng.util.parser.TimestampParser;

@Right(id = "P2P_C_INFO_XYTK_SEARCH", isMenu = true, name = "协议条款")
public class SearchXytk extends AbstractAdvertiseServlet {

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
		TermManage manage = serviceSession.getService(TermManage.class);

		TermQuery query = new TermQuery() {

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
			public TermType getType() {
				return EnumParser.parse(TermType.class,
						request.getParameter("type"));
			}

			@Override
			public String getPublisherName() {
				return request.getParameter("publisherName");
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

		PagingResult<TermRecord> result = manage.search(query, paging);
		request.setAttribute("result", result);
		forwardView(request, response, getClass());
	}

}