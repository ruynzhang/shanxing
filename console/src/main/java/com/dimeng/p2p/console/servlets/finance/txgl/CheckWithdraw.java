package com.dimeng.p2p.console.servlets.finance.txgl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.resource.ResourceProvider;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.LogicalException;
import com.dimeng.framework.service.exception.ParameterException;
import com.dimeng.p2p.S61.enums.T6130_F09;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.p2p.escrow.huichao.function.model.ResultVo;
import com.dimeng.p2p.escrow.huichao.function.model.TransferDataModel;
import com.dimeng.p2p.escrow.huichao.function.model.TransferModel;
import com.dimeng.p2p.escrow.huichao.function.util.FunctionClientUtil;
import com.dimeng.p2p.escrow.huichao.service.WithdrawManage;
import com.dimeng.p2p.modules.account.console.service.UserWithdrawalsManage;
import com.dimeng.p2p.modules.account.console.service.entity.UserWithdrawals;
import com.dimeng.p2p.order.WithdrawExecutor;
import com.dimeng.p2p.variables.defines.SystemVariable;
import com.dimeng.util.parser.BooleanParser;
import com.dimeng.util.parser.EnumParser;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_FINANCE_CHECKTXGL", name = "提现管理审核")
public class CheckWithdraw extends AbstractFinanceServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		UserWithdrawalsManage extraction = serviceSession
				.getService(UserWithdrawalsManage.class);
		int id = IntegerParser.parse(request.getParameter("id"));
		UserWithdrawals txglRecord = extraction.get(id);
		request.setAttribute("txglRecord", txglRecord);
		super.processGet(request, response, serviceSession);
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			final HttpServletResponse response,
			final ServiceSession serviceSession) throws Throwable {
		UserWithdrawalsManage extraction = serviceSession
				.getService(UserWithdrawalsManage.class);
		int id = IntegerParser.parse(request.getParameter("id"));
		String check_reason = request.getParameter("check_reason");
		T6130_F09 status = EnumParser.parse(T6130_F09.class,
				request.getParameter("status"));
		try {
			ResourceProvider resourceProvider = getResourceProvider();
			ConfigureProvider configureProvider = resourceProvider
					.getResource(ConfigureProvider.class);
			Boolean tg = BooleanParser.parseObject(configureProvider
					.getProperty(SystemVariable.SFZJTG));
			int[] orderIds = null;
			WithdrawManage withdrawManage = serviceSession
					.getService(WithdrawManage.class);
			if (!tg) {
				orderIds = extraction.fk(status == T6130_F09.YFK, check_reason,
						id);
			} else {
				orderIds = withdrawManage.orderIds(status, check_reason, id);
			}
			serviceSession.commit();
			if (orderIds != null && orderIds.length > 0) {
				WithdrawExecutor executor = resourceProvider
						.getResource(WithdrawExecutor.class);
				if(status == T6130_F09.YFK){
					for (int orderId : orderIds) {
						executor.submit(orderId, null);
						if (!tg) {
							executor.confirm(orderId, null);
						}
						else{
							try{
								TransferModel transferModel=withdrawManage.getTransferModel(orderId);
								TransferDataModel transferDataModel=new TransferDataModel(transferModel,resourceProvider);
								ResultVo result=FunctionClientUtil.sendTransfer(transferDataModel,this.getResourceProvider());
								if(result.getErrorNo()>=0){
									executor.confirm(orderId, null);
								}else{
									//返回失败的编码 提现失败
									withdrawManage.trade(id);
									serviceSession.commit();
									this.log(result.getErrorMessage());
									throw new ParameterException(result.getErrorMessage());
								}
							}catch(Throwable ex){
								//发送过程中失败了,标致提现失败！
								withdrawManage.trade(id);
								serviceSession.commit();
								this.log(ex.getMessage());
								throw new ParameterException(ex.getMessage());
							}
						}
					}
				}else{
					//withdrawManage.cancle(id);
					withdrawManage.trade(id);
					serviceSession.commit();
				}
			}
			if (status == T6130_F09.YFK) {
				sendRedirect(request, response,
						getController().getURI(request, Txcg.class));
				return;
			} else {
				sendRedirect(request, response,
						getController().getURI(request, Txsb.class));
				return;
			}
		} catch (Throwable throwable) {
			throwable.printStackTrace();
			if (throwable instanceof ParameterException
					|| throwable instanceof LogicalException) {
				getController().prompt(request, response, PromptLevel.WARRING,
						throwable.getMessage());
				processGet(request, response, serviceSession);
			} else {
				super.onThrowable(request, response, throwable);
			}
		}
	}
}
