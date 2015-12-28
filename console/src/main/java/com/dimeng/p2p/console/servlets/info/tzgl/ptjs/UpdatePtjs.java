package com.dimeng.p2p.console.servlets.info.tzgl.ptjs;

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
import com.dimeng.p2p.S50.enums.T5011_F02;
import com.dimeng.p2p.common.enums.ArticlePublishStatus;
import com.dimeng.p2p.modules.base.console.service.ArticleManage;
import com.dimeng.p2p.modules.base.console.service.entity.Article;
import com.dimeng.p2p.modules.base.console.service.entity.ArticleRecord;
import com.dimeng.util.parser.IntegerParser;
import com.dimeng.util.parser.TimestampParser;

@Right(id = "P2P_C_INFO_PTJS_UPDATE", isMenu = true, name = "平台介绍")
public class UpdatePtjs extends AbstractPtjsServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		try {
			ArticleManage manage = serviceSession
					.getService(ArticleManage.class);
			Article article = new Article() {

				@Override
				public String getTitle() {
					return T5011_F02.PTJS.getChineseName();
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
					return ArticlePublishStatus.YFB;
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
			ArticleRecord exist = manage.get(T5011_F02.PTJS);
			if (exist == null) {
				manage.add(T5011_F02.PTJS, article);
			} else {
				manage.update(exist.id, article);
			}
			processGet(request, response, serviceSession);
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
		String content = manage.getContent(T5011_F02.PTJS);
		request.setAttribute("content", content);
		forwardView(request, response, getClass());
	}
}
