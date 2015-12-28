package com.dimeng.p2p.console.servlets.bid.hbgl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.S10.entities.RedPacket;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.service.RedPacketManage;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_BUSI_REDPLIST",isMenu = true, name = "红包管理")
public class RedpList extends AbstractBidServlet  {
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
		RedPacketManage manage = serviceSession.getService(RedPacketManage.class);
		RedPacket query = new RedPacket();
		query.parse(request);//设置界面传来的参数
		//分页对象
		PagingResult<RedPacket> list = manage.getList(query, new Paging() {
			@Override
			public int getSize() {
				return 10;
			}
			@Override
			public int getCurrentPage() {
				return IntegerParser.parse(request.getParameter(PAGING_CURRENT));
			}
		});
		request.setAttribute("list", list);
		forwardView(request, response, getClass());
	}
}
