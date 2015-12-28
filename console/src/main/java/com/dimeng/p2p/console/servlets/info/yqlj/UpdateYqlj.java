package com.dimeng.p2p.console.servlets.info.yqlj;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.LogicalException;
import com.dimeng.framework.service.exception.ParameterException;
import com.dimeng.p2p.modules.base.console.service.FriendlyLinkManage;
import com.dimeng.p2p.modules.base.console.service.entity.FriendlyLink;
import com.dimeng.p2p.modules.base.console.service.entity.FriendlyLinkRecord;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_INFO_YQLJ_UPDATE", name = "修改友情链接")
public class UpdateYqlj extends AbstractYqljServlet {

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		FriendlyLinkManage manamge = serviceSession
				.getService(FriendlyLinkManage.class);
		int id = IntegerParser.parse(request.getParameter("id"));
		FriendlyLinkRecord record = manamge.get(id);
		if (record == null) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			return;
		}
		request.setAttribute("record", record);
		forwardView(request, response, getClass());
	}

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		try {
			FriendlyLink link = new FriendlyLink() {

				@Override
				public String getURL() {
					return request.getParameter("url");
				}

				@Override
				public int getSortIndex() {
					return Integer.parseInt(request.getParameter("sortIndex"));
				}

				@Override
				public String getName() {
					return request.getParameter("name");
				}
				@Override
				public String getNofollow() {
					return request.getParameter("nofollow");
				}
			};
			FriendlyLinkManage manage = serviceSession
					.getService(FriendlyLinkManage.class);
			manage.update(IntegerParser.parse(request.getParameter("id")), link);
			sendRedirect(request, response,
					getController().getURI(request, SearchYqlj.class));
		} catch (ParameterException | LogicalException e) {
			prompt(request, response, PromptLevel.ERROR, e.getMessage());
			processGet(request, response, serviceSession);
		}
	}

}
