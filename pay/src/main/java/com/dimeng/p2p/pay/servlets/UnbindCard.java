package com.dimeng.p2p.pay.servlets;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;

public class UnbindCard extends AbstractPayServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
//		int id = IntegerParser.parse(request.getParameter("id"));
//		BankCardManage manage = serviceSession.getService(BankCardManage.class);
//		String userCustId = manage.getUserCustId();
//		String cardId = manage.getBankCard(id);
//		if (StringHelper.isEmpty(cardId)) {
//			PrintWriter writer = response.getWriter();
//			writer.print("无此银行卡绑定");
//			writer.flush();
//			writer.close();
//		}
//		UnbindCardEntity entity = manage.sendUnbindCard(userCustId, cardId);
//		if (entity != null && "000".equals(entity.respCode)) {
//			String location = getConfigureProvider().format(
//					URLVariable.CARD_MANAGE);
//			manage.unbindCard(entity);
//			sendRedirect(request, response, location);
//		}else if(entity != null){
//			getController().prompt(request, response, PromptLevel.ERROR, entity.respDesc);
//			String location = getConfigureProvider().format(URLVariable.CARD_MANAGE);
//			sendRedirect(request, response, location);
//		}
	}

}
