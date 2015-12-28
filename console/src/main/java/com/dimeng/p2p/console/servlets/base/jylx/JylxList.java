package com.dimeng.p2p.console.servlets.base.jylx;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.S51.entities.T5122;
import com.dimeng.p2p.S51.enums.T5122_F03;
import com.dimeng.p2p.console.servlets.base.AbstractBaseServlet;
import com.dimeng.p2p.modules.base.console.service.TradeTypeManage;
import com.dimeng.p2p.modules.base.console.service.entity.TradetypeQuery;
import com.dimeng.util.parser.EnumParser;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_BASE_JYLXLIST", isMenu = true, name = "交易类型管理")
public class JylxList extends AbstractBaseServlet {
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
		TradeTypeManage tradeTypeManage = serviceSession
				.getService(TradeTypeManage.class);
		PagingResult<T5122> result = tradeTypeManage.search(
				new TradetypeQuery() {

					@Override
					public T5122_F03 getStatus() {
						return EnumParser.parse(T5122_F03.class,
								request.getParameter("status"));
					}

					@Override
					public String getName() {
						return request.getParameter("name");
					}

				}, new Paging() {

					@Override
					public int getSize() {
						return 10;
					}

					@Override
					public int getCurrentPage() {
						return IntegerParser.parse(request
								.getParameter(PAGING_CURRENT));
					}
				});
		request.setAttribute("result", result);
		forwardView(request, response, getClass());
	}
}
