package com.dimeng.p2p.console.servlets.finance.yccl;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;


@Right(id = "P2P_C_FINANCE_YHZC", isMenu = true, name = "用户注册")
public class Yhzc extends AbstractFinanceServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		String loginName = request.getParameter("loginName");
		String custId = request.getParameter("custId");
		String realName = request.getParameter("realName");
		String idCard = request.getParameter("idCard");
		String tel = request.getParameter("tel");
		String email = request.getParameter("email");

//		UserManage manage = serviceSession.getService(UserManage.class);
//		UserRegisterEntity entity = new UserRegisterEntity();
//		entity.usrId = loginName;
//		entity.usrMp = tel;
//		entity.usrEmail = email;
//		entity.idNo = idCard;
//		entity.usrCustId = custId;
//		entity.usrName = realName;
//
//		manage.updateUserInfo(entity);

		getController().prompt(request, response, PromptLevel.INFO, "修正成功");
		sendRedirect(request, response,
				getController().getViewURI(request, getClass()));
	}

	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		getController().prompt(request, response, PromptLevel.INFO,
				throwable.getMessage());
		forwardView(request, response, getClass());
	}
}
