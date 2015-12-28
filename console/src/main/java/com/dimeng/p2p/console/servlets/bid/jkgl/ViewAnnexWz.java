package com.dimeng.p2p.console.servlets.bid.jkgl;

import java.io.OutputStream;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S62.entities.T6233;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.modules.bid.console.service.AnnexManage;
import com.dimeng.util.parser.IntegerParser;

//@Right(id = "P2P_C_LOAN_ADDLOAN", name = "上传马赛克附件")
@MultipartConfig
public class ViewAnnexWz extends AbstractBidServlet {

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
		AnnexManage annexManage = serviceSession.getService(AnnexManage.class);
		int id = IntegerParser.parse(request.getParameter("id"));
		T6233 t6233 = annexManage.getFgk(id);
		response.setContentType(t6233.F04);
		OutputStream out = response.getOutputStream();
		out.write(t6233.F06.getBytes(Long.parseLong("1"),
				(int) t6233.F06.length()));
	}
}
