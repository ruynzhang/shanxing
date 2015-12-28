package com.dimeng.p2p.console.servlets.system.constant;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.config.entity.VariableBean;
import com.dimeng.framework.config.service.VariableManage;
import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.system.AbstractSystemServlet;
import com.dimeng.p2p.modules.systematic.console.service.ConstantManage;

@Right(id = "P2P_C_SYS_UPDATECONSTANT", name = "平台常量设置编辑")
public class UpdateConstant extends AbstractSystemServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		VariableManage variableManage = serviceSession
				.getService(VariableManage.class);
		final String key = request.getParameter("key");
		final VariableBean variableBean = variableManage.get(key);
		request.setAttribute("variableBean", variableBean);
		forwardView(request, response, getClass());
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		VariableManage variableManage = serviceSession
				.getService(VariableManage.class);
		ConstantManage constantManage = serviceSession
				.getService(ConstantManage.class);
		String key = request.getParameter("key");
		VariableBean variableBean = variableManage.get(key);
		String value = request.getParameter("value");
		// variableManage.synchronize();
		try {
			variableManage.setProperty(key, value);
			constantManage.addConstantLog(key, variableBean.getDescription(),
					variableBean.getValue(), value);
			sendRedirect(request, response,
					getController().getURI(request, ConstantList.class));
		} catch (Throwable t) {
			getController().prompt(request, response, PromptLevel.WARRING,
					t.getMessage());
			processGet(request, response, serviceSession);
		}
	}
}
