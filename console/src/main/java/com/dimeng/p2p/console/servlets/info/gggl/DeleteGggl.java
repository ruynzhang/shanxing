package com.dimeng.p2p.console.servlets.info.gggl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.modules.base.console.service.AdvertisementManage;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_INFO_GGGL_DELETE", name = "删除广告管理")
public class DeleteGggl extends AbstractAdvertiseServlet {

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
		AdvertisementManage advertisementManage = serviceSession
				.getService(AdvertisementManage.class);
		advertisementManage.delete(IntegerParser.parseArray(request
				.getParameterValues("id")));
		sendRedirect(request, response,
				getController().getURI(request, SearchGggl.class));
	}

}
