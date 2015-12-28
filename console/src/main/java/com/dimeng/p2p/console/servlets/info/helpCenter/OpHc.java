package com.dimeng.p2p.console.servlets.info.helpCenter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.info.AbstractInformationServlet;
import com.dimeng.p2p.modules.base.console.service.HelpCenterManage;
import com.dimeng.p2p.modules.base.console.service.entity.HelpCenterVO;
@Right(id = "P2P_C_INFO_HELPCENTER_OPHC", name = "操作帮助中心")
public class OpHc extends AbstractInformationServlet {
	
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		String id=request.getParameter("id");
		HelpCenterManage manage=serviceSession.getService(HelpCenterManage.class);
		if(null!=id && !id.isEmpty()){
			HelpCenterVO vo=manage.getById(Integer.parseInt(id));
			request.setAttribute("vo", vo);
		}
		request.setAttribute("map", manage.getSublevel(0));
		forwardView(request, response, getClass());
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		HelpCenterManage manage=serviceSession.getService(HelpCenterManage.class);
		HelpCenterVO vo=new HelpCenterVO();
		vo.parse(request);
		if (vo.id>0) {
			manage.update(vo);
		}else{
			manage.add(vo);
		}
		sendRedirect(request, response,getController().getURI(request, HcList.class));
	}
}
