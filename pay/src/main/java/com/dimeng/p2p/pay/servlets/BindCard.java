package com.dimeng.p2p.pay.servlets;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;

//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import com.dimeng.framework.config.ConfigureProvider;
//import com.dimeng.framework.service.ServiceSession;
//import com.dimeng.p2p.S61.entities.T6119;
//import com.dimeng.p2p.escrow.huifu.service.BankCardManage;
//import com.dimeng.p2p.escrow.huifu.service.UserManage;
//import com.dimeng.p2p.variables.defines.SystemVariable;
//import com.dimeng.p2p.variables.defines.URLVariable;
//import com.dimeng.util.parser.IntegerParser;
//
///**
// * 绑卡
// */
public class BindCard extends AbstractPayServlet {
//
//	private static final long serialVersionUID = 1L;
//
	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
//		BankCardManage manage = serviceSession.getService(BankCardManage.class);
//		int count = manage.getBankCardCount();
//		ConfigureProvider configurableProvider = getConfigureProvider();
//		if (count >= IntegerParser.parse(configurableProvider
//				.getProperty(SystemVariable.MAX_BANKCARD_COUNT))) {
//			sendRedirect(request, response,
//					configurableProvider.format(URLVariable.CARD_MANAGE));
//		}
//		UserManage userManage = serviceSession.getService(UserManage.class);
//		final T6119 t6119 = userManage.selectT6119();
//		String location = manage.createBindCardUrI(t6119.F03);
//		sendRedirect(request, response, location);
	}

}
