package com.dimeng.p2p.console.servlets.account.grxx;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.account.AbstractAccountServlet;
import com.dimeng.p2p.modules.account.console.service.GrManage;
import com.dimeng.p2p.modules.account.console.service.entity.Attestation;
import com.dimeng.p2p.modules.account.console.service.entity.BasicInfo;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_ACCOUNT_GRVIEW", name = "查询个人账号详情")
public class ByrzView extends AbstractAccountServlet {

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
		GrManage manage = serviceSession.getService(GrManage.class);
		int userId = IntegerParser.parse(request.getParameter("userId"));
		BasicInfo basicInfo = manage.findBasicInfo(userId);
		if (basicInfo == null) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			return;
		}
		Attestation[] needAttestation = manage.needAttestation(userId);
		request.setAttribute("basicInfo", basicInfo);
		request.setAttribute("needAttestation", needAttestation);
		forwardView(request, response, getClass());
	}

}
