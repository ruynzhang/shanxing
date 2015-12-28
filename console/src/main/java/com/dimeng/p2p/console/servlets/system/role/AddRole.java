package com.dimeng.p2p.console.servlets.system.role;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.service.RoleManage;
import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.LogicalException;
import com.dimeng.framework.service.exception.ParameterException;
import com.dimeng.p2p.console.servlets.system.AbstractSystemServlet;

@Right(id = "P2P_C_SYS_ADDROLE", name = "添加角色")
public class AddRole extends AbstractSystemServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		RoleManage roleManage = serviceSession.getService(RoleManage.class);
		String name = request.getParameter("name");
		String des = request.getParameter("des");
		int roleId = roleManage.add(name, des);
		if (roleId > 0) {
			sendRedirect(request, response,
					getController().getURI(request, RoleList.class));
		}
	}

	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		if (throwable instanceof LogicalException
				|| throwable instanceof ParameterException) {
			getController().prompt(request, response, PromptLevel.WARRING,
					throwable.getMessage());
			sendRedirect(request, response,
					getController().getURI(request, AddRole.class));
		} else {
			super.onThrowable(request, response, throwable);
		}
	}
}
