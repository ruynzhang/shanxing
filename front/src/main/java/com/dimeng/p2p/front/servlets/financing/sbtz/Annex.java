package com.dimeng.p2p.front.servlets.financing.sbtz;

import java.io.OutputStream;
import java.sql.Blob;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.front.servlets.financing.AbstractFinancingServlet;
import com.dimeng.p2p.modules.bid.front.service.BidManage;
import com.dimeng.util.parser.IntegerParser;

public class Annex extends AbstractFinancingServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		int id = IntegerParser.parse(request.getParameter("id"));
		BidManage investManage = serviceSession
				.getService(BidManage.class);
		Blob blob = investManage.getAttachment(id);
		if (blob != null) {
			OutputStream out = response.getOutputStream();
			out.write(blob.getBytes(Long.parseLong("1"), (int) blob.length()));
		}
	}
}
