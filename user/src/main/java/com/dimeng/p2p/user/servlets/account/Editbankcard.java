package com.dimeng.p2p.user.servlets.account;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.account.user.service.BankCardManage;
import com.dimeng.p2p.account.user.service.entity.BankCardQuery;
import com.dimeng.p2p.common.enums.BankCardStatus;
import com.dimeng.util.parser.IntegerParser;

public class Editbankcard extends AbstractAccountServlet{
	private static final long serialVersionUID = 1L;
	
	
	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, final ServiceSession serviceSession)
			throws Throwable {
		BankCardManage  bankCardManage = serviceSession.getService(BankCardManage.class);
		
		BankCardQuery query = new BankCardQuery() {
			@Override
			public String getSubbranch() {
				return request.getParameter("subbranch");
			}
			
			@Override
			public String getStatus() {
				return BankCardStatus.QY.name();
			}
			
			@Override
			public String getCity() {
				return request.getParameter("xian");
			}
			
			@Override
			public String getBankNumber() {
				return null;
			}
			
			@Override
			public int getBankId() {
				return IntegerParser.parse(request.getParameter("bankname"));
			}
			
			@Override
			public int getAcount() {
				return serviceSession.getSession().getAccountId();
			}
		};
		//启用银行卡
		int id = IntegerParser.parse(request.getParameter("id"));
		bankCardManage.update(id, query);
		request.setAttribute("close", "close");
		getController().forwardView(request, response, Editbankcard.class);
	}
}
