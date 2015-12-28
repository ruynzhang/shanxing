package com.dimeng.p2p.console.servlets.finance.trade;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.resource.ResourceProvider;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.p2p.modules.account.console.service.TradeManage;
import com.dimeng.p2p.modules.account.console.service.entity.TradeVo;

public class UpdTrade extends AbstractFinanceServlet {
	private static final long serialVersionUID = 1L;

	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}

	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		ResourceProvider resourceProvider = getResourceProvider();
		TradeManage manage = (TradeManage) serviceSession.getService(TradeManage.class);
		TradeVo vo = new TradeVo();
		vo.parse(request);//设置界面传来的参数
		try {
			manage.opTrade(resourceProvider,vo);
			prompt(request, response, PromptLevel.ERROR, "转账成功");
		} catch (Throwable e) {
			prompt(request, response, PromptLevel.ERROR, e.getMessage());
		}
		//返回列表界面
		sendRedirect(request, response,getController().getURI(request, Trade.class));
	}

}
