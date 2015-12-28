package com.dimeng.p2p.console.servlets.info.zxdt.shzr;

import java.sql.Timestamp;

import javax.servlet.annotation.MultipartConfig;
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
import com.dimeng.p2p.console.servlets.info.AbstractInformationServlet;
import com.dimeng.p2p.modules.base.console.service.ArticleManage;
import com.dimeng.p2p.modules.base.console.service.entity.Article;
import com.dimeng.util.parser.EnumParser;
import com.dimeng.util.parser.IntegerParser;
import com.dimeng.util.parser.TimestampParser;

@MultipartConfig
@Right(id = "P2P_C_INFO_SHZR_ADD", name = "增加社会责任")
public class AddShzr extends AbstractInformationServlet {

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
						throw new ParameterException("封面图片不能为空.");
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
			manage.add(T5011_F02.SHZR, article);
			sendRedirect(request, response,
					getController().getURI(request, SearchShzr.class));
		} catch (ParameterException | LogicalException e) {
			prompt(request, response, PromptLevel.ERROR, e.getMessage());
			processGet(request, response, serviceSession);
		}

	}

}
