package com.dimeng.p2p.console.servlets.info.xytk;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.http.upload.FileStore;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.LogicalException;
import com.dimeng.framework.service.exception.ParameterException;
import com.dimeng.p2p.common.enums.TermType;
import com.dimeng.p2p.console.servlets.info.gggl.AbstractAdvertiseServlet;
import com.dimeng.p2p.modules.base.console.service.TermManage;
import com.dimeng.p2p.modules.base.console.service.entity.TermRecord;
import com.dimeng.util.parser.EnumParser;

@Right(id = "P2P_C_INFO_XYTK_ADD", name = "增加协议条款")
public class AddXytk extends AbstractAdvertiseServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		forwardView(request, response, getClass());
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			final HttpServletResponse response,
			final ServiceSession serviceSession) throws Throwable {
		try {
			TermManage manage = serviceSession.getService(TermManage.class);
			String content = getResourceProvider().getResource(FileStore.class)
					.encode(request.getParameter("content"));
			TermRecord record = manage.get(EnumParser.parse(TermType.class,
					request.getParameter("type")));
			if (record == null) {
				manage.add(
						EnumParser.parse(TermType.class,
								request.getParameter("type")), content);
			} else {
				manage.update(
						EnumParser.parse(TermType.class,
								request.getParameter("type")), content);
			}

			sendRedirect(request, response,
					getController().getURI(request, SearchXytk.class));
		} catch (ParameterException | LogicalException e) {
			prompt(request, response, PromptLevel.ERROR, e.getMessage());
			processGet(request, response, serviceSession);
		}
	}

}
