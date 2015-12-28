package com.dimeng.sms.sender.config;

import java.util.Properties;

import com.dimeng.framework.data.sql.mysql.AbstractDriverConnectionProvider;
import com.dimeng.framework.log.Logger;
import com.dimeng.framework.resource.InitParameterProvider;
import com.dimeng.framework.resource.ResourceAnnotation;
import com.dimeng.p2p.variables.P2PConst;
import com.dimeng.util.StringHelper;

@ResourceAnnotation
public class Master extends AbstractDriverConnectionProvider {
	public Master(InitParameterProvider parameterProvider, Logger logger) {
		super(parameterProvider, logger);
		driver = parameterProvider.getInitParameter("driver");
		if (StringHelper.isEmpty(driver)) {
			driver = "com.mysql.jdbc.Driver";
		}
		url = parameterProvider.getInitParameter("jdbcUrl");
		properties = new Properties();
		properties.setProperty("user",
				parameterProvider.getInitParameter("user"));
		properties.setProperty("password",
				parameterProvider.getInitParameter("password"));
		properties.setProperty("useUnicode", "true");
		properties.setProperty("characterEncoding", "UTF8");
	}

	@Override
	public String getName() {
		return P2PConst.DB_MASTER_PROVIDER;
	}
}
