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
import com.dimeng.p2p.escrow.huichao.service.UserManger;
import com.dimeng.p2p.order.TenderConfirmExecutor;
import com.dimeng.p2p.service.RedPacketManage;
import com.dimeng.p2p.utlis.JfResource;
import com.dimeng.p2p.variables.defines.HuiChaoPayVariavle;
import com.dimeng.p2p.variables.defines.SystemVariable;
import com.dimeng.util.parser.BooleanParser;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_FINANCE_LOAN", name = "放款审核放款")
public class Loan extends AbstractFinanceServlet {
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
			TenderConfirmManage tenderConfirmManage = serviceSession
					.getService(TenderConfirmManage.class);
			
			RedPacketManage redPacketManage = serviceSession.getService(RedPacketManage.class);
			// 标ID
			int id = IntegerParser.parse(request.getParameter("id"));
			// 投标记录ID列表, t6250
			int[] orderIds = tenderConfirmManage.confirm(id);
			serviceSession.commit();
			ResourceProvider resourceProvider = getResourceProvider();
			ConfigureProvider configureProvider = resourceProvider
					.getResource(ConfigureProvider.class);
			Boolean tg = BooleanParser.parseObject(configureProvider
					.getProperty(SystemVariable.SFZJTG));
			TenderConfirmExecutor executor = getResourceProvider()
					.getResource(TenderConfirmExecutor.class);
			String accountNumber=configureProvider.format(HuiChaoPayVariavle.NUMBER_ID);
			String key=configureProvider.format(HuiChaoPayVariavle.MERCHANTKEY);
			TranDataModel tranDataModel=new TranDataModel(accountNumber,id+"");
			List<TranModel> tranModelList=new ArrayList<TranModel>();
			int count=0;
			FKOrder fkOrder=serviceSession.getService(FKOrder.class);
			
			if (orderIds != null) {
				for (int orderId : orderIds) {
					executor.submit(orderId, null);
					if (!tg) {
						executor.confirm(orderId, null);
					}else{
						UserManger userManger= serviceSession.getService(UserManger.class);
						//放款订单
						T6505 t6505=fkOrder.selectT6505(orderId);
						String outTradeNo=userManger.getOutTradeNo(0, t6505.F01);
						// 查询标信息
						T6230 t6230 = fkOrder.selectT6230(t6505.F03);
						T6110 t6110_t=userManger.selectT6110(t6505.F02, false);
						T6110 t6110_j=userManger.selectT6110(t6230.F02, false);
						
						TranModel tranModel=new TranModel(outTradeNo, t6505.F05.doubleValue(), t6110_j.F02,t6110_t.F02,accountNumber,key);
						tranModelList.add(tranModel);
//						if (BooleanParser.parse(configureProvider
//								.getProperty(SystemVariable.ACCOUNT_SFTG))) {
							//推广奖励
//							TranModel feeTranModel=fkOrder.getTzjlTranModel(orderId);
//							if(feeTranModel!=null){
//								tranModelList.add(feeTranModel);
//							}
//						}
						if(count==orderIds.length-1){
							// 收成交服务费
							T6238 t6238 = fkOrder.selectT6238(t6230.F01);
							if (t6238 != null && t6238.F02.compareTo(new BigDecimal(0)) > 0) {
								BigDecimal fwf = t6238.F02.multiply(t6230.F05
										.subtract(t6230.F07));
								String feeoutTradeNo=userManger.getOutTradeNo(6, t6505.F01);
								TranModel feeTranModel=new TranModel(feeoutTradeNo, fwf.doubleValue(),accountNumber,t6110_j.F02,accountNumber,key);
								tranModelList.add(feeTranModel);
							}
						}
						count++;
					}
				}
				if(tg){
					tranDataModel.setTranList(tranModelList);
					ResultVo result=FunctionClientUtil.sendTrade(tranDataModel,this.getResourceProvider());
					System.out.println("审核标的放款..."+result.toString());
					if(result.getErrorNo()>=0){
						for (int orderId : orderIds) {
							executor.confirm(orderId, null);
						}
						//红包返现
						redPacketManage.opRedPacket(resourceProvider,serviceSession, id, true);
						//首投红包奖励
						redPacketManage.firstInvest(resourceProvider, serviceSession, id);
					}else{
						throw new LogicalException(result.getErrorMessage());
					}
				}
			}
			this.prompt(request, response, PromptLevel.WARRING, "放款成功");
			
			/**处理推广人的收益 start...
			if (orderIds != null) {
				if (BooleanParser.parse(configureProvider.getProperty(SystemVariable.ACCOUNT_SFTG))) {//是否推广
					tranDataModel=new TranDataModel(accountNumber,id+"");
					List<TranModel> tgTranModelList=new ArrayList<TranModel>();
					for (int orderId : orderIds) {//推广奖励
						TranModel feeTranModel = fkOrder.getTzjlTranModel(orderId);//交易记录
						if(feeTranModel!=null){
							tgTranModelList.add(feeTranModel);
						}
					}
					tgTranModelList=removeDuplicate(tgTranModelList);//去掉重复数据
					tranDataModel.setTranList(tgTranModelList);
					System.out.println("审核标的放款_推广奖励...tranDataModel..."+tranDataModel.createTranXML());
					//请求第三方支付进行交易
					ResultVo result=FunctionClientUtil.sendTrade(tranDataModel,this.getResourceProvider());
					if(result.getErrorNo()>=0){
						for (int orderId : orderIds) {
							executor.doCommision(orderId, null);//同步账户资金
						}	
					}else{
						System.out.println("审核标的放款_推广奖励_第三方返回,出错了...."+result.getErrorMessage());
					}
				}
			}*/
			
			/**处理推广人的收益 end...*/
			//增加投资人、借款人积分add by zhengxin 20150309
			JfResource jfResource = getResourceProvider().getResource(JfResource.class);
			jfResource.addCreditsByInvest(id);
			
			// 投资回调接口(希财)
			jfResource.csaiInvestCallback(id);
			
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
	
	/**去掉重复数据*/
	public static List<TranModel> removeDuplicate(List<TranModel> list) {  
	   for ( int i = 0 ; i < list.size() - 1 ; i ++ ) {  
	     for ( int j = list.size() - 1 ; j > i; j -- ) {  
	       if (list.get(j).getInName().equals(list.get(i).getInName())) {  
	         list.remove(j);  
	       }   
	      }   
	    }   
	  return list;
	} 
}
