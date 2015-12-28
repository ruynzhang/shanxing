package com.dimeng.p2p.pay.servlets.mobile;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.http.servlet.Controller;
import com.dimeng.framework.http.session.authentication.AuthenticationException;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.resource.ResourceProvider;
import com.dimeng.p2p.pay.servlets.AbstractPayServlet;
import com.dimeng.p2p.variables.defines.URLVariable;

public abstract class AbstractMobileServlet extends AbstractPayServlet {

	private static final long serialVersionUID = 1L;
	
	protected final static Log log = LogFactory.getLog(AbstractMobileServlet.class);
	
	@Override
	protected boolean mustAuthenticated() {
		return false;
	}
	
	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		ResourceProvider resourceProvider = getResourceProvider();
		getController().prompt(request, response, PromptLevel.ERROR,
				throwable.getMessage());
		if (throwable instanceof AuthenticationException) {
			Controller controller = getController();
			controller.redirectLogin(request, response,
					resourceProvider.getResource(ConfigureProvider.class)
							.format(URLVariable.MWEB_LOGINWEB));
		} else {
			resourceProvider.log(throwable);
			forwardView(request, response, getClass());
		}
	}

}
