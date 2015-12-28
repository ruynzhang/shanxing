package com.dimeng.p2p.console.service;

import java.sql.Connection;
import java.sql.SQLException;

import com.dimeng.framework.data.sql.SQLConnectionProvider;
import com.dimeng.framework.resource.ResourceNotFoundException;
import com.dimeng.framework.service.ServiceResource;
import com.dimeng.p2p.console.config.ConsoleConst;
import com.dimeng.p2p.service.AbstractP2PService;

public abstract class AbstractConsoleService extends AbstractP2PService {

	public AbstractConsoleService(ServiceResource serviceResource) {
		super(serviceResource);
	}

	protected SQLConnectionProvider getSQLConnectionProvider()
			throws ResourceNotFoundException, SQLException {
		return serviceResource.getDataConnectionProvider(
				SQLConnectionProvider.class, ConsoleConst.DB_MASTER_PROVIDER);
	}

	protected Connection getConnection() throws ResourceNotFoundException,
			SQLException {
		return serviceResource.getDataConnectionProvider(
				SQLConnectionProvider.class, ConsoleConst.DB_MASTER_PROVIDER)
				.getConnection();
	}

	protected Connection getConnection(String db)
			throws ResourceNotFoundException, SQLException {
		return serviceResource.getDataConnectionProvider(
				SQLConnectionProvider.class, ConsoleConst.DB_MASTER_PROVIDER)
				.getConnection(db);
	}
}
