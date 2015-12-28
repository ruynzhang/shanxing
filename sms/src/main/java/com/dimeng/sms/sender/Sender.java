package com.dimeng.sms.sender;

import java.util.HashSet;
import java.util.Set;

import com.dimeng.framework.config.achieve.DefaultConfigureProvider;
import com.dimeng.framework.log.Logger;
import com.dimeng.framework.message.achieve.sms.SmsExtracterImpl.SmsExtracterFactory;
import com.dimeng.framework.resource.ResourceProvider;
import com.dimeng.framework.resource.achieve.ResourceInitializer;
import com.dimeng.framework.service.achieve.SimpleServiceProvider;
import com.dimeng.framework.service.achieve.SimpleServiceProvider.SimpleServiceSession;
import com.dimeng.sms.sender.config.Master;
import com.dimeng.sms.sender.config.SmsDefine;

public class Sender {

	public static void main(String... args) {
		Set<Class<?>> classes = new HashSet<>();
		classes.add(SmsDefine.class);
		classes.add(Master.class);
		classes.add(SimpleServiceProvider.class);
		classes.add(SimpleServiceSession.class);
		classes.add(SmsExtracterFactory.class);
		classes.add(DefaultConfigureProvider.class);
		ResourceProvider resourceProvider = new ResourceInitializer()
				.initialize(classes, new Logger() {
					@Override
					public void log(String message) {
						System.out.println(message);
					}

					@Override
					public void log(Throwable throwable) {
						throwable.printStackTrace();
					}
				}, args);
		Scheduler scheduler = new Scheduler(resourceProvider);
		scheduler.start();
	}

}
