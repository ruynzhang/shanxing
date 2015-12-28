package com.dimeng.p2p.console.servlets.spread.ywygl;

import java.io.BufferedWriter;
import java.io.OutputStreamWriter;
import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.spread.AbstractSpreadServlet;
import com.dimeng.p2p.modules.salesman.console.service.SalesmanManage;
import com.dimeng.p2p.modules.salesman.console.service.entity.Salesman;
import com.dimeng.p2p.modules.salesman.console.service.query.SalesmanQuery;
import com.dimeng.util.StringHelper;
import com.dimeng.util.io.CVSWriter;

@Right(id = "P2P_C_SPREAD_HDGL_EXPORTYWTJ", name = "导出推荐统计业务")
public class ExportYwy extends AbstractSpreadServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {

		SalesmanManage manage = serviceSession.getService(SalesmanManage.class);
		SalesmanQuery query =new SalesmanQuery() {
			@Override
			public String ywyId() {
				return request.getParameter("ywyId");
			}
			
			@Override
			public String tel() {
				return request.getParameter("tel");
			}
			
			@Override
			public String name() {
				return request.getParameter("name");
			}
		};

		
		Salesman[] lists = manage.search(query);
		

		response.setHeader("Content-disposition", "attachment;filename="
				+ new Timestamp(System.currentTimeMillis()).getTime() + ".csv");
		response.setContentType("application/csv");
		String charset = null;
		if (lists == null) {
			return;
		}
		if (StringHelper.isEmpty(charset)) {
			charset = "GBK";
		}
		try (BufferedWriter out = new BufferedWriter(new OutputStreamWriter(
				response.getOutputStream(), charset))) {
			CVSWriter writer = new CVSWriter(out);
			writer.write("序号");
			writer.write("业务ID");
			writer.write("业务员姓名");
			writer.write("业务员手机号");
			writer.newLine();
			int index = 1;
			for (Salesman list : lists) {
				writer.write(index++);
				writer.write(list.ywyId);
				writer.write(list.name);
				writer.write(list.tel);
				writer.newLine();
			}
		}
	}

}
