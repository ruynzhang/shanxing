package com.dimeng.p2p.console.config.prd;

import com.dimeng.framework.data.sql.mysql.AbstractPooledConnectionProvider;
import com.dimeng.framework.log.Logger;
import com.dimeng.framework.resource.InitParameterProvider;
import com.dimeng.framework.resource.ResourceAnnotation;
import com.dimeng.framework.resource.ResourceRetention;
import com.dimeng.p2p.variables.P2PConst;

@ResourceAnnotation({ ResourceRetention.PRE_PRODUCTION,
		ResourceRetention.PRODUCTION })
public class DBMaster extends AbstractPooledConnectionProvider {

	public DBMaster(InitParameterProvider parameterProvider, Logger logger) {
		super(parameterProvider, logger);
	}

	@Override
	public String getName() {
		return P2PConst.DB_MASTER_PROVIDER;
	}

}
