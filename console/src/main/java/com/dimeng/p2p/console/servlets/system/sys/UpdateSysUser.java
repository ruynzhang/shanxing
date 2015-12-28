package com.dimeng.p2p.console.servlets.system.sys;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.entity.RoleBean;
import com.dimeng.framework.http.service.RoleManage;
import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.console.servlets.system.AbstractSystemServlet;
import com.dimeng.p2p.modules.systematic.console.service.SysUserManage;
import com.dimeng.p2p.modules.systematic.console.service.entity.SysUser;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_SYS_UPDATESYSUSER", name = "管理员管理修改")
public class UpdateSysUser extends AbstractSystemServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		int id = IntegerParser.parse(request.getParameter("id"));
		SysUserManage sysUserManage = serviceSession
				.getService(SysUserManage.class);
		SysUser sysUser = sysUserManage.get(id);
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
		request.setAttribute("sysUser", sysUser);
		forwardView(request, response, getClass());
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		SysUserManage sysUserManage = serviceSession
				.getService(SysUserManage.class);
		RoleManage roleManage = serviceSession.getService(RoleManage.class);
		String password = request.getParameter("password");
		String name = request.getParameter("name");
		String status = request.getParameter("status");
		int id = IntegerParser.parse(request.getParameter("id"));
		int roleId = IntegerParser.parse(request.getParameter("roleId"));
		sysUserManage.update(id, password, name, status);
		roleManage.setRoles(id, roleId);
		sendRedirect(request, response,
				getController().getURI(request, SysUserList.class));
	}

	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		super.onThrowable(request, response, throwable);
	}
}
