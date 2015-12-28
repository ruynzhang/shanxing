package com.dimeng.p2p.console.servlets.bid.hbgl;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.S10.entities.RedPacketRecord;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.service.RedPacketManage;
import com.dimeng.util.parser.IntegerParser;

public class RedpRecordExport extends AbstractBidServlet  {

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		response.setHeader("Content-disposition", "attachment;filename="
				+ new Timestamp(System.currentTimeMillis()).getTime() + ".csv");
		response.setContentType("application/csv");
		RedPacketManage manage = serviceSession.getService(RedPacketManage.class);
		RedPacketRecord query = new RedPacketRecord();
		query.parse(request);//设置界面传来的参数
		//分页对象
		PagingResult<RedPacketRecord> list = manage.getListRecord(query, new Paging() {
			@Override
			public int getSize() {
				return 9999999;
			}
			@Override
			public int getCurrentPage() {
				return IntegerParser.parse(request.getParameter(PAGING_CURRENT));
			}
		});
		manage.exportRecord(list!=null?list.getItems():null, response.getOutputStream()); //导出数据
	}
	
	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}
}
