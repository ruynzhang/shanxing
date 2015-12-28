package com.dimeng.p2p.front;

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
import com.dimeng.p2p.account.front.service.UserManage;
import com.dimeng.p2p.common.P2PSystemDefine;
import com.dimeng.p2p.front.config.FrontConst;

public class FrontDefine extends P2PSystemDefine implements FrontConst {

	protected final Rewriter rewriter;

	public FrontDefine() {
		super();
		schemas.put(SessionManager.class, DB_USER_SESSION);
		rewriter = new PackageRewriter("com.dimeng.p2p.front.servlets");
	}

	@Override
	public String getGUID() {
		return "136a3d03-9748-4f83-a54f-9b2a93f979a0";
	}

	@Override
	public int readAccountId(ServiceSession serviceSession, String condition,
			String password) throws AuthenticationException, SQLException {
		UserManage userManage = serviceSession.getService(UserManage.class);
		return userManage.readAccountId(condition, password);
	}

	@Override
	public void writeLog(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession,
			PasswordAuthentication authentication, int accountId) {
		UserManage userManage = serviceSession.getService(UserManage.class);
		Controller controller = serviceSession.getController();
		String ip = controller.getRemoteAddr(request);
		try {
			userManage.log(accountId, ip);
		} catch (Throwable e) {
			e.printStackTrace();
		}
	}

	@Override
	public Rewriter getRewriter() {
		return rewriter;
	}
}
