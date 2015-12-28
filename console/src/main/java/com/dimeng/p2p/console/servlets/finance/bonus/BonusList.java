package com.dimeng.p2p.console.servlets.finance.bonus;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.p2p.modules.account.console.service.FinanceManage;
import com.dimeng.p2p.modules.account.console.service.entity.SlBonusVO;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_FINANCE_BONUSLIST", isMenu = true, name = "佣金提成")
public class BonusList extends AbstractFinanceServlet {

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
		//内部员工分页对象
		PagingResult<SlBonusVO> list = manage.search(query, new Paging() {
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
		//全部标的号
		List<Integer> bidList=manage.getBid();
		request.setAttribute("bidList", bidList);
		forwardView(request, response, getClass());
	}
}
