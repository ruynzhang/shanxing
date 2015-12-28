package com.dimeng.p2p.front.servlets;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.service.TasteActivityManage;
import com.dimeng.p2p.utlis.JfUtil;
import com.dimeng.p2p.utlis.MerCached;

public class IsLogin extends AbstractMobileServicer {
	
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		String name=request.getParameter("userName");
		if(!JfUtil.isNull(name)){
			TasteActivityManage manage=serviceSession.getService(TasteActivityManage.class);
			String userName=manage.getUserName(name);
			Object obj=MerCached.client.get(MerCached.AC_PREFIX+userName);
			String activityCode=obj==null?"":obj.toString();
			if(activityCode.equals(JfUtil.properties.getProperty("activityCode"))){
				response.getWriter().print("0");
			}else{
				response.getWriter().print("1");
			}
		}
	}
	
	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		
		sendRedirect(request, response,
				getController().getViewURI(request, getClass()));
	}
}
