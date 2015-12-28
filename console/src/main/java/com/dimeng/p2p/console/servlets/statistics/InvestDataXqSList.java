package com.dimeng.p2p.console.servlets.statistics;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.modules.account.console.service.InvestDataManage;
import com.dimeng.p2p.modules.account.console.service.entity.InvestDataXqVO;

public class InvestDataXqSList extends AbstractStatisticsServlet {
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
		InvestDataManage manage = serviceSession.getService(InvestDataManage.class);
		InvestDataXqVO query = new InvestDataXqVO();
		query.parse(request);//设置界面传来的参数
		List<InvestDataXqVO> list = manage.InvestDataXqSList(query);
		request.setAttribute("list", list);
		forwardView(request, response, getClass());
	}
}
