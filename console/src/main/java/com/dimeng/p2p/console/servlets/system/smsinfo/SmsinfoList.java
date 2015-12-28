package com.dimeng.p2p.console.servlets.system.smsinfo;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.common.SmsRecord;
import com.dimeng.p2p.console.servlets.system.AbstractSystemServlet;
import com.dimeng.p2p.modules.systematic.console.service.SmsManage;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_SYS_SMSINFOLIST", isMenu = true, name = "短信发送管理")
public class SmsinfoList extends AbstractSystemServlet {
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
		String mobile = request.getParameter("mobile");
		String beginTime = request.getParameter("createTimeStart");
		String endTime = request.getParameter("createTimeEnd");
		PagingResult<SmsRecord> result = smsManage.serarchsmsinfo(mobile, beginTime, endTime,
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
