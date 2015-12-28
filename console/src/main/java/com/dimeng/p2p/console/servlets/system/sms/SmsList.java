package com.dimeng.p2p.console.servlets.system.sms;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.console.servlets.system.AbstractSystemServlet;
import com.dimeng.p2p.modules.systematic.console.service.SmsManage;
import com.dimeng.p2p.modules.systematic.console.service.entity.Sms;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_SYS_SMSLIST", isMenu = true, name = "短信推广")
public class SmsList extends AbstractSystemServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		SmsManage smsManage = serviceSession.getService(SmsManage.class);
		String name = request.getParameter("name");
		String beginTime = request.getParameter("createTimeStart");
		String endTime = request.getParameter("createTimeEnd");
		PagingResult<Sms> result = smsManage.serarch(name, beginTime, endTime,
				new Paging() {

					@Override
					public int getSize() {
						return 10;
					}

					@Override
					public int getCurrentPage() {
						return IntegerParser.parse(request
								.getParameter(PAGING_CURRENT));
					}
				});
		request.setAttribute("result", result);
		forwardView(request, response, getClass());
	}
}
