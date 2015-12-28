package com.dimeng.p2p.console.servlets.account.qyxx;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.account.AbstractAccountServlet;
import com.dimeng.p2p.modules.account.console.service.EnterpriseManage;
import com.dimeng.p2p.modules.account.console.service.entity.AT6161;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_ACCOUNT_UPDATEQY", name = "修改企业账户信息")
public class UpdateQy extends AbstractAccountServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		EnterpriseManage manager = serviceSession.getService(EnterpriseManage.class);
		
		int userId = IntegerParser.parse(request.getParameter("userId"));
		AT6161 enterprise = manager.getEnterprise(userId);
		if (enterprise == null) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			return;
		}
		request.setAttribute("enterprise", enterprise);
		forwardView(request, response, getClass());
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			final HttpServletResponse response,
			final ServiceSession serviceSession) throws Throwable {
		EnterpriseManage manager = serviceSession.getService(EnterpriseManage.class);
		
		AT6161 t6161 = new AT6161();
		t6161.F01 = IntegerParser.parse(request.getParameter("userId"));
		//t6161.F10 = IntegerParser.parse(request.getParameter("usercount"));
		t6161.F04 =request.getParameter("userName");//企业名称
		t6161.F05 =request.getParameter("userSno");//企业纳税号
		t6161.F06 =request.getParameter("userOrno");//组织机构代码
		t6161.F03 =request.getParameter("userZno");//营业执照登记注册号
		t6161.F11 =request.getParameter("userIp");//法定代表人
		t6161.F12 =request.getParameter("userCard");//法定代表人身份证号码
		t6161.F16 =request.getParameter("userMobile");//法定代表人手机号码
		
     	
		manager.updateEnterpriseBase(t6161);
		sendRedirect(request, response,
				getController().getURI(request, QyList.class));
	}


}
