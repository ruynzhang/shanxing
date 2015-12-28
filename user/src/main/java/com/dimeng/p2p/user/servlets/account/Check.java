package com.dimeng.p2p.user.servlets.account;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.account.user.service.SafetyManage;

public class Check extends AbstractAccountServlet{
	private static final long serialVersionUID = 1L;
	/**
	 * 检查电话邮箱是否存在
	 */
	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, final ServiceSession serviceSession)
			throws Throwable {
		SafetyManage safetyManage = serviceSession.getService(SafetyManage.class);
		PrintWriter out=response.getWriter();
		String value = request.getParameter("value");
		//校验对象
		String evenString = request.getParameter("evencheck");
				
		if("emil".equals(evenString)){
			if(safetyManage.isEmil(value)){
				out.write("04");
				return;
			}
		}else if("phone".equals(evenString)){
			if(safetyManage.isPhone(value)){
				out.write("04");
				return;
			}
		}
	}
	
}
