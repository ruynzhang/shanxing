package com.dimeng.p2p.pay.config;

import java.util.Calendar;
import java.util.Date;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.CronScheduleBuilder;
import org.quartz.CronTrigger;
import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.SchedulerException;
import org.quartz.SchedulerFactory;
import org.quartz.SimpleScheduleBuilder;
import org.quartz.SimpleTrigger;
import org.quartz.TriggerBuilder;
import org.quartz.impl.StdSchedulerFactory;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.resource.ResourceProvider;
import com.dimeng.framework.resource.cycle.Shutdown;
import com.dimeng.framework.resource.cycle.Startup;
import com.dimeng.p2p.pay.job.AutoDdJob;
import com.dimeng.p2p.pay.job.AutoFxJob;
import com.dimeng.p2p.pay.job.AutoHbJob;
import com.dimeng.p2p.pay.job.AutoHbgqJob;
import com.dimeng.p2p.pay.job.AutoHkJob;
import com.dimeng.p2p.pay.job.AutoTbJob;
import com.dimeng.p2p.pay.job.AutoTyjJob;
import com.dimeng.p2p.pay.job.TestJob;
import com.dimeng.p2p.pay.util.QuDateUtil;
import com.dimeng.p2p.variables.defines.SystemVariable;
import com.dimeng.util.parser.IntegerParser;

public class Scheduler implements Startup, Shutdown {

	protected static Log logger = LogFactory.getLog(Scheduler.class);
	public static final String RESOURCE_PROVIDER = "resourceProvider";

	public static void main(String[] args) throws SchedulerException {
		SchedulerFactory sf = new StdSchedulerFactory();
		org.quartz.Scheduler scheduler = sf.getScheduler();

		JobDetail jobDetail = JobBuilder.newJob(TestJob.class).withIdentity("jobAutoHk", "groupAutoHk").build();
		CronTrigger cronTrigger = (CronTrigger) TriggerBuilder.newTrigger().withIdentity("triggerAutoHk", "groupAutoHk").withSchedule(CronScheduleBuilder.cronSchedule("0/1 * 14-15,13 * * ?")).build();
		Date dateRun = scheduler.scheduleJob(jobDetail, cronTrigger);
		logger.info(jobDetail.getKey() + "(自动还款)将会在: " + QuDateUtil.getDateStr(dateRun) + " 执行,Cron表达式为: " + cronTrigger.getCronExpression());

		scheduler.start();
	}

