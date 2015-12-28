package com.dimeng.p2p.console.servlets.account.zhgl;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S61.entities.T6161;
import com.dimeng.p2p.console.servlets.account.AbstractAccountServlet;
import com.dimeng.p2p.modules.account.console.service.ZhglManage;

@Right(id = "P2P_C_ACCOUNT_ADDJG", name = "添加机构账号")
public class AddJg extends AbstractAccountServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		forwardView(request, response, getClass());
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			final HttpServletResponse response,
			final ServiceSession serviceSession) throws Throwable {
			ZhglManage manage = serviceSession.getService(ZhglManage.class);
			T6161 entity = new T6161();
			entity.parse(request);
			String realName=request.getParameter("realName");
			String lxTel=request.getParameter("lxTel");
			manage.addJg(entity,request.getParameter("jgjs"),realName,lxTel);
			sendRedirect(request, response,
					getController().getURI(request, ZhList.class));
	
	}
	
	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		prompt(request, response, PromptLevel.ERROR, throwable.getMessage());
		forwardView(request, response, getClass());
	}
	
}
