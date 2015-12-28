package com.dimeng.p2p.pay.job;

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
import com.dimeng.p2p.modules.base.pay.service.RepaymentManage;
import com.dimeng.p2p.order.TenderRepaymentExecutor;
import com.dimeng.p2p.pay.config.Scheduler;
import com.dimeng.p2p.pay.util.QuDateUtil;
import com.dimeng.p2p.variables.defines.SystemVariable;
import com.dimeng.util.parser.BooleanParser;

/**
 * 自动还款Job
 * 
 * @author ice
 *
 */
public class AutoHkJob implements Job {
	protected static Log logger = LogFactory.getLog(AutoHkJob.class);

	public void execute(JobExecutionContext context) throws JobExecutionException {
		JobDataMap jobDataMap = context.getJobDetail().getJobDataMap();
		ResourceProvider resourceProvider = (ResourceProvider) jobDataMap.get(Scheduler.RESOURCE_PROVIDER);
		CronTrigger cronTrigger = (CronTrigger) context.getTrigger();

		ServiceProvider serviceProvider = resourceProvider.getResource(ServiceProvider.class);
		try (ServiceSession serviceSession = serviceProvider.createServiceSession()) {
			int[] orderIds = serviceSession.getService(RepaymentManage.class).repayment();
			serviceSession.commit();
			if (orderIds != null) {
				ConfigureProvider configureProvider = resourceProvider.getResource(ConfigureProvider.class);
				Boolean tg = BooleanParser.parseObject(configureProvider.getProperty(SystemVariable.SFZJTG));
				TenderRepaymentExecutor executor = resourceProvider.getResource(TenderRepaymentExecutor.class);
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

		logger.debug("[自动还款]已执行完一次Job,下次执行Job时间为:" + QuDateUtil.getDateStr(cronTrigger.getNextFireTime()) + "(" + "表达式:" + cronTrigger.getCronExpression() + ")");
	}
}