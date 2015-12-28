package com.dimeng.p2p.console.servlets.system.skin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.system.AbstractSystemServlet;
import com.dimeng.p2p.modules.systematic.console.service.SkinManage;
import com.dimeng.p2p.modules.systematic.console.service.entity.Skin;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_SYS_UPDATESKIN", name = "前台皮肤设置修改")
public class UpdateSkin extends AbstractSystemServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		SkinManage skinManage = serviceSession.getService(SkinManage.class);
		int id = IntegerParser.parse(request.getParameter("id"));
		Skin skin = skinManage.get(id);
		request.setAttribute("skin", skin);
		forwardView(request, response,this.getClass());
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		SkinManage skinManage = serviceSession.getService(SkinManage.class);
		int id = IntegerParser.parse(request.getParameter("id"));
		String name = request.getParameter("name");
		String location = request.getParameter("location");
		String pic = request.getParameter("pic");
		skinManage.update(id, name, location, pic);
		sendRedirect(request, response,
				getController().getURI(request, SkinList.class));
	}
}
