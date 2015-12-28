package com.dimeng.p2p.console.servlets.finance.ptzjgl;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.common.enums.PlatformFundType;
import com.dimeng.p2p.modules.finance.console.service.PtzjManage;
import com.dimeng.p2p.modules.finance.console.service.entity.Ptzjgl;
import com.dimeng.p2p.modules.finance.console.service.entity.PtzjglRecord;
import com.dimeng.p2p.modules.finance.console.service.query.PtzjglRecordQuery;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.util.parser.EnumParser;
import com.dimeng.util.parser.IntegerParser;
import com.dimeng.util.parser.TimestampParser;

@Right(id = "P2P_C_FINANCE_PTZJGLLIST", isMenu = true, name = "平台资金管理")
public class PtzjglList extends AbstractFinanceServlet {
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
		PtzjManage ptzjManage = serviceSession.getService(PtzjManage.class);
		Ptzjgl ptzjgl = ptzjManage.getPlatFormFundInfo();
		PagingResult<PtzjglRecord> result = ptzjManage.search(
				new PtzjglRecordQuery() {

					@Override
					public PlatformFundType getType() {
						return EnumParser.parse(PlatformFundType.class,
								request.getParameter("type"));
					}

					@Override
					public Timestamp getStartPayTime() {
						return TimestampParser.parse(request
								.getParameter("startPayTime"));
					}

					@Override
					public Timestamp getEndPayTime() {
						return TimestampParser.parse(request
								.getParameter("endPayTime"));
					}

					@Override
					public String getUserName() {
						return request.getParameter("userName");
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
		getController().prompt(request, response, PromptLevel.WARRING,
				request.getParameter("message"));
		request.setAttribute("result", result);
		request.setAttribute("ptzjgl", ptzjgl);
		forwardView(request, response, getClass());
	}
}
