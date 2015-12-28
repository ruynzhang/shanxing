package com.dimeng.p2p.pay.servlets;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.util.StringHelper;
import com.dimeng.util.parser.IntegerParser;

public class BidConfirm extends AbstractPayServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		int bid = IntegerParser.parse(request.getParameter("bid"));
		int actId = IntegerParser.parse(request.getParameter("actId"));
		String retUrl = request.getParameter("retUrl");
		String key = request.getParameter("key");
		StringBuilder builder = new StringBuilder();
		builder.append("bid=");
		builder.append(bid);
		builder.append("&actId=");
		builder.append(actId);
		builder.append("&retUrl=");
		builder.append(retUrl);
		String chkValue = StringHelper.digest(StringHelper.encode(builder
				.toString()));
		if (!key.equals(chkValue)) {
			PrintWriter writer = response.getWriter();
			writer.print("验证签名失败");
			writer.flush();
			writer.close();
		}
		
	}

}
