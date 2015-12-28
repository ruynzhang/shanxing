package com.dimeng.p2p.console.config;

import com.dimeng.framework.config.service.VariableManage;
import com.dimeng.framework.resource.ResourceProvider;
import com.dimeng.framework.resource.cycle.Startup;
import com.dimeng.framework.service.ServiceProvider;
import com.dimeng.framework.service.ServiceSession;

public class VariableInitializer implements Startup {

	@Override
	public void onStartup(ResourceProvider resourceProvider) {
		ServiceProvider serviceProvider = resourceProvider
				.getResource(ServiceProvider.class);
		try (ServiceSession serviceSession = serviceProvider
				.createServiceSession()) {
			serviceSession.getService(VariableManage.class).synchronize();
		} catch (Throwable e) {
			resourceProvider.log(e);
		}
	}
}
