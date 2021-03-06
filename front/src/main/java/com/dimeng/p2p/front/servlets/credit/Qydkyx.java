package com.dimeng.p2p.front.servlets.credit;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S62.entities.T6281;
import com.dimeng.p2p.modules.bid.front.service.BidWillManage;
import com.dimeng.util.parser.IntegerParser;

public class Qydkyx extends AbstractCreditServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, final ServiceSession serviceSession)
			throws Throwable {
		BidWillManage manage = serviceSession.getService(BidWillManage.class);
		T6281 t6281 = new T6281();
		t6281.parse(request);
		t6281.F11 = IntegerParser.parse(request.getParameter("xian"));
		manage.add(t6281);
		getController().prompt(request, response, PromptLevel.ERROR,
				"提交成功！我们将尽快和您联系");
		sendRedirect(request, response,
				getController().getViewURI(request, Qydkyx.class));
	}
}
