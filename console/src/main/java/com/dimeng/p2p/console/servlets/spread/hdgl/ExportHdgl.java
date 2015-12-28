package com.dimeng.p2p.console.servlets.spread.hdgl;

import java.io.BufferedWriter;
import java.io.OutputStreamWriter;
import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.common.enums.ActivityStatus;
import com.dimeng.p2p.modules.spread.console.service.ActivityManage;
import com.dimeng.p2p.modules.spread.console.service.entity.ActivityList;
import com.dimeng.p2p.modules.spread.console.service.entity.ActivityQuery;
import com.dimeng.p2p.console.servlets.spread.AbstractSpreadServlet;
import com.dimeng.util.StringHelper;
import com.dimeng.util.io.CVSWriter;
import com.dimeng.util.parser.EnumParser;
import com.dimeng.util.parser.TimestampParser;

@Right(id = "P2P_C_SPREAD_HDGL_EXPORTHDGL", name = "导出活动管理")
public class ExportHdgl extends AbstractSpreadServlet {

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

		ActivityQuery query = new ActivityQuery() {

			@Override
			public String title() {
				return request.getParameter("title");
			}

			@Override
			public ActivityStatus status() {
				return EnumParser.parse(ActivityStatus.class,
						request.getParameter("status"));
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

		ActivityList[] lists = manage.exportActivity(query);

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
			writer.write("活动名称");
			writer.write("开始时间");
			writer.write("结束时间");
			writer.write("优惠券生效时间");
			writer.write("优惠券失效时间");
			writer.write("发放数量");
			writer.write("金额（元）");
			writer.write("最低充值金额");
			writer.write("最低投资金额");
			writer.write("最低推广人数");
			writer.write("创建人");
			writer.write("剩余数量");
			writer.newLine();
			int index = 1;
			for (ActivityList list : lists) {
				writer.write(index++);
				writer.write(list.F02);
				writer.write(list.F03);
				writer.write(list.F04);
				writer.write(list.F05);
				writer.write(list.F06);
				writer.write(list.F07);
				writer.write(list.F08);
				writer.write(list.F11);
				writer.write(list.F13);
				writer.write(list.F16);
				writer.write(list.F17);
				writer.write(list.F18);
				writer.newLine();
			}
		}
	}

}
