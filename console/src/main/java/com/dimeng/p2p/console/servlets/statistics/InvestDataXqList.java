package com.dimeng.p2p.console.servlets.statistics;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.modules.account.console.service.InvestDataManage;
import com.dimeng.p2p.modules.account.console.service.entity.InvestDataXqVO;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_STATISTICS_INVESTDATAXQLIST", isMenu = true,name = "统计投资数据明细管理")
public class InvestDataXqList  extends AbstractStatisticsServlet {

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		InvestDataManage manage = serviceSession.getService(InvestDataManage.class);
		InvestDataXqVO dataXqVO=new InvestDataXqVO();
		dataXqVO.parse(request);
		PagingResult<InvestDataXqVO> list=manage.InvestDataXqPaging(dataXqVO, new Paging() {
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
	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}
}
