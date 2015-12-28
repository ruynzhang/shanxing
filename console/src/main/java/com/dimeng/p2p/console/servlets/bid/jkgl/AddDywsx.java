package com.dimeng.p2p.console.servlets.bid.jkgl;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S62.entities.T6213;
import com.dimeng.p2p.S62.entities.T6214;
import com.dimeng.p2p.S62.entities.T6235;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.modules.base.console.service.DywlxManage;
import com.dimeng.p2p.modules.bid.console.service.BidManage;
import com.dimeng.p2p.modules.bid.console.service.entity.BidDyw;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_LOAN_ADDUSERHOUSE", name = "添加标的抵押属性信息", isMenu = false)
public class AddDywsx extends AbstractBidServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		DywlxManage dywlxManage = serviceSession.getService(DywlxManage.class);
		int typeId = IntegerParser.parse(request.getParameter("typeId"));
		T6213[] t6213s = dywlxManage.getDyws();
		T6214[] t6214s = dywlxManage.getDywsx(typeId);
		String typeName = dywlxManage.getNameById(typeId);
		request.setAttribute("t6213s", t6213s);
		request.setAttribute("t6214s", t6214s);
		request.setAttribute("typeName", typeName);
		forwardView(request, response, getClass());
	}

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		int userId = IntegerParser.parse(request.getParameter("userId"));
		int loanId = IntegerParser.parse(request.getParameter("loanId"));
		int typeId = IntegerParser.parse(request.getParameter("typeId"));
		try {
			DywlxManage dywlxManage = serviceSession
					.getService(DywlxManage.class);
			BidManage bidManage = serviceSession.getService(BidManage.class);
			T6214[] t6214s = dywlxManage.getDywsx(typeId);
			BidDyw bidDyw = new BidDyw();
			bidDyw.parse(request);
			bidDyw.F02 = loanId;
			List<T6235> lists = new ArrayList<>();
			if (t6214s != null) {
				for (int i = 0; i < t6214s.length; i++) {
					T6235 t6235 = new T6235();
					t6235.F03 = IntegerParser.parse(request
							.getParameter("t6235s[" + i + "].F03"));
					t6235.F04 = request.getParameter("t6235s[" + i + "].F04");
					lists.add(t6235);
				}
			}
			bidDyw.t6235s = lists.toArray(new T6235[lists.size()]);
			bidManage.addBidDyw(bidDyw);
			sendRedirect(request, response,
					getController().getURI(request, AddDyw.class) + "?loanId="
							+ loanId + "&userId=" + userId);
		} catch (Throwable throwable) {
			processGet(request, response, serviceSession);
		}
	}
}
