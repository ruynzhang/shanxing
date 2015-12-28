package com.dimeng.p2p.console.servlets.offline;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S62.entities.T6234;
import com.dimeng.p2p.S62.entities.T6235;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.modules.bid.console.service.OfflineManage;
import com.dimeng.p2p.modules.bid.console.service.entity.BidDyw;
import com.dimeng.p2p.modules.bid.console.service.entity.BidDywsx;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_OFFLINE_ADDUSERHOUSE", name = "修改标的抵押信息")
public class UpdateDywsx extends AbstractBidServlet {

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

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		int userId = IntegerParser.parse(request.getParameter("userId"));
		int loanId = IntegerParser.parse(request.getParameter("loanId"));
		int id = IntegerParser.parse(request.getParameter("id"));
		try {
			OfflineManage OfflineManage = serviceSession.getService(OfflineManage.class);
			BidDywsx[] t6235s = OfflineManage.searchBidDywsx(id);
			BidDyw bidDyw = new BidDyw();
			bidDyw.parse(request);
			bidDyw.F01 = id;
			List<T6235> lists = new ArrayList<>();
			if (t6235s != null) {
				for (int i = 0; i < t6235s.length; i++) {
					T6235 t6235 = new T6235();
					t6235.F03 = IntegerParser.parse(request
							.getParameter("t6235s[" + i + "].F03"));
					t6235.F04 = request.getParameter("t6235s[" + i + "].F04");
					lists.add(t6235);
				}
			}
			bidDyw.t6235s = lists.toArray(new T6235[lists.size()]);
			OfflineManage.updateBidDyw(bidDyw);
			sendRedirect(request, response,
					getController().getURI(request, AddDyw.class) + "?loanId="
							+ loanId + "&userId=" + userId);
		} catch (Throwable throwable) {
			processGet(request, response, serviceSession);
		}
	}
}
