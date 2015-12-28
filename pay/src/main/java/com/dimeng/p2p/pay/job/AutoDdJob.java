package com.dimeng.p2p.pay.job;

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
import com.dimeng.p2p.S65.entities.T6501;
import com.dimeng.p2p.modules.base.pay.service.OrderManage;
import com.dimeng.p2p.order.AbstractOrderExecutor;
import com.dimeng.p2p.order.FinancialPurchaseExecutor;
import com.dimeng.p2p.order.FinancialRepaymentExecutor;
import com.dimeng.p2p.order.TenderCancelExecutor;
import com.dimeng.p2p.order.TenderConfirmExecutor;
import com.dimeng.p2p.order.TenderExchangeExecutor;
import com.dimeng.p2p.order.TenderOrderExecutor;
import com.dimeng.p2p.order.TransferExecutor;
import com.dimeng.p2p.pay.config.Scheduler;
import com.dimeng.p2p.pay.util.QuDateUtil;
import com.dimeng.p2p.variables.defines.SystemVariable;
import com.dimeng.util.parser.BooleanParser;

/**
 * 定时提交订单Job
 * 
 * @author ice
 *
 */
public class AutoDdJob implements Job {
	protected static Log logger = LogFactory.getLog(AutoDdJob.class);

	public void execute(JobExecutionContext context) throws JobExecutionException {
		JobDataMap jobDataMap = context.getJobDetail().getJobDataMap();
		ResourceProvider resourceProvider = (ResourceProvider) jobDataMap.get(Scheduler.RESOURCE_PROVIDER);
		SimpleTrigger simpleTrigger = (SimpleTrigger) context.getTrigger();

		ServiceProvider serviceProvider = resourceProvider.getResource(ServiceProvider.class);
		try (ServiceSession serviceSession = serviceProvider.createServiceSession()) {
			T6501 order = serviceSession.getService(OrderManage.class).getToSubmit();
			if (order != null) {
				ConfigureProvider configureProvider = resourceProvider.getResource(ConfigureProvider.class);
				Boolean tg = BooleanParser.parseObject(configureProvider.getProperty(SystemVariable.SFZJTG));
				AbstractOrderExecutor executor = getExecutor(resourceProvider, order.F02);
				if (executor != null) {
					// 提交订单
					try {
						executor.submit(order.F01, null);
						if (!tg) {
							executor.confirm(order.F01, null);// 确认订单
						}
					} catch (Exception e) {
					}
				}
			}
		} catch (Throwable e) {
			resourceProvider.log(e);
		}

		logger.debug("[定时订单]已执行完一次Job,下次执行Job时间为:" + QuDateUtil.getDateStr(simpleTrigger.getNextFireTime()) + "(" + "重复:" + simpleTrigger.getRepeatCount() + "次,每" + simpleTrigger.getRepeatInterval() / 1000L + "秒" + ")");
	}

	protected AbstractOrderExecutor getExecutor(final ResourceProvider resourceProvider, int orderType) {
		switch (orderType) {
		//		case 10001: {
		//			return resourceProvider.getResource(ChargeOrderExecutor.class);
		//		}
		case 20001: {
			return resourceProvider.getResource(TenderOrderExecutor.class);
		}
		case 20002: {
			return resourceProvider.getResource(TenderCancelExecutor.class);
		}
		case 20003: {
			return resourceProvider.getResource(TenderConfirmExecutor.class);
		}
		// case 20004: {
		// return resourceProvider.getResource(TenderRepaymentExecutor.class);
		// }
		case 20005: {
			return resourceProvider.getResource(TenderExchangeExecutor.class);
		}
		case 30001: {
			return resourceProvider.getResource(FinancialPurchaseExecutor.class);
		}
		case 30002: {
			return resourceProvider.getResource(FinancialRepaymentExecutor.class);
		}
		case 50001: {
			return resourceProvider.getResource(TransferExecutor.class);
		}
		default:
			return null;
		}
	}
}