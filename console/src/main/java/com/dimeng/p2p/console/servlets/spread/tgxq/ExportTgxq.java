package com.dimeng.p2p.console.servlets.spread.tgxq;

import java.io.BufferedWriter;
import java.io.OutputStreamWriter;
import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.modules.spread.console.service.SpreadManage;
import com.dimeng.p2p.modules.spread.console.service.entity.SpreadDetailList;
import com.dimeng.p2p.modules.spread.console.service.entity.SpreadDetailQuery;
import com.dimeng.p2p.console.servlets.spread.AbstractSpreadServlet;
import com.dimeng.util.StringHelper;
import com.dimeng.util.io.CVSWriter;
import com.dimeng.util.parser.IntegerParser;
import com.dimeng.util.parser.TimestampParser;

@Right(id = "P2P_C_SPREAD_TGXQ_EXPORT", name = "导出推广详情列表")
public class ExportTgxq extends AbstractSpreadServlet {

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

		SpreadManage manage = serviceSession.getService(SpreadManage.class);
		SpreadDetailQuery query = new SpreadDetailQuery() {

			@Override
			public String userName() {
				return request.getParameter("userName");
			}

			@Override
			public Timestamp startTime() {
				return TimestampParser.parse(request.getParameter("startTime"));
			}

			@Override
			public String personUserName() {
				return request.getParameter("personUserName");
			}

			@Override
			public String personName() {
				return request.getParameter("personName");
			}

			@Override
			public int personID() {
				return IntegerParser.parse(request.getParameter("personID"));
			}

			@Override
			public String name() {
				return request.getParameter("name");
			}

			@Override
			public int id() {
				return IntegerParser.parse(request.getParameter("id"));
			}

			@Override
			public Timestamp endTime() {
				return TimestampParser.parse(request.getParameter("endTime"));
			}
		};
		SpreadDetailList[] lists = manage.exportsSpreadDetailLists(query);
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
			writer.write("推广人ID");
			writer.write("推广人用户名");
			writer.write("推广人姓名");
			writer.write("被推广人ID");
			writer.write("被推广人用户名");
			writer.write("被推广人姓名");
			writer.write("首次充值金额");
			writer.write("首次充值时间 ");
			writer.write("有效推广奖励(元)");
			writer.newLine();
			for (SpreadDetailList list : lists) {
				writer.write(list.id);
				writer.write(list.userName);
				writer.write(list.name);
				writer.write(list.personID);
				writer.write(list.personUserName);
				writer.write(list.personName);
				writer.write(list.firstMoney);
				writer.write(list.firstTime);
				writer.write(list.spreadRewardMoney);
				writer.newLine();
			}
		}
		
	}

}
