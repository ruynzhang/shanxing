package com.dimeng.p2p.console.servlets.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.LogicalException;
import com.dimeng.p2p.console.servlets.AbstractConsoleServlet;
import com.dimeng.p2p.modules.systematic.console.service.SysUserManage;
import com.dimeng.util.StringHelper;

public class Update extends AbstractConsoleServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		try {
			SysUserManage sysUserManage = serviceSession
					.getService(SysUserManage.class);
			String oldPassWord = request.getParameter("oldPassWord");
			String newPassWord1 = request.getParameter("newPassWord1");
			String newPassWord2 = request.getParameter("newPassWord2");
			if (StringHelper.isEmpty(newPassWord1)
					|| StringHelper.isEmpty(newPassWord2)
					|| !newPassWord1.equals(newPassWord2)) {
				throw new LogicalException("新密码不能为空,并且两次输入需要一致");
			}
			sysUserManage.updatePassWord(oldPassWord, newPassWord1);
			sendRedirect(request, response,
					getController().getURI(request, Index.class));
		} catch (Exception e) {
			prompt(request, response, PromptLevel.WARRING, e.getMessage());
			forward(request, response,
					getController().getURI(request, Index.class));
		}
	}

}
