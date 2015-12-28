package com.dimeng.p2p.console.servlets.statistics;

import java.sql.Timestamp;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.modules.account.console.service.AccountTJManage;
import com.dimeng.p2p.modules.account.console.service.entity.AccountTJVO;

@Right(id = "P2P_C_STATISTICS_ACCOUNTTJLISTEXPORT", name = "会员统计数据导出")
public class AccountTJListExport extends AbstractStatisticsServlet {
	private static final long serialVersionUID = 1L;
	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		response.setHeader("Content-disposition", "attachment;filename="
				+ new Timestamp(System.currentTimeMillis()).getTime() + ".csv");
		response.setContentType("application/csv");
		AccountTJManage manage = serviceSession.getService(AccountTJManage.class);
		AccountTJVO query = new AccountTJVO();
		query.parse(request);
		List<AccountTJVO> list=manage.seach(query);
		manage.exportAccountTJList(list, response.getOutputStream());
	}
	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}
}
