package com.dimeng.p2p.console.servlets.finance.fksh;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.LogicalException;
import com.dimeng.framework.service.exception.ParameterException;
import com.dimeng.p2p.S62.entities.SurpriseLucre;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.p2p.escrow.huichao.function.model.ResultVo;
import com.dimeng.p2p.escrow.huichao.function.model.TranDataModel;
import com.dimeng.p2p.escrow.huichao.function.model.TranModel;
import com.dimeng.p2p.escrow.huichao.function.util.FunctionClientUtil;
import com.dimeng.p2p.escrow.huichao.service.SurpriseManage;
import com.dimeng.p2p.variables.defines.HuiChaoPayVariavle;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_FINANCE_SURPRISELOAN", name = "放款审核发放惊喜奖")
public class SurpriseLoan extends AbstractFinanceServlet{

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
			ConfigureProvider configureProvider = getResourceProvider()
					.getResource(ConfigureProvider.class);
			//汇朝商户号
			String accountNumber=configureProvider.format(HuiChaoPayVariavle.NUMBER_ID);
			TranDataModel tranDataModel = new TranDataModel(accountNumber, bid + "");
			List<TranModel> tranModelList = new ArrayList<>();
			List<SurpriseLucre> surpriseLucreList = new ArrayList<>();
			synchronized (SurpriseLoan.class) {
				//计算收益
				surpriseManage.operationSurpriseLucre(bid, tranModelList, surpriseLucreList);
				serviceSession.commit();
				//转账
				tranDataModel.setTranList(tranModelList);
				System.out.println("放款审核惊喜奖...tranDataModel..." + tranDataModel.createTranXML());
				//请求第三方支付进行交易
				ResultVo result = FunctionClientUtil.sendTrade(tranDataModel,this.getResourceProvider());
				if(result.getErrorNo() >= 0){
					//添加平台记录
					surpriseManage.confirm(bid, surpriseLucreList);
					this.prompt(request, response, PromptLevel.WARRING, "惊喜奖放款成功");
				}else{
					System.out.println("放款审核惊喜奖_第三方返回,出错了...." + result.toString());
					this.prompt(request, response, PromptLevel.WARRING, "惊喜奖放款失败" + result.getErrorMessage());
				}
			}
			sendRedirect(request, response,
					getController().getURI(request, FkshList.class));
		} catch (Throwable throwable) {
			if (throwable instanceof LogicalException
					|| throwable instanceof ParameterException) {
				getController().prompt(request, response, PromptLevel.WARRING,
						throwable.getMessage());
				sendRedirect(request, response,
						getController().getURI(request, FkshList.class));
			} else {
				super.onThrowable(request, response, throwable);
			}
		}
	}
}
