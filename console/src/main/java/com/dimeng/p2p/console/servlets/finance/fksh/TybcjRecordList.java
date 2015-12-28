package com.dimeng.p2p.console.servlets.finance.fksh;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.common.Expemonyinfo;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.p2p.modules.bid.console.service.FkshManage;
import com.dimeng.p2p.modules.bid.console.service.query.CjRecordQuery;
import com.dimeng.util.parser.IntegerParser;
import com.dimeng.util.parser.TimestampParser;

@Right(id = "P2P_C_FINANCE_TYBCJRECORDLIST", name = "体验标放款成交记录")
public class TybcjRecordList extends AbstractFinanceServlet {
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
		FkshManage fkshManage = serviceSession.getService(FkshManage.class);
		  //借款总金额
	//	BigDecimal totalAmount = fkshManage.totalAmount();
		 //放款总金额
		//BigDecimal totalFkAmount = fkshManage.totalFkAmount();
		PagingResult<Expemonyinfo> result = fkshManage.searchcjcrecord(new CjRecordQuery() {

			@Override
			public int getType() {
				return IntegerParser.parse(request.getParameter("type"));
			}

			@Override
			public Timestamp getStartTime() {
				return TimestampParser.parse(request.getParameter("startTime"));
			}

			@Override
			public String getUserName() {
				return request.getParameter("loanName");
			}

			@Override
			public Timestamp getEndTime() {
				return TimestampParser.parse(request.getParameter("endTime"));
			}
		  },  new Paging() {
			@Override
			public int getSize() {
				return 10;
			}
			
			@Override
			public int getCurrentPage() {
				return IntegerParser.parse(request.getParameter(PAGING_CURRENT));
			}
		});
		request.setAttribute("result", result);
		forwardView(request, response, getClass());
	}
}
