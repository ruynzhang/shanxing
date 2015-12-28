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
import com.dimeng.p2p.modules.salesman.console.service.entity.Customers;
import com.dimeng.p2p.modules.salesman.console.service.query.CustomersQuery;
import com.dimeng.util.StringHelper;
import com.dimeng.util.io.CVSWriter;
import com.dimeng.util.parser.TimestampParser;

@Right(id = "P2P_C_SPREAD_HDGL_EXPORTYWTJ", name = "导出推荐统计业务")
public class ExportStatistics extends AbstractSpreadServlet {

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
		CustomersQuery query =new CustomersQuery() {
			@Override
			public String ywyId() {
				return request.getParameter("ywyId");
			}
			
			@Override
			public String tel() {
				return request.getParameter("tel");
			}
			
			@Override
			public Timestamp startTime() {
				return TimestampParser.parse(request.getParameter("startTime"));
			}
			
			@Override
			public String name() {
				return request.getParameter("name");
			}
			
			@Override
			public Timestamp endTime() {
				return TimestampParser.parse(request.getParameter("endTime"));
			}
		};

		
		Customers[] lists = manage.search(query);
		

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
			writer.write("日期");
			writer.write("用户账户");
			writer.write("用户姓名");
			writer.write("金额");
			writer.write("交易类型");
			writer.newLine();
			int index = 1;
			for (Customers list : lists) {
				writer.write(index++);
				writer.write(TimestampParser.format(list.F04));
				writer.write(list.loginName);
				writer.write(list.userName);
				writer.write(list.F05);
				writer.write(list.F06.getChineseName());
				writer.newLine();
			}
		}
	}

}
