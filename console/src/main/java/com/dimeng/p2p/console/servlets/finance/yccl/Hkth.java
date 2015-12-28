package com.dimeng.p2p.console.servlets.finance.yccl;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.Controller;
import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.p2p.modules.bid.console.service.BidManage;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_FINANCE_HKTH", isMenu = true, name = "还款")
public class Hkth extends AbstractFinanceServlet {

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		int ordId = IntegerParser.parse(request.getParameter("ordId"));
		BidManage manage = serviceSession.getService(BidManage.class);
//		PaymentEntity entity = manage.repayment(ordId);
		Controller controller = getController();
//		controller.prompt(request, response, PromptLevel.INFO,
//				entity.respDesc);
		String location = controller.getViewURI(request, getClass());
		sendRedirect(request, response, location);
	}
	
	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		Controller controller = getController();
		controller.prompt(request, response, PromptLevel.INFO,
				throwable.getMessage());
		String location = controller.getViewURI(request, getClass());
		sendRedirect(request, response, location);
	}
	
}
