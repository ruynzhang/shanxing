package com.dimeng.p2p.console.servlets.finance.agreement;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.common.enums.CreditType;
import com.dimeng.p2p.console.servlets.AbstractConsoleServlet;
import com.dimeng.p2p.modules.finance.console.service.AgreementManage;
import com.dimeng.util.parser.IntegerParser;


public class Index extends AbstractConsoleServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		int creditId = IntegerParser.parse(request.getParameter("id"));
		AgreementManage manage = serviceSession.getService(AgreementManage.class);
		CreditType creditType = manage.getCreditType(creditId);
		if(creditType == null){
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
		}
		if(creditType == CreditType.SYD || creditType == CreditType.XJD){
			forwardView(request, response, Xyb.class);
		}else if(creditType == CreditType.XYDB){
			forwardView(request, response, Xydb.class);
		}else{
			forwardView(request, response, Sdrz.class);
		}
	}

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}
}
