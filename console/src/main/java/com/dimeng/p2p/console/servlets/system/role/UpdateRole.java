package com.dimeng.p2p.console.servlets.system.role;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.LogicalException;
import com.dimeng.framework.service.exception.ParameterException;
import com.dimeng.p2p.console.servlets.system.AbstractSystemServlet;
import com.dimeng.p2p.modules.base.console.service.YhzManage;
import com.dimeng.p2p.modules.base.console.service.entity.Role;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_SYS_UPDATEROLE", name = "修改角色")
public class UpdateRole extends AbstractSystemServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		int  roleId = IntegerParser.parse(request.getParameter("roleId"));
		YhzManage roleManage = serviceSession.getService(YhzManage.class);
		Role role = roleManage.get(roleId);
		request.setAttribute("role", role);
		forwardView(request, response, getClass());
	}
	
	
	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		YhzManage roleManage = serviceSession.getService(YhzManage.class);
		int  id = IntegerParser.parse(request.getParameter("roleId"));
		String name = request.getParameter("name");
		String des = request.getParameter("des");
		
		roleManage.update(id, name, des);
			sendRedirect(request, response,
					getController().getURI(request, RoleList.class));
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
					getController().getURI(request, UpdateRole.class)+"?roleId="+request.getParameter("roleId"));
		} else {
			super.onThrowable(request, response, throwable);
		}
	}
}
