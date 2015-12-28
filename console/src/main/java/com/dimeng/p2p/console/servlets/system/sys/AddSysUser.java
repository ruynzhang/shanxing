package com.dimeng.p2p.console.servlets.system.sys;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.entity.RoleBean;
import com.dimeng.framework.http.service.RoleManage;
import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.LogicalException;
import com.dimeng.framework.service.exception.ParameterException;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.console.servlets.system.AbstractSystemServlet;
import com.dimeng.p2p.modules.systematic.console.service.SysUserManage;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_SYS_ADDSYSUSER", name = "添加系统用户")
public class AddSysUser extends AbstractSystemServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		RoleManage roleManage = serviceSession.getService(RoleManage.class);
		PagingResult<RoleBean> result = roleManage.search(null, new Paging() {

			@Override
			public int getSize() {
				return Integer.MAX_VALUE;
			}

			@Override
			public int getCurrentPage() {
				return 1;
			}
		});
		request.setAttribute("roles", result.getItems());
		forwardView(request, response, getClass());
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		SysUserManage sysUserManage = serviceSession
				.getService(SysUserManage.class);
		RoleManage roleManage = serviceSession.getService(RoleManage.class);
		String accountName = request.getParameter("accountName");
		String password = request.getParameter("password");
		String name = request.getParameter("name");
		String status = request.getParameter("status");
		int roleId = IntegerParser.parse(request.getParameter("roleId"));
		int sysUserId = 0;
		try {
			sysUserId = sysUserManage.add(accountName, password, name, status);
		} catch (Throwable e) {
			if (e instanceof ParameterException
					|| e instanceof LogicalException) {
				getController().prompt(request, response, PromptLevel.WARRING,
						e.getMessage());
				processGet(request, response, serviceSession);
			} else {
				super.onThrowable(request, response, e);
			}
		}
		if (sysUserId > 0) {
			roleManage.setRoles(sysUserId, roleId);
			sendRedirect(request, response,
					getController().getURI(request, SysUserList.class));
		}
	}
}
