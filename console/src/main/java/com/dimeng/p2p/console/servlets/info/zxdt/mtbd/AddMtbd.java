package com.dimeng.p2p.console.servlets.info.zxdt.mtbd;

import javax.servlet.annotation.MultipartConfig;
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

@MultipartConfig
@Right(id = "P2P_C_INFO_MTBD_ADD", name = "增加媒体报道")
public class AddMtbd extends AbstractInformationServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(final HttpServletRequest request,
			final HttpServletResponse response,
			final ServiceSession serviceSession) throws Throwable {
		try {
			ArticleManage articleManage = serviceSession
					.getService(ArticleManage.class);
			ArticleVO article = new ArticleVO() ;
			article.parse(request);
			article.publishStatus=ArticlePublishStatus.valueOf(request.getParameter("status")); 
			articleManage.add(T5011_F02.MTBD, article);
			sendRedirect(request, response,
					getController().getURI(request, SearchMtbd.class));
		} catch (ParameterException | LogicalException e) {
			prompt(request, response, PromptLevel.ERROR, e.getMessage());
			processGet(request, response, serviceSession);
		}
	}

}
