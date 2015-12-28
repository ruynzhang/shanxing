package com.dimeng.p2p.console.servlets.finance.fksh;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.resource.ResourceProvider;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.LogicalException;
import com.dimeng.framework.service.exception.ParameterException;
import com.dimeng.p2p.S61.entities.T6110;
import com.dimeng.p2p.S62.entities.T6230;
import com.dimeng.p2p.S62.entities.T6238;
import com.dimeng.p2p.S65.entities.T6505;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.p2p.escrow.huichao.function.model.ResultVo;
import com.dimeng.p2p.escrow.huichao.function.model.TranDataModel;
import com.dimeng.p2p.escrow.huichao.function.model.TranModel;
import com.dimeng.p2p.escrow.huichao.function.util.FunctionClientUtil;
import com.dimeng.p2p.escrow.huichao.service.FKOrder;
import com.dimeng.p2p.escrow.huichao.service.TenderConfirmManage;
import com.dimeng.p2p.escrow.huichao.service.TenderTybManage;
import com.dimeng.p2p.escrow.huichao.service.UserManger;
import com.dimeng.p2p.order.TenderConfirmExecutor;
import com.dimeng.p2p.variables.defines.HuiChaoPayVariavle;
import com.dimeng.p2p.variables.defines.SystemVariable;
import com.dimeng.util.parser.BooleanParser;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_FINANCE_LOANEXPEMONEY", name = "体验金放款审核")
public class LoanExpemoney extends AbstractFinanceServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}

	/* (non-Javadoc)
	 * @see com.dimeng.p2p.console.servlets.AbstractConsoleServlet#processPost(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse, com.dimeng.framework.service.ServiceSession)
	 */
	@Override
	protected void processPost(final HttpServletRequest request,
			final HttpServletResponse response,
			final ServiceSession serviceSession) throws Throwable {
		try {
			TenderTybManage tendertybManage = serviceSession
					.getService(TenderTybManage.class);
			// 标ID
			int id = IntegerParser.parse(request.getParameter("id"));
			// 计算投资记录表的状态和收益
			int[] orderIds= tendertybManage.confirmtyb(id);
			serviceSession.commit();
			
			if(orderIds.length>0){
			  this.prompt(request, response, PromptLevel.WARRING, "放款成功");
			}else{
			  this.prompt(request, response, PromptLevel.WARRING, "该标的没有投资记录,已流标");
			}
			sendRedirect(request, response,
					getController().getURI(request, TybshList.class));
		} catch (Throwable throwable) {
			if (throwable instanceof LogicalException
					|| throwable instanceof ParameterException) {
				getController().prompt(request, response, PromptLevel.WARRING,
						throwable.getMessage());
				sendRedirect(request, response,
						getController().getURI(request, TybshList.class));
			} else {
				super.onThrowable(request, response, throwable);
			}
		}
	}
	
	
}
