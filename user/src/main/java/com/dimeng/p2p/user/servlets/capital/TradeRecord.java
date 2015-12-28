package com.dimeng.p2p.user.servlets.capital;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.modules.capital.user.service.TradeRecordManage;
import com.dimeng.p2p.modules.capital.user.service.entity.TradeRecordVO;
import com.dimeng.util.parser.IntegerParser;

public class TradeRecord extends AbstractCapitalServlet {
	private static final long serialVersionUID = 1L;
	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}
	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, final ServiceSession serviceSession)
			throws Throwable {
		TradeRecordManage manage = serviceSession.getService(TradeRecordManage.class);
		TradeRecordVO query = new TradeRecordVO();
		query.userId=serviceSession.getSession().getAccountId();
		PagingResult<TradeRecordVO> list = manage.search(query, new Paging() {
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
