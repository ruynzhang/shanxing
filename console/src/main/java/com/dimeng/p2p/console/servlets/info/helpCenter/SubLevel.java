package com.dimeng.p2p.console.servlets.info.helpCenter;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.info.AbstractInformationServlet;
import com.dimeng.p2p.modules.base.console.service.HelpCenterManage;
import com.dimeng.p2p.modules.base.console.service.entity.HelpCenterVO;

public class SubLevel extends AbstractInformationServlet {
	
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
		HelpCenterVO vo=new HelpCenterVO();
		vo.parse(request);
		if (vo.pid>0) {
			Map<Integer, String> mapList=manage.getSublevel(vo.pid);
			StringBuffer strBuffer=new StringBuffer();
			Object s[] = mapList.keySet().toArray();
			for(int i = 0; i < mapList.size(); i++) {
				strBuffer.append("<option value=\""+s[i]+"\">"+mapList.get(s[i])+"</option>");
			}
			response.setContentType("text/html;charset=UTF-8"); 
			response.getWriter().print(strBuffer.toString());
		}
	}
}
