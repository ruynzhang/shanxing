package com.dimeng.p2p.console.servlets.spread.tgtj;

import java.io.BufferedWriter;
import java.io.OutputStreamWriter;
import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.modules.spread.console.service.SpreadManage;
import com.dimeng.p2p.modules.spread.console.service.entity.SpreadTotalList;
import com.dimeng.p2p.modules.spread.console.service.entity.SpreadTotalQuery;
import com.dimeng.p2p.console.servlets.spread.AbstractSpreadServlet;
import com.dimeng.util.StringHelper;
import com.dimeng.util.io.CVSWriter;
import com.dimeng.util.parser.IntegerParser;
@Right(id = "P2P_C_SPREAD_TGTJ_EXPORT", name = "导出推广奖励概要列表")
public class ExportTgtj extends AbstractSpreadServlet{

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
		SpreadTotalQuery query =  new SpreadTotalQuery() {
			
			@Override
			public String userName() {
				return request.getParameter("userName");
			}
			
			@Override
			public String name() {
				return request.getParameter("name");
			}
			
			@Override
			public int id() {
				return IntegerParser.parse(request.getParameter("id"));
			}
		};
		SpreadTotalList[] lists = manage.exportSpreadTotalLists(query);
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
		try (BufferedWriter out = new BufferedWriter(new OutputStreamWriter(response.getOutputStream(), charset))) {
			CVSWriter writer = new CVSWriter(out);
			writer.write("推广人ID");
			writer.write("推广人用户名");
			writer.write("推广人姓名");
			writer.write("推广客户数");
			writer.write("连续奖励总计(元)");
			writer.write("有效推广奖励总计(元)");
			writer.write("推广奖励总计(元)");
			writer.newLine();
			for (SpreadTotalList list : lists) {
				writer.write(list.personID);
				writer.write(list.userName);
				writer.write(list.name);
				writer.write(list.customNum);
				writer.write(list.seriesRewarMoney);
				writer.write(list.validRewardMoney);
				writer.write(list.rewardTotalMoney);
				writer.newLine();
			}
		}
		
	}
	
	
}
