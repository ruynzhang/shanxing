package com.dimeng.p2p.console.servlets.account.jgxx.lxxx;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S61.entities.T6164;
import com.dimeng.p2p.console.servlets.account.AbstractAccountServlet;
import com.dimeng.p2p.console.servlets.account.jgxx.ccxx.ListCcxx;
import com.dimeng.p2p.modules.account.console.service.QyManage;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_ACCOUNT_JGXX_UPDATELXXX",  name = "机构联系信息修改")
public class UpdateLxxx extends AbstractAccountServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		QyManage manage = serviceSession.getService(QyManage.class);
		int id = IntegerParser.parse(request.getParameter("id"));
		request.setAttribute("info", manage.getLxxx(id));
		forwardView(request, response, getClass());
	}

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		QyManage manage = serviceSession.getService(QyManage.class);
		int id = IntegerParser.parse(request.getParameter("id"));
		T6164 entity = new T6164();
		entity.parse(request);
		entity.F02 = IntegerParser.parse(request.getParameter("xian"));
		manage.updateLxxx(entity);
		sendRedirect(request, response, getController().getURI(request, ListCcxx.class)+"?id="+id);
	}
	
	
}
