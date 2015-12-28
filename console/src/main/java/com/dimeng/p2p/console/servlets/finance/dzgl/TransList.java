package com.dimeng.p2p.console.servlets.finance.dzgl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.S65.entities.T6501;
import com.dimeng.p2p.escrow.huichao.service.DzglManager;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_FINANCE_TRANSSTAT", isMenu = true, name = "交易状态查询")
public class TransList extends AbstractDzglServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		int orderId = IntegerParser.parse(request.getParameter("orderId"));
		int type = IntegerParser.parse(request.getParameter("type"));
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		DzglManager manage = serviceSession
				.getService(DzglManager.class);
		final int pageNum = IntegerParser.parse(request
				.getParameter(PAGING_CURRENT));
		Paging paging = new Paging() {

			@Override
			public int getSize() {
				return 20;
			}

			@Override
			public int getCurrentPage() {
				if (pageNum > 0) {
					return pageNum;
				}
				return 0;
			}
		};
		PagingResult<T6501> pagingResult = manage.orderList(orderId, startDate,
				endDate, type, paging);
		request.setAttribute("pagingResult", pagingResult);
		forward(request, response,
				getController().getViewURI(request, getClass()));
	}
	
	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}
}
