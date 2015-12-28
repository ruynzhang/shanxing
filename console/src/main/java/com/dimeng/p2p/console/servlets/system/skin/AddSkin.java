package com.dimeng.p2p.console.servlets.system.skin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.system.AbstractSystemServlet;
import com.dimeng.p2p.modules.systematic.console.service.SkinManage;

@Right(id = "P2P_C_SYS_ADDSKIN", name = "前台皮肤设置添加")
public class AddSkin extends AbstractSystemServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		SkinManage skinManage = serviceSession.getService(SkinManage.class);
		String name = request.getParameter("name");
		String location = request.getParameter("location");
		String pic = request.getParameter("pic");
		skinManage.add(name, location, pic);
		sendRedirect(request, response,
				getController().getURI(request, SkinList.class));
	}
}
