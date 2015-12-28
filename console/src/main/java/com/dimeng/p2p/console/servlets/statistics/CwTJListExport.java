package com.dimeng.p2p.console.servlets.statistics;

import java.sql.Timestamp;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.modules.account.console.service.CwTJManage;
import com.dimeng.p2p.modules.account.console.service.entity.CwTJVO;

@Right(id = "P2P_C_STATISTICS_CWTJLISTEXPORT", name = "财务统计数据导出")
public class CwTJListExport extends AbstractStatisticsServlet {
	private static final long serialVersionUID = 1L;
	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		response.setHeader("Content-disposition", "attachment;filename="
				+ new Timestamp(System.currentTimeMillis()).getTime() + ".csv");
		response.setContentType("application/csv");
		CwTJManage manage = serviceSession.getService(CwTJManage.class);
		CwTJVO query = new CwTJVO();
		query.parse(request);//设置查询条件
		List<CwTJVO> list=manage.seach(query);
		//导出财务统计数据
		manage.exportCwTJList(list, response.getOutputStream());
	}
}
