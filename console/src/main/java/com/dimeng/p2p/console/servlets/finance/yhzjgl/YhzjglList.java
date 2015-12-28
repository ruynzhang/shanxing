package com.dimeng.p2p.console.servlets.finance.yhzjgl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.common.enums.UserType;
import com.dimeng.p2p.modules.finance.console.service.YhzjManage;
import com.dimeng.p2p.modules.finance.console.service.entity.Yhzjgl;
import com.dimeng.p2p.modules.finance.console.service.entity.YhzjglRecord;
import com.dimeng.p2p.modules.finance.console.service.query.YhzjglRecordQuery;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.util.parser.EnumParser;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_FINANCE_YHZJGLLIST", isMenu = true, name = "用户资金管理")
public class YhzjglList extends AbstractFinanceServlet {
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
		YhzjManage yhzjManage = serviceSession.getService(YhzjManage.class);
		Yhzjgl yhzjgl = yhzjManage.getUserFundInfo();
		PagingResult<YhzjglRecord> result = yhzjManage.serarch(
				new YhzjglRecordQuery() {
					@Override
					public UserType getUserType() {
						return EnumParser.parse(UserType.class,
								request.getParameter("userType"));
					}

					@Override
					public String getUserName() {
						return request.getParameter("userName");
					}

					@Override
					public String getLoginName() {
						return request.getParameter("loginName");
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
		request.setAttribute("yhzjgl", yhzjgl);
		request.setAttribute("result", result);
		forwardView(request, response, getClass());

	}

}
