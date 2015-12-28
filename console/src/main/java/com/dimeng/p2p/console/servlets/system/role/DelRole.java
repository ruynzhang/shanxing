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
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_SYS_DELROLE", name = "删除角色")
public class DelRole extends AbstractSystemServlet {
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
		YhzManage roleManage = serviceSession.getService(YhzManage.class);
		int  id = IntegerParser.parse(request.getParameter("roleId"));
		roleManage.del(id);
		getController().prompt(request, response, PromptLevel.INFO, "操作成功");
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
					getController().getURI(request, RoleList.class));
		} else {
			super.onThrowable(request, response, throwable);
		}
	}
}
