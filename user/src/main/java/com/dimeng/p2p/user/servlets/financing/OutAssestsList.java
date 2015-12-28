/*package com.dimeng.p2p.user.servlets.financing;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.modules.bid.front.service.WdzqManage;
import com.dimeng.p2p.modules.bid.front.service.entity.AssetsInfo;
import com.dimeng.util.ObjectHelper;

*//**
 * 我的债权，分页查询已转出的债权
 *
 *//*
public class OutAssestsList extends AbstractFinancingServlet{

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
		WdzqManage manage = serviceSession.getService(WdzqManage.class);
		
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
		PagingResult<OutAssests> pagingResult = manage.getOutAssests(paging);
		AssetsInfo info = manage.getAssetsInfo();
		
		request.setAttribute("info", info);
		request.setAttribute("pagingResult", pagingResult);
		
		forward(request, response, "");
	}
	
	

}
*/