package com.dimeng.p2p.console.servlets.finance.bonus;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.p2p.modules.account.console.service.FinanceManage;
import com.dimeng.p2p.modules.account.console.service.entity.SlBonusVO;

@Right(id = "P2P_C_FINANCE_BONUSEXPORT", name = "导出佣金提成")
public class BonusExport extends AbstractFinanceServlet {

	private static final long serialVersionUID = 1L;
	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		response.setHeader("Content-disposition", "attachment;filename="
				+ new Timestamp(System.currentTimeMillis()).getTime() + ".csv");
		response.setContentType("application/csv");
		FinanceManage manage = serviceSession.getService(FinanceManage.class);
		SlBonusVO query = new SlBonusVO();
		query.parse(request);//设置界面传来的参数
		SlBonusVO[] list=manage.SlBonusList(query);
		manage.exporSlBonus(list, response.getOutputStream(), "GBK"); //导出数据
	}
	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}
}
