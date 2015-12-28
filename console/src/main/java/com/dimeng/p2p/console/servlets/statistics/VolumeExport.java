package com.dimeng.p2p.console.servlets.statistics;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.modules.statistics.console.service.VolumeManage;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_STATISTICS_VOLEXPORT", name = "平台成交数据导出")
public class VolumeExport extends AbstractStatisticsServlet {

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		int year = IntegerParser.parse(request.getParameter("year"));
		response.setHeader("Content-disposition", "attachment;filename="
				+ new Timestamp(System.currentTimeMillis()).getTime() + ".zip");
		response.setContentType("application/zip");
		VolumeManage volumeManage = serviceSession.getService(VolumeManage.class);
		volumeManage.export(response.getOutputStream(), year, "GBK");
	}
	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}

}
