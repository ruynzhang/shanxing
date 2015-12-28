package com.dimeng.p2p.console.servlets.finance.zjgl;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.common.enums.FundAccountType;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.p2p.modules.account.console.service.FundsTjBbManage;
import com.dimeng.p2p.modules.account.console.service.entity.FundsTjBbView;
import com.dimeng.p2p.modules.account.console.service.query.FundsTjBbQuery;
import com.dimeng.util.parser.EnumParser;
import com.dimeng.util.parser.IntegerParser;
import com.dimeng.util.parser.TimestampParser;

@Right(id = "P2P_C_FINANCE_TJBBLIST", isMenu = true, name = "统计报表")
public class TjBbList extends AbstractFinanceServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request, HttpServletResponse response, ServiceSession serviceSession) throws Throwable {
		processPost(request, response, serviceSession);
	}

	@Override
	protected void processPost(final HttpServletRequest request, final HttpServletResponse response, final ServiceSession serviceSession) throws Throwable {
		FundsTjBbManage fundsManage = serviceSession.getService(FundsTjBbManage.class);

		PagingResult<FundsTjBbView> fundsTjBbList = fundsManage.search(new FundsTjBbQuery() {

			@Override
			public Timestamp getStartTime() {
				return TimestampParser.parse(request.getParameter("startTime"));
			}

			@Override
			public Timestamp getEndTime() {
				return TimestampParser.parse(request.getParameter("endTime"));
			}

			@Override
			public FundAccountType getFundAccountType() {
				FundAccountType fundAccountType = EnumParser.parse(FundAccountType.class, request.getParameter("fundAccountType"));
				return fundAccountType;
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
				return IntegerParser.parse(request.getParameter(PAGING_CURRENT));
			}
		});

		request.setAttribute("fundsTjBbList", fundsTjBbList);
		forwardView(request, response, getClass());
	}
}
