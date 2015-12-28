package com.dimeng.p2p.pay.job;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.CronTrigger;
import org.quartz.Job;
import org.quartz.JobDataMap;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.resource.ResourceProvider;
import com.dimeng.framework.service.ServiceProvider;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.common.Expemoneyrecord;
import com.dimeng.p2p.common.Expemonyinfo;
import com.dimeng.p2p.escrow.huichao.function.model.ResultVo;
import com.dimeng.p2p.escrow.huichao.function.model.TranDataModel;
import com.dimeng.p2p.escrow.huichao.function.model.TranModel;
import com.dimeng.p2p.escrow.huichao.function.util.FunctionClientUtil;
import com.dimeng.p2p.escrow.huichao.service.TenderTybManage;
import com.dimeng.p2p.pay.config.Scheduler;
import com.dimeng.p2p.pay.util.QuDateUtil;
import com.dimeng.p2p.variables.defines.HuiChaoPayVariavle;

/**
 * 体验金自动还款Job
 * 
 * @author ice
 *
 */
public class AutoTyjJob implements Job {
	protected static Log logger = LogFactory.getLog(AutoTyjJob.class);

	public void execute(JobExecutionContext context) throws JobExecutionException {
		JobDataMap jobDataMap = context.getJobDetail().getJobDataMap();
		ResourceProvider resourceProvider = (ResourceProvider) jobDataMap.get(Scheduler.RESOURCE_PROVIDER);
		CronTrigger cronTrigger = (CronTrigger) context.getTrigger();

		// 执行业务逻辑
		doService(resourceProvider);

		logger.debug("[体验还款]已执行完一次Job,下次执行Job时间为:" + QuDateUtil.getDateStr(cronTrigger.getNextFireTime()) + "(" + "表达式:" + cronTrigger.getCronExpression() + ")");
	}

	// 执行业务逻辑
	public void doService(ResourceProvider resourceProvider) {
		ServiceProvider serviceProvider = resourceProvider.getResource(ServiceProvider.class);
		try (ServiceSession serviceSession = serviceProvider.createServiceSession()) {
			ConfigureProvider configureProvider = resourceProvider.getResource(ConfigureProvider.class);
			TenderTybManage tenderTybManage = serviceSession.getService(TenderTybManage.class);
			List<Expemonyinfo> exinfolist = tenderTybManage.selXepereinfolist();
			serviceSession.commit();
			List<TranModel> tranModelList = null;
			if (exinfolist != null && exinfolist.size() != 0) {
				for (Expemonyinfo info : exinfolist) {
					String accountNumber = configureProvider.format(HuiChaoPayVariavle.NUMBER_ID);
					TranDataModel tranDataModel = new TranDataModel(accountNumber, "002");
					tranModelList = new ArrayList<>();
					//给tranModelList赋值，加入转账列表
					List<Expemoneyrecord> experecordList = tenderTybManage.selExperecordlist(info.id);
					tenderTybManage.operationSurpriseLucre(tranModelList, experecordList);
					if (experecordList != null && experecordList.size() != 0) {
						tranDataModel.setTranList(tranModelList);
						System.out.println("发放体验标的利息.bid:" + info.id + ",tranDataModel..." + tranDataModel.createTranXML());
						//请求第三方支付进行交易
						ResultVo result = FunctionClientUtil.sendTrade(tranDataModel, resourceProvider);
						if (result.getErrorNo() >= 0) {
							//添加平台记录
							tenderTybManage.confirm(info.id, experecordList);
							System.out.println("发放体验标的利息发送成功" + result.toString());
						} else {
							System.out.println("发放体验标的利息,出错了...." + result.toString());
						}
					} else {
						System.out.println("发放体验标的没有投标记录....");
					}
				}
			}
		} catch (Throwable e) {
			resourceProvider.log(e);
		}
	}
}