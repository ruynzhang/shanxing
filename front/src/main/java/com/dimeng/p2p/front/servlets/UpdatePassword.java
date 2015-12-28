package com.dimeng.p2p.front.servlets;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.http.servlet.annotation.PagingServlet;
import com.dimeng.framework.http.session.Session;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.ParameterException;
import com.dimeng.p2p.account.front.service.UserManage;
import com.dimeng.p2p.variables.defines.URLVariable;
import com.dimeng.util.StringHelper;

@PagingServlet(itemServlet = UpdatePassword.class)
public class UpdatePassword extends AbstractFrontServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		
		try {
			UserManage manage = serviceSession.getService(UserManage.class);
			String passwordOne = request.getParameter("passwordOne");
			String passwordTwo = request.getParameter("passwordTwo");
			if(StringHelper.isEmpty(passwordTwo)){
				throw  new ParameterException("密码不能为空");
			}
			if(!passwordTwo.equals(passwordOne)){
				throw  new ParameterException("两次输入密码不一致");
			}
			manage.updatePassword(passwordTwo);
			Session session = serviceSession.getSession();
			if (session != null) {
				session.invalidate(request, response);
			}
			sendRedirect(request, response, getResourceProvider().getResource(ConfigureProvider.class)
					.format(URLVariable.LOGIN));
			
		} catch (Exception e) {
			prompt(request, response, PromptLevel.ERROR, e.getMessage());
			sendRedirect(request, response, getController().getURI(request, Index.class));
		}
		
	}
	
	
	
	
	
}
