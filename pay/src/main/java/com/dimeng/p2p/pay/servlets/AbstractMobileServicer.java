package com.dimeng.p2p.pay.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.http.servlet.AbstractServlet;
import com.dimeng.framework.http.servlet.Controller;
import com.dimeng.framework.http.session.authentication.AuthenticationException;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.resource.ResourceProvider;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.service.TasteActivityManage;
import com.dimeng.p2p.variables.defines.URLVariable;

public class AbstractMobileServicer extends AbstractServlet {
	
	protected static Log logger = LogFactory.getLog(AbstractMobileServicer.class);
	
	private static final long serialVersionUID = 1L;
	
	@Override
	protected boolean mustAuthenticated() {
		return false;
	}

	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		logger.error(throwable);
		ResourceProvider resourceProvider = getResourceProvider();
		getController().prompt(request, response, PromptLevel.ERROR,
				throwable.getMessage());
		if (throwable instanceof AuthenticationException) {
			Controller controller = getController();
			ConfigureProvider configureProvider = resourceProvider.getResource(ConfigureProvider.class);
			controller.redirectLogin(request, response,configureProvider.format(URLVariable.MLOGIN));
		} else {
			resourceProvider.log(throwable);
			forwardView(request, response, getClass());
		}
	}

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		sendRedirect(request, response,
				getController().getViewURI(request, getClass()));
	}

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		sendRedirect(request, response,
				getController().getViewURI(request, getClass()));
	}
	
	protected ConfigureProvider getConfigureProvider() {
		return getResourceProvider().getResource(ConfigureProvider.class);
	}
	
	protected void sendMsg(ServiceSession serviceSession,int userId,String content) throws Throwable {
		TasteActivityManage manage=serviceSession.getService(TasteActivityManage.class);
		manage.sendLetter(userId, "体验金", content);
	}
}
