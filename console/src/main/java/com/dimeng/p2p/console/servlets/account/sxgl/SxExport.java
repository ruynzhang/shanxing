package com.dimeng.p2p.console.servlets.account.sxgl;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.account.AbstractAccountServlet;
import com.dimeng.p2p.modules.account.console.service.AccountManage;
import com.dimeng.p2p.modules.account.console.service.entity.ScreeningVO;

@Right(id = "P2P_C_ACCOUNT_SXEXPORT", name = "导出筛选数据")
public class SxExport extends AbstractAccountServlet {

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
		response.setHeader("Content-disposition", "attachment;filename="
				+ new Timestamp(System.currentTimeMillis()).getTime() + ".csv");
		response.setContentType("application/csv");
		AccountManage manage = serviceSession.getService(AccountManage.class);
		ScreeningVO query = new ScreeningVO();
		query.parse(request);//设置界面传来的参数
		ScreeningVO[] vos=manage.ScreeningList(query);
		manage.exportScreening(vos, response.getOutputStream()); //导出数据
	}
}
