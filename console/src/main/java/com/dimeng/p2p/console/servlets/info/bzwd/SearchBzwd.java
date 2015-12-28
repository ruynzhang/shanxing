package com.dimeng.p2p.console.servlets.info.bzwd;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.modules.base.console.service.CustomerServiceManage;
import com.dimeng.p2p.modules.base.console.service.entity.CustomerServiceRecord;
import com.dimeng.p2p.modules.base.console.service.query.CustomerServiceQuery;
import com.dimeng.util.parser.IntegerParser;

public class SearchBzwd extends AbstractBzwdServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {

	}

	@Override
	protected void processGet(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		CustomerServiceManage manage = serviceSession
				.getService(CustomerServiceManage.class);
		final Paging paging = new Paging() {

			@Override
			public int getSize() {

				return 10;
			}

			@Override
			public int getCurrentPage() {
				return IntegerParser.parse(request
						.getParameter("paging.current"));
			}
		};

		final String fbz = request.getParameter("fbz");
		PagingResult<CustomerServiceRecord> result = null;
		CustomerServiceQuery query = new CustomerServiceQuery() {

			@Override
			public Timestamp getUpdateTimeStart() {
				return null;
			}

			@Override
			public Timestamp getUpdateTimeEnd() {
				return null;
			}

			@Override
			public String getPublisherName() {
				return fbz;
			}

			@Override
			public String getName() {
				return null;
			}

			@Override
			public Timestamp getCreateTimeStart() {
				return null;
			}

			@Override
			public Timestamp getCreateTimeEnd() {
				return null;
			}
		};
		result = manage.search(query, paging);
		request.setAttribute("result", result);
		forward(request, response,
				getController().getViewURI(request, SearchBzwd.class));

	}

}
