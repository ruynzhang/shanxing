package com.dimeng.p2p.pay.job;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.Job;
import org.quartz.JobDataMap;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.SimpleTrigger;

import com.dimeng.framework.resource.ResourceProvider;
import com.dimeng.framework.service.ServiceProvider;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.modules.base.pay.service.DefaultInterestManage;
import com.dimeng.p2p.pay.config.Scheduler;
import com.dimeng.p2p.pay.util.QuDateUtil;

/**
 * 罚息Job
 * 
 * @author ice
 *
 */
public class AutoFxJob implements Job {
	protected static Log logger = LogFactory.getLog(AutoFxJob.class);

	public void execute(JobExecutionContext context) throws JobExecutionException {
		JobDataMap jobDataMap = context.getJobDetail().getJobDataMap();
		ResourceProvider resourceProvider = (ResourceProvider) jobDataMap.get(Scheduler.RESOURCE_PROVIDER);
		SimpleTrigger simpleTrigger = (SimpleTrigger) context.getTrigger();

		// 执行业务逻辑
		doService(resourceProvider);
		
		logger.debug("[自动罚息]已执行完一次Job,下次执行Job时间为:" + QuDateUtil.getDateStr(simpleTrigger.getNextFireTime()) + "(" + "重复:" + simpleTrigger.getRepeatCount() + "次,每" + simpleTrigger.getRepeatInterval() / 1000L + "秒" + ")");
	}

	// 执行业务逻辑
	public void doService(ResourceProvider resourceProvider) {
		ServiceProvider serviceProvider = resourceProvider.getResource(ServiceProvider.class);
		try (ServiceSession serviceSession = serviceProvider.createServiceSession()) {
			serviceSession.getService(DefaultInterestManage.class).calculate();
			serviceSession.commit();
		} catch (Throwable e) {
			resourceProvider.log(e);
		}
	}
}