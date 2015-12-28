package com.dimeng.p2p.console.servlets.finance.fksh;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S62.entities.SurpriseLucre;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.p2p.escrow.huichao.function.model.TranModel;
import com.dimeng.p2p.escrow.huichao.service.SurpriseManage;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_FINANCE_VIEWSURPRISE", name = "查看惊喜奖")
public class ViewSurprise extends AbstractFinanceServlet{

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		this.processPost(request, response, serviceSession);
	}
	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		try{
			//获取标id
			int bid = IntegerParser.parse(request.getParameter("id"));
			SurpriseManage surpriseManage = serviceSession.getService(SurpriseManage.class);
			List<TranModel> tranModelList = new ArrayList<>();
			List<SurpriseLucre> surpriseLucreList = new ArrayList<>();
			//计算收益
			surpriseManage.operationSurpriseLucre(bid, tranModelList, surpriseLucreList);
			serviceSession.commit();
			request.setAttribute("list", surpriseLucreList);
			forwardView(request, response, getClass());
		} catch (Throwable throwable) {
			getController().prompt(request, response, PromptLevel.WARRING,
					throwable.getMessage());
			sendRedirect(request, response,
					getController().getURI(request, FkshList.class));
		}
	}
}
