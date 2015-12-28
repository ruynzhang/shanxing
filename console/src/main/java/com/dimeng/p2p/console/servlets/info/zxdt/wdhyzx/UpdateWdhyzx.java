package com.dimeng.p2p.console.servlets.info.zxdt.wdhyzx;

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

@Right(id = "P2P_C_INFO_WDHYZX_UPDATE", name = "修改网贷行业资讯")
public class UpdateWdhyzx extends AbstractInformationServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		try {
			ArticleVO article = new ArticleVO() ;
			article.parse(request);
			article.publishStatus=ArticlePublishStatus.valueOf(request.getParameter("status")); 
			ArticleManage manage = serviceSession
					.getService(ArticleManage.class);
			manage.update(IntegerParser.parse(request.getParameter("id")),
					article);
			sendRedirect(request, response,
					getController().getURI(request, SearchWdhyzx.class));
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
