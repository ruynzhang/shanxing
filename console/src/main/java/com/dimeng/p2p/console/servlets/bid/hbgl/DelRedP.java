package com.dimeng.p2p.console.servlets.bid.hbgl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.service.RedPacketManage;
import com.dimeng.p2p.utlis.StrUtil;

public class DelRedP extends AbstractBidServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			final HttpServletResponse response,
			final ServiceSession serviceSession) throws Throwable {
		RedPacketManage manage = serviceSession.getService(RedPacketManage.class);
		String id=request.getParameter("id");
		try {
			manage.delete(StrUtil.Str2Int(id));
			getController().prompt(request, response, PromptLevel.WARRING,"保存成功");
		} catch (Exception e) {
			prompt(request, response, PromptLevel.ERROR, e.getMessage());
		}
		sendRedirect(request, response,getController().getURI(request, RedpList.class));
	}
}
