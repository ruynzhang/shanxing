package com.dimeng.p2p.console.servlets.system.role;

import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.config.entity.ModuleBean;
import com.dimeng.framework.http.entity.RightBean;
import com.dimeng.framework.http.entity.RoleBean;
import com.dimeng.framework.http.service.RightManage;
import com.dimeng.framework.http.service.RoleManage;
import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.system.AbstractSystemServlet;
import com.dimeng.util.StringHelper;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_SYS_SETMENU", name = "设置菜单")
public class SetMenu extends AbstractSystemServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		RoleManage roleManage = serviceSession.getService(RoleManage.class);
		ModuleBean[] moduleBeans = getResourceProvider().getModuleBeans();
		int roleId = IntegerParser.parse(request.getParameter("roleId"));
		RightManage rightManage = serviceSession.getService(RightManage.class);
		RightBean[] rightBeans = rightManage.getRoleRights(roleId);
		RoleBean roleBean = roleManage.getRole(roleId);
		StringBuilder sb = new StringBuilder();
		for (RightBean rightBean : rightBeans) {
			sb.append(rightBean.getId());
		}
		request.setAttribute("rights", sb.toString());
		request.setAttribute("moduleBeans", moduleBeans);
		request.setAttribute("roleBean", roleBean);
		request.setAttribute("roleId", roleId);
		forwardView(request, response, getClass());
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		RightManage rightManage = serviceSession.getService(RightManage.class);
		int roleId = IntegerParser.parse(request.getParameter("roleId"));
		if (roleId > 0) {
			RightBean[] rightBeans = rightManage.getRoleRights(roleId);
			Set<String> rightIds = new HashSet<>();
			if (rightBeans != null) {
				for (RightBean rightBean : rightBeans) {
					if (!rightBean.isMenu() && !rightBean.isDeprecated()) {
						rightIds.add(rightBean.getId());
					}
				}
			}
			String[] values = request.getParameterValues("rightIds");
			if (values != null) {
				for (String value : values) {
					if (StringHelper.isEmpty(value)) {
						continue;
					}
					rightIds.add(value);
				}
			}
			rightManage.setRoleRights(roleId,
					rightIds.toArray(new String[rightIds.size()]));
		}
		sendRedirect(request, response,
				getController().getURI(request, RoleList.class));
	}

	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		super.onThrowable(request, response, throwable);
	}
}
