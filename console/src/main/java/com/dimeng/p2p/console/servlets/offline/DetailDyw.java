package com.dimeng.p2p.console.servlets.offline;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S62.entities.T6234;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.modules.bid.console.service.OfflineManage;
import com.dimeng.p2p.modules.bid.console.service.entity.BidDywsx;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_OFFLINE_ADDUSERHOUSE", name = "添加标的抵押属性信息", isMenu = false)
public class DetailDyw extends AbstractBidServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		OfflineManage OfflineManage = serviceSession.getService(OfflineManage.class);
		int id = IntegerParser.parse(request.getParameter("id"));
		T6234 t6234 = OfflineManage.getBidDyw(id);
		BidDywsx[] t6235s = OfflineManage.searchBidDywsx(id);
		request.setAttribute("t6234", t6234);
		request.setAttribute("t6235s", t6235s);
		forwardView(request, response, getClass());
	}
}
