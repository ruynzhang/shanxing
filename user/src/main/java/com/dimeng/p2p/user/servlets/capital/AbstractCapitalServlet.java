package com.dimeng.p2p.user.servlets.capital;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.p2p.user.servlets.AbstractUserServlet;

/**
 * 资金模块抽象Servlet.
 * 
 */
public abstract class AbstractCapitalServlet extends AbstractUserServlet {

	private static final long serialVersionUID = 1L;
	
	protected ConfigureProvider getConfigureProvider() {
		return getResourceProvider().getResource(ConfigureProvider.class);
	}

}
