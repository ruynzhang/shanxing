package com.dimeng.p2p.console.servlets.statistics;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.modules.account.console.service.AccountTJManage;
import com.dimeng.p2p.modules.account.console.service.entity.AccountTJVO;

@Right(id = "P2P_C_STATISTICS_ACCOUNTTJLIST", isMenu = true,name = "平台会员统计")
public class AccountTJList extends AbstractStatisticsServlet {
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
		AccountTJManage manage = serviceSession.getService(AccountTJManage.class);
		AccountTJVO query = new AccountTJVO();
		query.parse(request);
		AccountTJVO vo=manage.getAccountTJ();
		List<AccountTJVO> list=manage.seach(query);
		request.setAttribute("vo", vo);
		request.setAttribute("list", list);
		forwardView(request, response, getClass());
	}
}
