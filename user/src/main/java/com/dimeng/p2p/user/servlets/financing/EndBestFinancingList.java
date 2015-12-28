package com.dimeng.p2p.user.servlets.financing;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.modules.bid.user.service.YxlcManage;
import com.dimeng.p2p.modules.bid.user.service.entity.BestFinacingInfo;
import com.dimeng.p2p.modules.bid.user.service.entity.EndBestFinacing;
import com.dimeng.util.ObjectHelper;

/**
 * 优选理财计划，分页查询已截止的优选理财计划
 *
 */
public class EndBestFinancingList extends AbstractFinancingServlet{

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		
	}

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		YxlcManage manage = serviceSession.getService(YxlcManage.class);
		final int currPage = ObjectHelper.convert(request.getParameter("currPage"), Integer.class);
		Paging paging = new Paging() {
			
			@Override
			public int getSize() {
				return 10;
			}
			@Override
			public int getCurrentPage() {
				return currPage;
			}
		};
		PagingResult<EndBestFinacing> pagingResult = manage.getEndBestFinacing(paging);
		BestFinacingInfo info = manage.getBestFinacingInfo();
		request.setAttribute("info", info);
		request.setAttribute("pagingResult", pagingResult);
		forward(request, response, "...");
	}
	

}
