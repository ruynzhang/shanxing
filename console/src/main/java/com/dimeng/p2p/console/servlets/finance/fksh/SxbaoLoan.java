package com.dimeng.p2p.console.servlets.finance.fksh;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
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
import com.dimeng.p2p.S62.entities.SxbaoConfig;
import com.dimeng.p2p.S62.entities.T6230;
import com.dimeng.p2p.S62.entities.T6231;
import com.dimeng.p2p.S62.entities.T6238;
import com.dimeng.p2p.S62.enums.T6230_F12;
import com.dimeng.p2p.S62.enums.T6230_F17;
import com.dimeng.p2p.S62.enums.T6230_F27;
import com.dimeng.p2p.S62.enums.T6231_F21;
import com.dimeng.p2p.S65.entities.T6505;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.p2p.escrow.huichao.function.model.ResultVo;
import com.dimeng.p2p.escrow.huichao.function.model.TranDataModel;
import com.dimeng.p2p.escrow.huichao.function.model.TranModel;
import com.dimeng.p2p.escrow.huichao.function.util.FunctionClientUtil;
import com.dimeng.p2p.escrow.huichao.service.FKOrder;
import com.dimeng.p2p.escrow.huichao.service.TenderConfirmManage;
import com.dimeng.p2p.escrow.huichao.service.UserManger;
import com.dimeng.p2p.modules.bid.console.service.BidManage;
import com.dimeng.p2p.order.TenderConfirmExecutor;
import com.dimeng.p2p.service.SxbaoManage;
import com.dimeng.p2p.utlis.JfResource;
import com.dimeng.p2p.variables.defines.HuiChaoPayVariavle;
import com.dimeng.p2p.variables.defines.SystemVariable;
import com.dimeng.util.parser.BooleanParser;
import com.dimeng.util.parser.DateParser;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_FINANCE_SXBAOLOAN", name = "善行宝放款")
public class SxbaoLoan extends AbstractFinanceServlet {

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void processGet(HttpServletRequest request, HttpServletResponse response, ServiceSession serviceSession) throws Throwable {
		processPost(request, response, serviceSession);
	}
	
	@Override
	protected void processPost(HttpServletRequest request, HttpServletResponse response, ServiceSession serviceSession) throws Throwable {
		try {
			SxbaoManage sxbaoManage = serviceSession.getService(SxbaoManage.class);
			int id = IntegerParser.parse(request.getParameter("id"));
			Long cid = sxbaoManage.updateBid2DFK(id);
			TenderConfirmManage tenderConfirmManage = serviceSession
					.getService(TenderConfirmManage.class);
			// 标ID
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
					System.out.println("审核善行宝的放款...tranDataModel@_@"+tranDataModel.createTranXML());
					ResultVo result=FunctionClientUtil.sendTrade(tranDataModel,this.getResourceProvider());
					if(result.getErrorNo()>=0){
						for (int orderId : orderIds) {
							executor.confirm(orderId, null);
						}	
					}else{
						throw new LogicalException(result.getErrorMessage());
					}
				}
			}
			
			//增加投资人、借款人积分add by zhengxin 20150309
			JfResource jfResource = getResourceProvider().getResource(JfResource.class);
			jfResource.addCreditsByInvest(id);
			if(cid != null){
				SxbaoConfig sxbaoConfig = sxbaoManage.findConfigById(cid);
				if(sxbaoConfig.isAutoBid){
					BidManage bidManage = serviceSession.getService(BidManage.class);
					T6230 t6230 = new T6230();
					t6230.F02 = sxbaoConfig.loaner.intValue();
					t6230.F03 = sxbaoConfig.title + DateParser.format(new Date(), "yyyyMMdd");
					t6230.F04 = 1;
					BigDecimal money = new BigDecimal("99999999999999");
					t6230.F05 = money;
					t6230.F06 = sxbaoConfig.rate.multiply(new BigDecimal(100));
					t6230.F07 = money;
					t6230.F08 = 365;
					t6230.F09 = sxbaoConfig.loanPeriod.intValue();
					t6230.F10 = sxbaoConfig.mode;
					t6230.F12 = T6230_F12.BXQEDB;
					t6230.F17 = T6230_F17.ZRY;
					t6230.F18 = 1;
					t6230.F19 = 1;
					t6230.F27 = T6230_F27.F;
					T6231 t6231 = new T6231();
					t6231.F07 = 440303;
					t6231.F08 = sxbaoConfig.title;
					t6231.F09 = sxbaoConfig.title;
					t6231.F16 = sxbaoConfig.title;
					T6238 t6238 = new T6238();
					t6238.F02 = BigDecimal.ZERO;
					t6238.F03 = BigDecimal.ZERO;
					t6238.F04 = BigDecimal.ZERO;
					t6231.F21 = T6231_F21.F;
					t6231.F22 = 0;
					sxbaoConfig.bid = Long.valueOf(bidManage.add(t6230, t6231, t6238));
					sxbaoManage.updateBid(sxbaoConfig);
				}
			}
			this.prompt(request, response, PromptLevel.WARRING, "放款成功");
			
			sendRedirect(request, response,
					getController().getURI(request, SxbaofkList.class));
		} catch (Throwable throwable) {
			if (throwable instanceof LogicalException
					|| throwable instanceof ParameterException) {
				getController().prompt(request, response, PromptLevel.WARRING,
						throwable.getMessage());
				sendRedirect(request, response,
						getController().getURI(request, SxbaofkList.class));
			} else {
				super.onThrowable(request, response, throwable);
			}
		}
	}
}
