package com.dimeng.p2p.console.servlets.finance.fksh;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S62.enums.T6230_F20;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.p2p.modules.bid.console.service.FkshManage;
import com.dimeng.util.StringHelper;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_FINANCE_BATCHFKSH", name = "批量放款")
public class BatchFksh extends AbstractFinanceServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			final HttpServletResponse response,
			final ServiceSession serviceSession) throws Throwable {
		FkshManage fkshManage = serviceSession.getService(FkshManage.class);
		String s = request.getParameter("ids");
		int[] ids = new int[0];
		if (!StringHelper.isEmpty(s)) {
			ids = IntegerParser.parseArray(s.split(","));
		}
		fkshManage.checkBatch(ids, T6230_F20.HKZ);
		sendRedirect(request, response,
				getController().getURI(request, FkshList.class));
	}
}
