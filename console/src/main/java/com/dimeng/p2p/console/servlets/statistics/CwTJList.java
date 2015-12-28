package com.dimeng.p2p.console.servlets.statistics;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.modules.account.console.service.CwTJManage;
import com.dimeng.p2p.modules.account.console.service.entity.CwTJVO;

@Right(id = "P2P_C_STATISTICS_CWTJLIST", isMenu = true,name = "平台财务统计")
public class CwTJList extends AbstractStatisticsServlet {
	private static final long serialVersionUID = 1L;
	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}
	
	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		CwTJManage manage = serviceSession.getService(CwTJManage.class);
		CwTJVO query = new CwTJVO();
		query.parse(request);//设置查询对象
		CwTJVO vo=manage.getCwTJVO();
		//查询平台财务数据
		List<CwTJVO> list=manage.seach(query);
		request.setAttribute("vo", vo);
		request.setAttribute("list", list);
		forwardView(request, response, getClass());
	}
}
