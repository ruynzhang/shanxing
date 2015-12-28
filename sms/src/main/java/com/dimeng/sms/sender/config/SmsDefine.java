package com.dimeng.sms.sender.config;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.Rewriter;
import com.dimeng.framework.http.session.authentication.AuthenticationException;
import com.dimeng.framework.http.session.authentication.PasswordAuthentication;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.common.P2PSystemDefine;

public class SmsDefine extends P2PSystemDefine {

	@Override
	public String getGUID() {
		return null;
	}

	@Override
	public Rewriter getRewriter() {
		return null;
	}

	@Override
	public int readAccountId(ServiceSession serviceSession, String accountName,
			String password) throws AuthenticationException, SQLException {
		return 0;
	}

	@Override
	public void writeLog(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession,
			PasswordAuthentication authentication, int accountId) {

	}

}
