package com.dimeng.p2p.console.servlets.info.zxdt.wdhyzx;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.LogicalException;
import com.dimeng.framework.service.exception.ParameterException;
import com.dimeng.p2p.S50.enums.T5011_F02;
import com.dimeng.p2p.common.enums.ArticlePublishStatus;
import com.dimeng.p2p.console.servlets.info.AbstractInformationServlet;
import com.dimeng.p2p.modules.base.console.service.ArticleManage;
import com.dimeng.p2p.modules.base.console.service.entity.ArticleVO;

@Right(id = "P2P_C_INFO_WDHYZX_ADD", name = "增加网贷行业资讯")
public class AddWdhyzx extends AbstractInformationServlet {

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
			manage.add(T5011_F02.WDHYZX, article);
			sendRedirect(request, response,
					getController().getURI(request, SearchWdhyzx.class));
		} catch (ParameterException | LogicalException e) {
			prompt(request, response, PromptLevel.ERROR, e.getMessage());
			processGet(request, response, serviceSession);
		}
	}

}
