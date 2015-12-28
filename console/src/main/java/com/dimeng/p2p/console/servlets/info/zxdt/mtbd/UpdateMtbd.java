package com.dimeng.p2p.console.servlets.info.zxdt.mtbd;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.LogicalException;
import com.dimeng.framework.service.exception.ParameterException;
import com.dimeng.p2p.common.enums.ArticlePublishStatus;
import com.dimeng.p2p.console.servlets.info.AbstractInformationServlet;
import com.dimeng.p2p.modules.base.console.service.ArticleManage;
import com.dimeng.p2p.modules.base.console.service.entity.ArticleRecord;
import com.dimeng.p2p.modules.base.console.service.entity.ArticleVO;
import com.dimeng.util.parser.IntegerParser;

@MultipartConfig
@Right(id = "P2P_C_INFO_MTBD_UPDATE", name = "修改媒体报道")
public class UpdateMtbd extends AbstractInformationServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		ArticleManage articleManage = serviceSession
				.getService(ArticleManage.class);
		ArticleRecord record = articleManage.get(IntegerParser.parse(request
				.getParameter("id")));
		if (record == null) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			return;
		}
		request.setAttribute("record", record);
		request.setAttribute("content", articleManage.getContent(record.id));
		forwardView(request, response, getClass());
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			final HttpServletResponse response,
			final ServiceSession serviceSession) throws Throwable {
		try {
			ArticleManage articleManage = serviceSession
					.getService(ArticleManage.class);
			ArticleVO article = new ArticleVO();
			article.parse(request);
			article.publishStatus=ArticlePublishStatus.valueOf(request.getParameter("status"));
			articleManage.update(
					IntegerParser.parse(request.getParameter("id")), article);
			sendRedirect(request, response,
					getController().getURI(request, SearchMtbd.class));
		} catch (ParameterException | LogicalException e) {
			prompt(request, response, PromptLevel.ERROR, e.getMessage());
			processGet(request, response, serviceSession);
		}
	}

}
