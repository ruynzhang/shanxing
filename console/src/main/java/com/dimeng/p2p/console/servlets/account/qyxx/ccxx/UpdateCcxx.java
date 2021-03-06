package com.dimeng.p2p.console.servlets.account.qyxx.ccxx;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S61.entities.T6113;
import com.dimeng.p2p.console.servlets.account.AbstractAccountServlet;
import com.dimeng.p2p.modules.account.console.service.QyManage;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_ACCOUNT_QYXX_UPDATECCXX", name = "修改企业车产信息")
public class UpdateCcxx extends AbstractAccountServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		QyManage manage = serviceSession.getService(QyManage.class);
		int id = IntegerParser.parse(request.getParameter("id"));
		T6113 info = manage.getCcxx(id);
		request.setAttribute("info", info);
		forwardView(request, response, getClass());
	}

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		QyManage manage = serviceSession.getService(QyManage.class);
		T6113 entity = new T6113();
		entity.parse(request);
		manage.updateCcxx(entity);
		serviceSession.commit();
		int id = IntegerParser.parse(request.getParameter("id"));
		sendRedirect(request, response, getController().getURI(request,ListCcxx.class)+"?id="+id+"&paging.current="+request.getParameter("paging.current"));
	}
	
}
