package com.dimeng.p2p.front.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.bbs.client.Client;
import com.dimeng.p2p.bbs.client.ClientClub;

public class GetBbsLoginScript extends AbstractFrontServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request, HttpServletResponse response, ServiceSession serviceSession) throws Throwable {
		//String phpid = serviceSession.getSession().getAttribute("phprtid");
		String clubrtid = serviceSession.getSession().getAttribute("clubrtid");
		StringBuilder script = new StringBuilder();
		/**if (phpid != null) {
			int pucid = Integer.parseInt(phpid);
			if (pucid > 0) {
				Client e = new Client();
				String $ucsynlogin = e.uc_user_synlogin(pucid);
				//out.println($ucsynlogin);
				script.append($ucsynlogin);
			}
		}**/
		if (clubrtid != null) {
			int clubid = Integer.parseInt(clubrtid);
			if (clubid > 0) {
				ClientClub uc = new ClientClub();
				String $ucsynlogin2 = uc.uc_user_synlogin(clubid);
				script.append($ucsynlogin2);
				//out.println($ucsynlogin2);
			}
		}
		response.getWriter().print(script.toString());
	}

	@Override
	protected void processPost(HttpServletRequest request, HttpServletResponse response, ServiceSession serviceSession) throws Throwable {
	}

	@Override
	protected void onThrowable(HttpServletRequest request, HttpServletResponse response, Throwable throwable) throws ServletException, IOException {
	}
}
