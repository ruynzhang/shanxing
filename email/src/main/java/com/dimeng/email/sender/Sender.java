package com.dimeng.email.sender;

import java.util.HashSet;
import java.util.Set;

import com.dimeng.email.sender.config.EmailDefine;
import com.dimeng.email.sender.config.Master;
import com.dimeng.framework.config.achieve.DefaultConfigureProvider;
import com.dimeng.framework.log.Logger;
import com.dimeng.framework.message.achieve.email.EmailExtracterImpl.EmailExtracterFactory;
import com.dimeng.framework.resource.ResourceProvider;
import com.dimeng.framework.resource.achieve.ResourceInitializer;
import com.dimeng.framework.service.achieve.SimpleServiceProvider;
import com.dimeng.framework.service.achieve.SimpleServiceProvider.SimpleServiceSession;

public class Sender {

	public static void main(String... args) {
		Set<Class<?>> classes = new HashSet<>();
		classes.add(EmailDefine.class);
		classes.add(Master.class);
		classes.add(SimpleServiceProvider.class);
		classes.add(SimpleServiceSession.class);
		classes.add(EmailExtracterFactory.class);
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
