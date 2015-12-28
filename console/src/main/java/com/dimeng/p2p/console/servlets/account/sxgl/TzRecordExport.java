package com.dimeng.p2p.console.servlets.account.sxgl;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.account.AbstractAccountServlet;
import com.dimeng.p2p.modules.account.console.service.AccountManage;
import com.dimeng.p2p.modules.account.console.service.entity.TzRecordVO;

@Right(id = "P2P_C_ACCOUNT_TZRECORDEXPORT", name = "导出投资记录")
public class TzRecordExport extends AbstractAccountServlet {

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
		TzRecordVO query = new TzRecordVO();
		query.parse(request);//设置界面传来的参数
		TzRecordVO[] vos=manage.TzRecordList(query);
		manage.exportTzRecord(vos, response.getOutputStream()); //导出数据
	}
}
