package com.dimeng.p2p.user.servlets.credit;

import java.math.BigDecimal;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.p2p.user.servlets.AbstractUserServlet;
import com.dimeng.util.StringHelper;

/**
 * 贷款模块抽象Servlet.
 * 
 */
public abstract class AbstractCreditServlet extends AbstractUserServlet {

	private static final long serialVersionUID = 1L;

	public BigDecimal convertToString(String amount) {
		BigDecimal bigDecimal = new BigDecimal(0.00);
		if (StringHelper.isEmpty(amount)) {
			return bigDecimal;
		}
		return bigDecimal = new BigDecimal(amount);
	}

	protected ConfigureProvider getConfigureProvider() {
		return getResourceProvider().getResource(ConfigureProvider.class);
	}
}
