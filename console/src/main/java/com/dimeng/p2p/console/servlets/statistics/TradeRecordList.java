package com.dimeng.p2p.console.servlets.statistics;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.modules.statistics.console.service.TradeRecordManage;
import com.dimeng.p2p.modules.statistics.console.service.entity.TradeRecordVO;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_STATISTICS_TRADERECORDLIST", isMenu = true,name = "线下交易记录")
public class TradeRecordList extends AbstractStatisticsServlet {
	private static final long serialVersionUID = 1L;
	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}
	
	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		TradeRecordManage manage = serviceSession.getService(TradeRecordManage.class);
		TradeRecordVO query = new TradeRecordVO();
		query.parse(request);//设置查询对象
		//内部员工分页对象
		PagingResult<TradeRecordVO> list = manage.search(query, new Paging() {
			@Override
			public int getSize() {
				return 10;
			}
			@Override
			public int getCurrentPage() {
				return IntegerParser.parse(request.getParameter(PAGING_CURRENT));
			}
		});
		request.setAttribute("list", list);
		forwardView(request, response, getClass());
	}

}
