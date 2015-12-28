package com.dimeng.p2p.console.servlets.spread.hdgl;

import java.io.BufferedWriter;
import java.io.OutputStreamWriter;
import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.modules.spread.console.service.ActivityManage;
import com.dimeng.p2p.modules.spread.console.service.entity.PartakePersonList;
import com.dimeng.p2p.modules.spread.console.service.entity.PartakeQuery;
import com.dimeng.p2p.console.servlets.spread.AbstractSpreadServlet;
import com.dimeng.util.StringHelper;
import com.dimeng.util.io.CVSWriter;
import com.dimeng.util.parser.IntegerParser;
import com.dimeng.util.parser.TimestampParser;

@Right(id = "P2P_C_SPREAD_HDGL_EXPORTHDCRY", name = "导出参与人列表")
public class ExportHdcry extends AbstractSpreadServlet {

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

		ActivityManage manage = serviceSession.getService(ActivityManage.class);
		int id = IntegerParser.parse(request.getParameter("id"));

		PartakeQuery query = new PartakeQuery() {

			@Override
			public String userName() {
				return request.getParameter("userName");
			}

			@Override
			public Timestamp startTime() {
				return TimestampParser.parse(request.getParameter("startTime"));
			}

			@Override
			public Timestamp endTime() {
				return TimestampParser.parse(request.getParameter("endTime"));
			}

		};

		PartakePersonList[] lists = manage.exportPartakePerson(id, query);

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
			writer.write("参与人");
			writer.write("姓名");
			writer.write("活动奖励（元）");
			writer.write("使用类型");
			writer.write("领取时间");
			writer.write("使用时间");
			writer.newLine();
			int index = 1;
			for (PartakePersonList list : lists) {
				writer.write(index++);
				writer.write(list.userName);
				writer.write(list.name);
				writer.write(list.reward);
				writer.write(list.T6322_F07.getChineseName());
				writer.write(list.getTime);
				writer.write(list.useTime);
				writer.newLine();
			}
		}
	
	}

}
