package com.dimeng.p2p.console.servlets.base.bank;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.base.AbstractBaseServlet;
import com.dimeng.p2p.modules.base.console.service.BankManage;

@Right(id = "P2P_C_BASE_ADDBANK", name = "添加银行")
public class AddBank extends AbstractBaseServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		BankManage manage = serviceSession.getService(BankManage.class);
		String name = request.getParameter("name");
		String code = request.getParameter("code");
		if (name == null) {
			getController().prompt(request, response, PromptLevel.WARRING,
					"银行名称不能为空");
			processGet(request, response, serviceSession);
			return;
		}
		if (manage.isBankExists(name)) {
			getController().prompt(request, response, PromptLevel.WARRING,
					"银行名称已经存在");
			processGet(request, response, serviceSession);
			return;
		}
		manage.add(name, code);
		sendRedirect(request, response,
				getController().getURI(request, SearchBank.class));
	}

}
