package com.dimeng.p2p.console.servlets.finance.yccl;

import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.Controller;
import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S65.entities.T6501;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.util.parser.DateParser;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_FINANCE_HKTH", isMenu = true, name = "解冻")
public class Jdth extends AbstractFinanceServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		int ordId = IntegerParser.parse(request.getParameter("ordId"));
//		UnFreezeManage manage = serviceSession.getService(UnFreezeManage.class);
//		final String trxId = manage.getTrxId(ordId);
//		final T6501 t6501 = manage.addUnfreezeOrder(ordId);
//		UnFreezeEntity entity = manage.sendUnFreeze(new UnFreezeCond() {
//
//			@Override
//			public String trxId() {
//				return trxId;
//			}
//
//			@Override
//			public String retUrl() {
//				return null;
//			}
//
//			@Override
//			public String ordId() {
//				return String.valueOf(t6501.F01);
//			}
//
//			@Override
//			public String ordDate() {
//				return DateParser.format(new Date(), "yyyyMMdd");
//			}
//		});
		Controller controller = getController();
//		controller.prompt(request, response, PromptLevel.INFO, entity.respDesc);
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
