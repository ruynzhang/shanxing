package com.dimeng.p2p.console.servlets.system.role;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.entity.RoleBean;
import com.dimeng.framework.http.service.RoleManage;
import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.console.servlets.system.AbstractSystemServlet;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_SYS_ROLELIST", isMenu = true, name = "用户组管理")
public class RoleList extends AbstractSystemServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		RoleManage roleManage = serviceSession.getService(RoleManage.class);
		PagingResult<RoleBean> result = roleManage.search(null, new Paging() {

			@Override
			public int getSize() {
				return IntegerParser.parse(request.getParameter("paging.size"));
			}

			@Override
			public int getCurrentPage() {
				return IntegerParser.parse(request
						.getParameter("paging.current"));
			}
		});
		request.setAttribute("result", result);
		forwardView(request, response, getClass());
	}
}
