package com.dimeng.p2p.console.servlets.info.helpCenter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.info.AbstractInformationServlet;
import com.dimeng.p2p.modules.base.console.service.HelpCenterManage;

@Right(id = "P2P_C_INFO_HELPCENTER_DELHC", name = "删除帮助中心数据")
public class DelHc extends AbstractInformationServlet {
	
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		HelpCenterManage manage=serviceSession.getService(HelpCenterManage.class);
		String id=request.getParameter("id");
		if(null!=id && !id.isEmpty()){
			manage.delete(Integer.parseInt(id));
		}
		sendRedirect(request, response,getController().getURI(request, HcList.class));
	}
}