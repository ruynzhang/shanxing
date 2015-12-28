package com.dimeng.p2p.console.servlets.info.wzgg;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.http.upload.FileStore;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.LogicalException;
import com.dimeng.framework.service.exception.ParameterException;
import com.dimeng.p2p.common.enums.NoticePublishStatus;
import com.dimeng.p2p.common.enums.NoticeType;
import com.dimeng.p2p.modules.base.console.service.NoticeManage;
import com.dimeng.p2p.modules.base.console.service.entity.Notice;
import com.dimeng.p2p.modules.base.console.service.entity.NoticeRecord;
import com.dimeng.util.parser.EnumParser;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_INFO_WZGG_UPDATE", name = "修改网站公告")
public class UpdateWzgg extends AbstractWzggServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		NoticeManage manage = serviceSession.getService(NoticeManage.class);
		int id = IntegerParser.parse(request.getParameter("id"));
		NoticeRecord record = manage.get(id);
		if (record == null) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			return;
		}
		request.setAttribute("record", record);
		forwardView(request, response, getClass());
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		try {
			NoticeManage manage = serviceSession.getService(NoticeManage.class);

			Notice notice = new Notice() {

				@Override
				public NoticeType getType() {
					return EnumParser.parse(NoticeType.class,
							request.getParameter("type"));
				}

				@Override
				public String getTitle() {
					return request.getParameter("title");
				}

				@Override
				public NoticePublishStatus getPublishStatus() {
					return EnumParser.parse(NoticePublishStatus.class,
							request.getParameter("publishStatus"));
				}

				@Override
				public String getContent() {
					return getResourceProvider().getResource(FileStore.class)
							.encode(request.getParameter("content"));
				}
				
				@Override
				public String getHtml_title() {
					return request.getParameter("html_title");
				}

				@Override
				public String getHtml_keywords() {
					return request.getParameter("html_keywords");
				}

				@Override
				public String getHtml_description() {
					return request.getParameter("html_description");
				}
			};

			manage.update(IntegerParser.parse(request.getParameter("id")),
					notice);

			sendRedirect(request, response,
					getController().getURI(request, SearchWzgg.class));
		} catch (ParameterException | LogicalException e) {
			prompt(request, response, PromptLevel.ERROR, e.getMessage());
			processGet(request, response, serviceSession);
		}
	}

}
