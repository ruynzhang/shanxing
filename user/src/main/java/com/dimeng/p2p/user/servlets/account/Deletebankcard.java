package com.dimeng.p2p.user.servlets.account;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S61.enums.T6114_F08;
import com.dimeng.p2p.account.user.service.BankCardManage;
import com.dimeng.util.StringHelper;
import com.dimeng.util.parser.IntegerParser;

public class Deletebankcard extends AbstractAccountServlet{
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, final ServiceSession serviceSession)
			throws Throwable {
		BankCardManage  bankCardManage = serviceSession.getService(BankCardManage.class);
		String id = request.getParameter("value");
		if(StringHelper.isEmpty(id)){
			return;
		}
		bankCardManage.delete(IntegerParser.parse(id), T6114_F08.TY.name());
	}
}
