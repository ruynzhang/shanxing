package com.dimeng.p2p.console;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.Controller;
import com.dimeng.framework.http.servlet.PackageRewriter;
import com.dimeng.framework.http.servlet.Rewriter;
import com.dimeng.framework.http.session.SessionManager;
import com.dimeng.framework.http.session.authentication.AuthenticationException;
import com.dimeng.framework.http.session.authentication.PasswordAuthentication;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.common.P2PSystemDefine;
import com.dimeng.p2p.modules.systematic.console.service.SysUserManage;

public class ConsoleDefine extends P2PSystemDefine {
	protected final Rewriter rewriter;

	public ConsoleDefine() {
		super();
		schemas.put(SessionManager.class, DB_CONSOLE_SESSION);
		rewriter = new PackageRewriter("com.dimeng.p2p.console.servlets");
	}

	@Override
	public String getGUID() {
		return "e991f91c-9368-4428-8070-04a5fd7149dc";
	}

	@Override
	public int readAccountId(ServiceSession serviceSession, String accountName,
			String password) throws AuthenticationException, SQLException {
		SysUserManage sysUserManage = serviceSession
				.getService(SysUserManage.class);
		return sysUserManage.readAccountId(accountName, password);
	}

	@Override
	public Rewriter getRewriter() {
		return rewriter;
	}

	@Override
	public boolean isStrictMVC() {
		return false;
	}

	@Override
	public void writeLog(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession,
			PasswordAuthentication authentication, int accountId) {
		SysUserManage sysUserManage = serviceSession
				.getService(SysUserManage.class);
		Controller controller = serviceSession.getController();
		String ip = controller.getRemoteAddr(request);
		try {
			sysUserManage.log(accountId, ip);
		} catch (Throwable e) {
			e.printStackTrace();
		}
	}
}