	@Override
	public void onStartup(final ResourceProvider resourceProvider) {
		// 定义,初始化
		SchedulerFactory sf = new StdSchedulerFactory();

		try {
			// 定义,初始化
			org.quartz.Scheduler scheduler = sf.getScheduler();
			ConfigureProvider configureProvider = resourceProvider.getResource(ConfigureProvider.class);

			// 计算罚息自动任务执行间隔(分)
			int yqhkDate = IntegerParser.parse(configureProvider.getProperty(SystemVariable.YQ_HK_FX_DATE)) == 0 ? 720 : IntegerParser.parse(configureProvider.getProperty(SystemVariable.YQ_HK_FX_DATE));

			// 自动任务执行时间(时)
			int autoTaskHour = IntegerParser.parse(configureProvider.getProperty(SystemVariable.AUTO_TASK_TIME_HOUR));

			// 自动任务执行时间(分)
			int autoTaskMinute = IntegerParser.parse(configureProvider.getProperty(SystemVariable.AUTO_TASK_TIME_MINUTE));

			Calendar calendar = Calendar.getInstance();
			calendar.setTimeInMillis(System.currentTimeMillis());
			calendar.set(Calendar.HOUR_OF_DAY, autoTaskHour);
			calendar.set(Calendar.MINUTE, autoTaskMinute);
			calendar.set(Calendar.SECOND, 0);

			/** 计算自动罚息 ********************************************/
			// 指定间隔时间一直执行
			JobDetail jobDetail = JobBuilder.newJob(AutoFxJob.class).withIdentity("jobAutoFx", "groupAutoFx").build();
			jobDetail.getJobDataMap().put(RESOURCE_PROVIDER, resourceProvider);
			SimpleTrigger simpleTrigger = (SimpleTrigger) TriggerBuilder.newTrigger().withIdentity("triggerAutoFx", "groupAutoFx").startNow().withSchedule(SimpleScheduleBuilder.simpleSchedule().withIntervalInMinutes(yqhkDate).repeatForever()).build();
			Date dateRun = scheduler.scheduleJob(jobDetail, simpleTrigger);
			logger.info(jobDetail.getKey() + "(自动罚息)将会在: " + QuDateUtil.getDateStr(dateRun) + " 执行,并重复: " + simpleTrigger.getRepeatCount() + " 次, 每" + simpleTrigger.getRepeatInterval() / 1000L + "秒");

			/** 计算自动还款 ********************************************/
			// 根据表达式执行
			AutoFxJob autoFxJob = new AutoFxJob();
			jobDetail = JobBuilder.newJob(AutoHkJob.class).withIdentity("jobAutoHk", "groupAutoHk").build();
			jobDetail.getJobDataMap().put(RESOURCE_PROVIDER, resourceProvider);
			CronTrigger cronTrigger = (CronTrigger) TriggerBuilder.newTrigger().withIdentity("triggerAutoHk", "groupAutoHk").withSchedule(CronScheduleBuilder.cronSchedule("0 0/30 7-22 * * ?")).build();
			dateRun = scheduler.scheduleJob(jobDetail, cronTrigger);
			autoFxJob.doService(resourceProvider);
			logger.info(jobDetail.getKey() + "(自动还款已执行一次)并且将会在: " + QuDateUtil.getDateStr(dateRun) + " 执行调度,Cron表达式为: " + cronTrigger.getCronExpression());

			/** 定时提交订单 ********************************************/
			// 指定间隔时间一直执行
			jobDetail = JobBuilder.newJob(AutoDdJob.class).withIdentity("jobAutoDd", "groupAutoDd").build();
			jobDetail.getJobDataMap().put(RESOURCE_PROVIDER, resourceProvider);
			simpleTrigger = (SimpleTrigger) TriggerBuilder.newTrigger().withIdentity("triggerAutoDd", "groupAutoDd").startNow().withSchedule(SimpleScheduleBuilder.simpleSchedule().withIntervalInMilliseconds(5000).repeatForever()).build();
			dateRun = scheduler.scheduleJob(jobDetail, simpleTrigger);
			logger.info(jobDetail.getKey() + "(定时订单)将会在: " + QuDateUtil.getDateStr(dateRun) + " 执行,并重复: " + simpleTrigger.getRepeatCount() + " 次, 每" + simpleTrigger.getRepeatInterval() / 1000L + "秒");

			/** 自动投标 **********************************************/
			// 指定间隔时间一直执行
			int minute = IntegerParser.parse(configureProvider.getProperty(SystemVariable.AUTO_BIDING_START_TIME)) == 0 ? 2 : IntegerParser.parse(configureProvider.getProperty(SystemVariable.AUTO_BIDING_START_TIME));// 进入招标中多久后,才会启动自动投标(分)
			jobDetail = JobBuilder.newJob(AutoTbJob.class).withIdentity("jobAutoTb", "groupAutoTb").build();
			jobDetail.getJobDataMap().put(RESOURCE_PROVIDER, resourceProvider);
			simpleTrigger = (SimpleTrigger) TriggerBuilder.newTrigger().withIdentity("triggerAutoTb", "groupAutoTb").startNow().withSchedule(SimpleScheduleBuilder.simpleSchedule().withIntervalInMinutes(minute).repeatForever()).build();
			dateRun = scheduler.scheduleJob(jobDetail, simpleTrigger);
			logger.info(jobDetail.getKey() + "(自动投标)将会在: " + QuDateUtil.getDateStr(dateRun) + " 执行,并重复: " + simpleTrigger.getRepeatCount() + " 次, 每" + simpleTrigger.getRepeatInterval() / 1000L + "秒");

			/** 体验金自动还款 *******************************************/
			// 根据表达式执行
			AutoTyjJob autoTyjJob = new AutoTyjJob();
			jobDetail = JobBuilder.newJob(AutoTyjJob.class).withIdentity("jobAutoTyj", "groupAutoTyj").build();
			jobDetail.getJobDataMap().put(RESOURCE_PROVIDER, resourceProvider);
			cronTrigger = (CronTrigger) TriggerBuilder.newTrigger().withIdentity("triggerAutoTyj", "groupAutoTyj").withSchedule(CronScheduleBuilder.cronSchedule("0 0/5 7-22 * * ?")).build();
			dateRun = scheduler.scheduleJob(jobDetail, cronTrigger);
			autoTyjJob.doService(resourceProvider);
			logger.info(jobDetail.getKey() + "(体验还款已执行一次)并且将会在: " + QuDateUtil.getDateStr(dateRun) + " 执行调度,Cron表达式为: " + cronTrigger.getCronExpression());
			
			/** 标的自动放款 ******************************************
			// 根据表达式执行
			jobDetail = JobBuilder.newJob(AutoLoanJob.class).withIdentity("jobAutoLoan", "groupAutoLoan").build();
			jobDetail.getJobDataMap().put(RESOURCE_PROVIDER, resourceProvider);
			simpleTrigger = (SimpleTrigger) TriggerBuilder.newTrigger().withIdentity("triggerAutoLoan", "groupAutoLoan").startNow().withSchedule(SimpleScheduleBuilder.simpleSchedule().withIntervalInMinutes(yqhkDate).repeatForever()).build();
			dateRun = scheduler.scheduleJob(jobDetail, simpleTrigger);
			logger.info(jobDetail.getKey() + "(自动放款)将会在: " + QuDateUtil.getDateStr(dateRun) + " 执行,并重复: " + simpleTrigger.getRepeatCount() + " 次, 每" + simpleTrigger.getRepeatInterval() / 1000L + "秒");
			*/
			/** 自动更改红包过期 *******************************************/
			// 根据表达式执行
			jobDetail = JobBuilder.newJob(AutoHbJob.class).withIdentity("jobAutoHb", "groupAutoHb").build();
			jobDetail.getJobDataMap().put(RESOURCE_PROVIDER, resourceProvider);
			cronTrigger = (CronTrigger) TriggerBuilder.newTrigger().withIdentity("triggerAutoHb", "groupAutoHb").withSchedule(CronScheduleBuilder.cronSchedule("0 0 0 * * ?")).build();
			dateRun = scheduler.scheduleJob(jobDetail, cronTrigger);
			logger.info(jobDetail.getKey() + "(红包)并且将会在: " + QuDateUtil.getDateStr(dateRun) + " 执行调度,Cron表达式为: " + cronTrigger.getCronExpression());
			
			jobDetail = JobBuilder.newJob(AutoHbgqJob.class).withIdentity("jobAutoHbgq", "groupAutoHbgq").build();
			jobDetail.getJobDataMap().put(RESOURCE_PROVIDER, resourceProvider);
			cronTrigger = (CronTrigger) TriggerBuilder.newTrigger().withIdentity("triggerAutoHbgq", "groupAutoHbgq").withSchedule(CronScheduleBuilder.cronSchedule("0 0 9 * * ?")).build();
			dateRun = scheduler.scheduleJob(jobDetail, cronTrigger);
			logger.info(jobDetail.getKey() + "(红包)并且将会在: " + QuDateUtil.getDateStr(dateRun) + " 执行调度,Cron表达式为: " + cronTrigger.getCronExpression());

			scheduler.start();
		} catch (SchedulerException e1) {
			e1.printStackTrace();
		}
	}

	@Override
	public void onShutdown(ResourceProvider resourceProvider) {
	}
}