package com.dimeng.p2p.console.servlets.finance.dzgl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.S61.entities.T6110;
import com.dimeng.p2p.escrow.huichao.service.BaseOrder;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_FINANCE_USERAVLQUERY", isMenu = true, name = "用户余额查询")
public class UserList extends AbstractDzglServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		final int pageNum = IntegerParser.parse(request
				.getParameter(PAGING_CURRENT));
		final String name = request.getParameter("userName");
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
		BaseOrder manage = serviceSession
				.getService(BaseOrder.class);
		PagingResult<T6110> pagingResult = manage.selectUserList(name, paging);
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
