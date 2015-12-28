package com.dimeng.p2p.pay.job;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.CronTrigger;
import org.quartz.Job;
import org.quartz.JobDataMap;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.dimeng.framework.resource.ResourceProvider;
import com.dimeng.framework.service.ServiceProvider;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.pay.config.Scheduler;
import com.dimeng.p2p.pay.util.QuDateUtil;
import com.dimeng.p2p.service.RedPacketManage;

public class AutoHbgqJob implements Job{

	protected static Log logger = LogFactory.getLog(AutoHbgqJob.class);
	
	@Override
	public void execute(JobExecutionContext context)
			throws JobExecutionException {
		JobDataMap jobDataMap = context.getJobDetail().getJobDataMap();
		ResourceProvider resourceProvider = (ResourceProvider) jobDataMap.get(Scheduler.RESOURCE_PROVIDER);
		CronTrigger cronTrigger = (CronTrigger) context.getTrigger();

		ServiceProvider serviceProvider = resourceProvider.getResource(ServiceProvider.class);
		try (ServiceSession serviceSession = serviceProvider.createServiceSession()) {
			RedPacketManage executor = serviceSession.getService(RedPacketManage.class);
			//处理红包即将到期，给用户发送短信
			executor.AutoSendSMS(serviceSession);
		} catch (Throwable e) {
			resourceProvider.log(e);
		}
		logger.debug("[红包]已执行完一次Job,下次执行Job时间为:" + QuDateUtil.getDateStr(cronTrigger.getNextFireTime()) + "(" + "表达式:" + cronTrigger.getCronExpression() + ")");
	}

}