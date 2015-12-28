package com.dimeng.p2p.console.servlets.system.skin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.system.AbstractSystemServlet;
import com.dimeng.p2p.modules.systematic.console.service.SkinManage;
import com.dimeng.p2p.modules.systematic.console.service.entity.Skin;

@Right(id = "P2P_C_SYS_SKINLIST", isMenu=true,name = "前台皮肤设置列表")
public class SkinList extends AbstractSystemServlet {
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
		SkinManage skinManage = serviceSession.getService(SkinManage.class);
		Skin[] skins = skinManage.getAll();
		request.setAttribute("skins", skins);
		forwardView(request, response, getClass());
	}
}
