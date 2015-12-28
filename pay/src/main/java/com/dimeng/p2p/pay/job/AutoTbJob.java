package com.dimeng.p2p.pay.job;

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
import com.dimeng.p2p.modules.base.pay.service.DefaultInterestManage;
import com.dimeng.p2p.order.TenderOrderExecutor;
import com.dimeng.p2p.pay.config.Scheduler;
import com.dimeng.p2p.pay.util.QuDateUtil;
import com.dimeng.p2p.variables.defines.SystemVariable;
import com.dimeng.util.parser.BooleanParser;

/**
 * 自动投标Job
 * 
 * @author ice
 *
 */
public class AutoTbJob implements Job {
	protected static Log logger = LogFactory.getLog(AutoTbJob.class);
	
	public void execute(JobExecutionContext context) throws JobExecutionException {
		JobDataMap jobDataMap = context.getJobDetail().getJobDataMap();
		ResourceProvider resourceProvider = (ResourceProvider) jobDataMap.get(Scheduler.RESOURCE_PROVIDER);
		SimpleTrigger simpleTrigger = (SimpleTrigger) context.getTrigger();
		
		ServiceProvider serviceProvider = resourceProvider.getResource(ServiceProvider.class);
		try (ServiceSession serviceSession = serviceProvider.createServiceSession()) {
			List<Integer> orderIds = serviceSession.getService(DefaultInterestManage.class).autoBid();
			serviceSession.commit();
			if (orderIds != null && orderIds.size() > 0) {
				ConfigureProvider configureProvider = resourceProvider.getResource(ConfigureProvider.class);
				Boolean tg = BooleanParser.parseObject(configureProvider.getProperty(SystemVariable.SFZJTG));
				TenderOrderExecutor executor = resourceProvider.getResource(TenderOrderExecutor.class);
				for (int orderId : orderIds) {
					try {
						executor.submit(orderId, null);
						if (!tg) {
							executor.confirm(orderId, null);
						}
					} catch (Exception e) {

					}
				}
			}
		} catch (Throwable e) {
			resourceProvider.log(e);
		}
		
		logger.debug("[自动投标]已执行完一次Job,下次执行Job时间为:" + QuDateUtil.getDateStr(simpleTrigger.getNextFireTime()) + "(" + "重复:" + simpleTrigger.getRepeatCount() + "次,每" + simpleTrigger.getRepeatInterval() / 1000L + "秒" + ")");
	}
}