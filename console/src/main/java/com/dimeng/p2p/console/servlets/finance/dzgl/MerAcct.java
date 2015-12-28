package com.dimeng.p2p.console.servlets.finance.dzgl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;

@Right(id = "P2P_C_FINANCE_SHZZHXXCX", isMenu = true, name = "商户子账户信息")
public class MerAcct extends AbstractDzglServlet {

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
//		MerAcctQueryManage manage = serviceSession.getService(MerAcctQueryManage.class);
//		MerAcctQueryEntity entity = manage.query();
//		request.setAttribute("entity", entity);
		forward(request, response,
				getController().getViewURI(request, getClass()));
	}

}
