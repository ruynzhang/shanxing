package com.dimeng.p2p.console.servlets.account.grxx;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.p2p.console.servlets.account.AbstractAccountServlet;
import com.dimeng.p2p.modules.account.console.service.GrManage;
import com.dimeng.p2p.modules.account.console.service.KhjlManage;
import com.dimeng.p2p.modules.account.console.service.entity.BasicInfo;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_ACCOUNT_HFJLVIEW", name = "管理员查看回访记录列表")
public class HfjlView extends AbstractAccountServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		GrManage manage = serviceSession.getService(GrManage.class);
		KhjlManage khjlManage = serviceSession.getService(KhjlManage.class);
		int userId = IntegerParser.parse(request.getParameter("userId"));
		BasicInfo basicInfo = manage.findBasicInfo(userId);
		if (basicInfo == null) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			return;
		}
		Paging paging = new Paging() {

			@Override
			public int getSize() {
				return 10;
			}

			@Override
			public int getCurrentPage() {
				return IntegerParser.parse(request
						.getParameter(PAGING_CURRENT));
			}
		};
		request.setAttribute("basicInfo", basicInfo);
		request.setAttribute("list", khjlManage.searchHfjl(userId, paging));
		forwardView(request, response, getClass());
	}

}
