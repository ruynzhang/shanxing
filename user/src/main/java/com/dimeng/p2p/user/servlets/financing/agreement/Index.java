package com.dimeng.p2p.user.servlets.financing.agreement;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S62.enums.T6230_F11;
import com.dimeng.p2p.modules.bid.user.service.BidManage;
import com.dimeng.p2p.modules.bid.user.service.entity.Bdxq;
import com.dimeng.util.parser.IntegerParser;

public class Index extends AbastractAgreementServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		int creditId = IntegerParser.parse(request.getParameter("id"));
		BidManage bidManage =	serviceSession.getService(BidManage.class);
		Bdxq bdxq = bidManage.get(creditId);
		if(bdxq.F11 == T6230_F11.S){
			forward(request, response, getController().getViewURI(request, Xydb.class));
		}else{
			forward(request, response, getController().getViewURI(request, Xyb.class));
		}
		

	}
	
	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}
}
