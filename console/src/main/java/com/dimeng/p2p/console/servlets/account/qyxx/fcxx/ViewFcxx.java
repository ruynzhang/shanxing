package com.dimeng.p2p.console.servlets.account.qyxx.fcxx;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S61.entities.T6112;
import com.dimeng.p2p.console.servlets.account.AbstractAccountServlet;
import com.dimeng.p2p.modules.account.console.service.QyManage;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_ACCOUNT_QYXX_VIEWFCXX", name = "查看企业房产")
public class ViewFcxx extends AbstractAccountServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		QyManage manage = serviceSession.getService(QyManage.class);
		T6112 entity = manage.getFcxx(IntegerParser.parse(request.getParameter("id")));
		request.setAttribute("info", entity);
		forwardView(request, response, getClass());
	}


	
}
