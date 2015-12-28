package com.dimeng.p2p.console.servlets.system.letter;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.system.AbstractSystemServlet;
import com.dimeng.p2p.modules.systematic.console.service.LetterManage;
import com.dimeng.p2p.modules.systematic.console.service.entity.Letter;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_SYS_VIEWLETTER", name = "站内信推广查看")
public class ViewLetter extends AbstractSystemServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		LetterManage letterManage = serviceSession
				.getService(LetterManage.class);
		int id = IntegerParser.parse(request.getParameter("id"));
		Letter letter = letterManage.get(id);
		request.setAttribute("letter", letter);
		forwardView(request, response, getClass());
	}

	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		super.onThrowable(request, response, throwable);
	}

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {

	}
}
