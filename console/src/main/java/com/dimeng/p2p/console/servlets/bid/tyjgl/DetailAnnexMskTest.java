package com.dimeng.p2p.console.servlets.bid.tyjgl;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.modules.bid.console.service.AnnexManage;
import com.dimeng.p2p.modules.bid.console.service.entity.MskAnnex;
import com.dimeng.util.parser.IntegerParser;

@MultipartConfig
public class DetailAnnexMskTest extends AbstractBidServlet {

	private static final long serialVersionUID = -268955794485557959L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		AnnexManage annexManage = serviceSession.getService(AnnexManage.class);
		int loanId = IntegerParser.parse(request.getParameter("loanId"));
		MskAnnex[] mortFiles = annexManage.searchMortFiles(loanId);
		request.setAttribute("mortFiles", mortFiles);
		request.setAttribute("loadId", loanId);
		forwardView(request, response, getClass());
	}
}
