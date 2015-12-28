package com.dimeng.p2p.console.servlets.system.operlog;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.console.servlets.system.AbstractSystemServlet;
import com.dimeng.p2p.modules.systematic.console.service.SysLoginLogManage;
import com.dimeng.p2p.modules.systematic.console.service.entity.OperLog;
import com.dimeng.p2p.modules.systematic.console.service.query.OperLogQuery;
import com.dimeng.util.parser.IntegerParser;
import com.dimeng.util.parser.TimestampParser;

@Right(id = "P2P_C_SYS_OPERLOGLIST", isMenu = true, name = "后台操作日志")
public class OperLogList extends AbstractSystemServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		SysLoginLogManage sysLoginLogManage = serviceSession
				.getService(SysLoginLogManage.class);
		OperLogQuery query = new OperLogQuery() {

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

			@Override
			public String getName() {
				return request.getParameter("name");
			}
		};
		Paging paging = new Paging() {
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
		PagingResult<OperLog> result = sysLoginLogManage.search(query, paging);
		request.setAttribute("result", result);
		forwardView(request, response, getClass());
	}

	@Override
	protected void processGet(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}
}
