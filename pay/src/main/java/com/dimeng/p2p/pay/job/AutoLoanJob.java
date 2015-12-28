package com.dimeng.p2p.pay.job;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.Job;
import org.quartz.JobDataMap;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.SimpleTrigger;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.resource.ResourceProvider;
import com.dimeng.framework.service.ServiceProvider;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S61.entities.T6110;
import com.dimeng.p2p.S62.entities.T6230;
import com.dimeng.p2p.S62.entities.T6238;
import com.dimeng.p2p.S65.entities.T6505;
import com.dimeng.p2p.escrow.huichao.function.model.ResultVo;
import com.dimeng.p2p.escrow.huichao.function.model.TranDataModel;
import com.dimeng.p2p.escrow.huichao.function.model.TranModel;
import com.dimeng.p2p.escrow.huichao.function.util.FunctionClientUtil;
import com.dimeng.p2p.escrow.huichao.service.FKOrder;
import com.dimeng.p2p.escrow.huichao.service.TenderConfirmManage;
import com.dimeng.p2p.escrow.huichao.service.UserManger;
import com.dimeng.p2p.order.TenderConfirmExecutor;
import com.dimeng.p2p.pay.config.Scheduler;
import com.dimeng.p2p.pay.util.QuDateUtil;
import com.dimeng.p2p.service.BidManage;
import com.dimeng.p2p.service.RedPacketManage;
import com.dimeng.p2p.utlis.JfResource;
import com.dimeng.p2p.variables.defines.HuiChaoPayVariavle;
import com.dimeng.p2p.variables.defines.SystemVariable;
import com.dimeng.util.parser.BooleanParser;

/**
 * 自动放款
 * @author yangjh
 *
 */
public class AutoLoanJob implements Job {

	protected static Log logger = LogFactory.getLog(AutoLoanJob.class);
	
	@Override
	public void execute(JobExecutionContext context)
			throws JobExecutionException {
		JobDataMap jobDataMap = context.getJobDetail().getJobDataMap();
		ResourceProvider resourceProvider = (ResourceProvider) jobDataMap.get(Scheduler.RESOURCE_PROVIDER);
		SimpleTrigger simpleTrigger = (SimpleTrigger) context.getTrigger();
		ServiceProvider serviceProvider = resourceProvider.getResource(ServiceProvider.class);
		try (ServiceSession serviceSession = serviceProvider.createServiceSession()) {
			BidManage bidManage = serviceSession.getService(BidManage.class);
			List<Integer> list=bidManage.getFullBidList();
			TenderConfirmManage tenderConfirmManage = serviceSession.getService(TenderConfirmManage.class);
			ConfigureProvider configureProvider = resourceProvider.getResource(ConfigureProvider.class);
			JfResource jfResource = resourceProvider.getResource(JfResource.class);
			RedPacketManage redPacketManage = serviceSession.getService(RedPacketManage.class);
			Boolean tg = BooleanParser.parseObject(configureProvider.getProperty(SystemVariable.SFZJTG));
			TenderConfirmExecutor executor = resourceProvider.getResource(TenderConfirmExecutor.class);
			String accountNumber=configureProvider.format(HuiChaoPayVariavle.NUMBER_ID);
			String key=configureProvider.format(HuiChaoPayVariavle.MERCHANTKEY);
			if(null!=list){
				for (Integer bid : list) {
					int[] orderIds = tenderConfirmManage.confirm(bid);
					serviceSession.commit();
					TranDataModel tranDataModel=new TranDataModel(accountNumber,bid+"");
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
							ResultVo result=FunctionClientUtil.sendTrade(tranDataModel,resourceProvider);
							System.out.println("自动放款返回结果："+result);
							if(result.getErrorNo()>=0){
								for (int orderId : orderIds) {
									executor.confirm(orderId, null);
								}
								//增加投资人、借款人积分add by zhengxin 20150309
								jfResource.addCreditsByInvest(bid);
								redPacketManage.opRedPacket(resourceProvider,serviceSession, bid, true);
							}
						}
					}
				}
				
			}
		} catch (Throwable e) {
			resourceProvider.log(e);
		}

		logger.debug("[定时订单]已执行完一次Job,下次执行Job时间为:" + QuDateUtil.getDateStr(simpleTrigger.getNextFireTime()) + "(" + "重复:" + simpleTrigger.getRepeatCount() + "次,每" + simpleTrigger.getRepeatInterval() / 1000L + "秒" + ")");
	}

}
