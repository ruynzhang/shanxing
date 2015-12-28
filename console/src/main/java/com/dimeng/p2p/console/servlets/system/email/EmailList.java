package com.dimeng.p2p.console.servlets.system.email;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.console.servlets.system.AbstractSystemServlet;
import com.dimeng.p2p.modules.systematic.console.service.EmailManage;
import com.dimeng.p2p.modules.systematic.console.service.entity.Email;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_SYS_EMAILLIST", isMenu = true, name = "邮件推广")
public class EmailList extends AbstractSystemServlet {
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
		EmailManage emailManage = serviceSession.getService(EmailManage.class);
		String title = request.getParameter("title");
		String name = request.getParameter("name");
		String beginTime = request.getParameter("createTimeStart");
		String endTime = request.getParameter("createTimeEnd");
		PagingResult<Email> result = emailManage.search(title, name, beginTime,
				endTime, new Paging() {

					@Override
					public int getSize() {
						return IntegerParser.parse(request
								.getParameter("paging.size"));
					}

					@Override
					public int getCurrentPage() {
						return IntegerParser.parse(request
								.getParameter("paging.current"));
					}
				});
		request.setAttribute("result", result);
		forwardView(request, response, EmailList.class);
	}
}
