package com.dimeng.p2p.user.servlets.letter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.account.user.service.LetterManage;
import com.dimeng.p2p.user.servlets.capital.AbstractCapitalServlet;
import com.dimeng.util.parser.IntegerParser;

public class Delete extends AbstractCapitalServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		String[] ids = request.getParameterValues("letterId");
		if (ids != null && ids.length > 0) {
			int[] idArr = new int[ids.length];
			for (int i = 0; i < ids.length; i++) {
				idArr[i] = IntegerParser.parse(ids[i]);
			}

			LetterManage letterManage = serviceSession
					.getService(LetterManage.class);
			letterManage.delete(idArr);
		}
		sendRedirect(request, response,
				getController().getViewURI(request, Index.class));
	}
}
