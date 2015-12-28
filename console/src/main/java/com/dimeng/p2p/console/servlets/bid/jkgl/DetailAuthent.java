package com.dimeng.p2p.console.servlets.bid.jkgl;

import java.io.OutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S61.entities.T6122;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.modules.account.console.service.GrManage;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_BID_VIEWAUTHENTICATION", name = "查询个人认证信息")
public class DetailAuthent extends AbstractBidServlet {

	private static final long serialVersionUID = -268955794485557959L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		GrManage personalManage = serviceSession
				.getService(GrManage.class);
		int id = IntegerParser.parse(request.getParameter("id"));
		T6122 t6122 = personalManage.get(id);
		response.setContentType(t6122.F05);
		OutputStream out = response.getOutputStream();
		out.write(t6122.F02.getBytes(Long.parseLong("1"),
				(int) t6122.F02.length()));
	}
}
