package com.dimeng.p2p.pay.job;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.CronTrigger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.dimeng.p2p.pay.util.QuDateUtil;

/**
 * 测试Job
 * 
 * @author ice
 *
 */
public class TestJob implements Job {
	protected static Log logger = LogFactory.getLog(AutoHkJob.class);

	public void execute(JobExecutionContext context) throws JobExecutionException {
		CronTrigger cronTrigger = (CronTrigger) context.getTrigger();
		logger.debug("[测试Job]已执行完一次Job,下次执行Job时间为:" + QuDateUtil.getDateStr(cronTrigger.getNextFireTime()) + "(" + "表达式:" + cronTrigger.getCronExpression() + ")");
	}
}