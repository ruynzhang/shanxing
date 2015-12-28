package com.dimeng.p2p.console.servlets.statistics;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.modules.account.console.service.InvestDataManage;
import com.dimeng.p2p.modules.account.console.service.entity.InvestDataVO;

@Right(id = "P2P_C_STATISTICS_INVESTDATALIST", isMenu = true,name = "统计投资数据管理")
public class InvestDataList  extends AbstractStatisticsServlet {

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		InvestDataManage manage = serviceSession.getService(InvestDataManage.class);
		InvestDataVO query = new InvestDataVO();
		query.parse(request);
		List<InvestDataVO> list=manage.InvestDataList(query);
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
