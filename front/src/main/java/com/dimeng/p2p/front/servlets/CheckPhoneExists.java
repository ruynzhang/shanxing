package com.dimeng.p2p.front.servlets;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.LogicalException;
import com.dimeng.framework.service.exception.ParameterException;
import com.dimeng.p2p.account.front.service.PasswordManage;

/**
 * 
 * @description 校验手机是否存在
 * @author Zheng Xin
 * @date 2014年11月19日
 *
 */
public class CheckPhoneExists extends AbstractFrontServlet {
	private static final long serialVersionUID = 1L;
	/**
	 * 是否需要校验登录状态
	 */
	@Override
	protected boolean mustAuthenticated() {
		return false;
	}

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		response.setContentType("text/html;charset="
				+ getResourceProvider().getCharset());
		String mobilephone = request.getParameter("mobilephone");
		//获取service对象
		PasswordManage passwordManage = serviceSession.getService(PasswordManage.class);
		//查询手机号码是否存在
		int isExist = passwordManage.phoneExist(mobilephone);
		response.getWriter().println(isExist > 0);
		response.getWriter().flush();
	}

	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		if (throwable instanceof SQLException
				|| throwable instanceof ParameterException
				|| throwable instanceof LogicalException) {
			getController().prompt(request, response, PromptLevel.ERROR,
					throwable.getMessage());
			throwable.getStackTrace();
			sendRedirect(request, response,
					getController().getViewURI(request, Register.class));
		} else {
			super.onThrowable(request, response, throwable);
		}
	}
}
