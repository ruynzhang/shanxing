package com.dimeng.p2p.console.servlets.finance.bonus;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.p2p.modules.account.console.service.FinanceManage;
import com.dimeng.p2p.modules.account.console.service.entity.SlBonusVO;

@Right(id = "P2P_C_FINANCE_BONUSSONLIST", name = "查看客户佣金提成")
public class BonusSonList extends AbstractFinanceServlet {

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
		FinanceManage manage = serviceSession.getService(FinanceManage.class);
		SlBonusVO query = new SlBonusVO();
		query.parse(request);//设置界面传来的参数
		List<SlBonusVO> list = manage.BonusSonList(query);
		request.setAttribute("list", list);
		forwardView(request, response, getClass());
	}
}