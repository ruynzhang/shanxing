package com.dimeng.p2p.console.servlets.system.constant;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.console.servlets.system.AbstractSystemServlet;
import com.dimeng.p2p.modules.systematic.console.service.ConstantManage;
import com.dimeng.p2p.modules.systematic.console.service.entity.Constant;
import com.dimeng.p2p.modules.systematic.console.service.query.ConstantLogQuery;
import com.dimeng.util.parser.IntegerParser;
import com.dimeng.util.parser.TimestampParser;

@Right(id = "P2P_C_SYS_CONSTANTLOG", isMenu = true, name = "平台常量修改日志")
public class ConstantLogList extends AbstractSystemServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		ConstantManage constantManage = serviceSession
				.getService(ConstantManage.class);
		PagingResult<Constant> result = constantManage.search(
				new ConstantLogQuery() {

					@Override
					public Timestamp getTimeStart() {
						return TimestampParser.parse(request
								.getParameter("timeStart"));
					}

					@Override
					public Timestamp getTimeEnd() {
						return TimestampParser.parse(request
								.getParameter("timeEnd"));
					}

					@Override
					public String getName() {
						return request.getParameter("name");
					}

					@Override
					public String getKey() {
						return request.getParameter("key");
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

		request.setAttribute("result", result);
		forwardView(request, response, ConstantLogList.class);
	}
}
