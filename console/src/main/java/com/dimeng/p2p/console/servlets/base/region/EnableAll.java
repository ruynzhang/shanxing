package com.dimeng.p2p.console.servlets.base.region;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.base.AbstractBaseServlet;
import com.dimeng.p2p.modules.base.console.service.DistrictManage;

@Right(id = "P2P_C_BASE_REGION_ENABLEALL", name = "区域全部启用")
public class EnableAll extends AbstractBaseServlet {
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
		DistrictManage districtManage = serviceSession
				.getService(DistrictManage.class);
		districtManage.enableAll();
		sendRedirect(request, response,
				getController().getURI(request, RegionList.class));
	}
}
