package com.dimeng.p2p.console.servlets.info.zxdt.hlwjryj;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.http.upload.FileStore;
import com.dimeng.framework.http.upload.PartFile;
import com.dimeng.framework.http.upload.UploadFile;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.LogicalException;
import com.dimeng.framework.service.exception.ParameterException;
import com.dimeng.p2p.common.enums.ArticlePublishStatus;
import com.dimeng.p2p.console.servlets.info.AbstractInformationServlet;
import com.dimeng.p2p.modules.base.console.service.ArticleManage;
import com.dimeng.p2p.modules.base.console.service.entity.Article;
import com.dimeng.p2p.modules.base.console.service.entity.ArticleRecord;
import com.dimeng.util.parser.EnumParser;
import com.dimeng.util.parser.IntegerParser;
import com.dimeng.util.parser.TimestampParser;

@Right(id = "P2P_C_INFO_HLWJRYJ_UPDATE", name = "修改互联网金融研究")
public class UpdateHlwjryj extends AbstractInformationServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		try {
			Article article = new Article() {

				@Override
				public String getTitle() {
					return request.getParameter("title");
				}

				@Override
				public String getSummary() {
					return request.getParameter("summary");
				}

				@Override
				public String getSource() {
					return request.getParameter("source");
				}

				@Override
				public int getSortIndex() {
					return IntegerParser.parse(request
							.getParameter("sortIndex"));
				}

				@Override
				public ArticlePublishStatus getPublishStatus() {
					return EnumParser.parse(ArticlePublishStatus.class,
							request.getParameter("status"));
				}

				@Override
				public UploadFile getImage() throws Throwable {
					Part part = request.getPart("image");
					if (part == null || part.getContentType() == null
							|| part.getSize() == 0) {
						return null;
					}
					return new PartFile(part);
				}

				@Override
				public String getContent() {
					return getResourceProvider().getResource(FileStore.class)
							.encode(request.getParameter("content"));
				}

				@Override
				public Timestamp publishTime() {

					return TimestampParser.parse(request
							.getParameter("publishTime"));
				}
			};
			ArticleManage manage = serviceSession
					.getService(ArticleManage.class);
			manage.update(IntegerParser.parse(request.getParameter("id")),
					article);
			sendRedirect(request, response,
					getController().getURI(request, SearchHlwjryj.class));
		} catch (ParameterException | LogicalException e) {
			prompt(request, response, PromptLevel.ERROR, e.getMessage());
			processGet(request, response, serviceSession);
		}
	}

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		ArticleManage manage = serviceSession.getService(ArticleManage.class);
		ArticleRecord record = manage.get(IntegerParser.parse(request
				.getParameter("id")));
		if (record == null) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			return;
		}

		String content = manage.getContent(IntegerParser.parse(request
				.getParameter("id")));
		request.setAttribute("content", content);
		request.setAttribute("record", record);
		forwardView(request, response, getClass());
	}

}
