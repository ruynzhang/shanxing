package com.dimeng.p2p.console.servlets.finance.zjgl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.p2p.modules.account.console.service.FundsXYManage;
import com.dimeng.p2p.modules.account.console.service.entity.FundXYAccountType;
import com.dimeng.p2p.modules.account.console.service.entity.FundsXYView;
import com.dimeng.p2p.modules.account.console.service.query.FundsXYQuery;
import com.dimeng.util.parser.EnumParser;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_FINANCE_XYLLIST", isMenu = true, name = "信用账户管理")
public class XyList extends AbstractFinanceServlet {
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
		FundsXYManage fundsXYManage = serviceSession
				.getService(FundsXYManage.class);

		PagingResult<FundsXYView> fundsXYViewList = fundsXYManage.search(
				new FundsXYQuery() {

					@Override
					public String getLoginName() {
						return request.getParameter("loginName");
					}

					@Override
					public String getUserName() {
						return request.getParameter("userName");
					}

					@Override
					public FundXYAccountType getFundAccountType() {
						FundXYAccountType fundAccountType = EnumParser.parse(
								FundXYAccountType.class,
								request.getParameter("fundAccountType"));
						return fundAccountType;
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
		request.setAttribute("fundsXYViewList", fundsXYViewList);
		forwardView(request, response, getClass());

	}
}
