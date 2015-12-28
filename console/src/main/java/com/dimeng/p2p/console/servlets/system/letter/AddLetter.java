package com.dimeng.p2p.console.servlets.system.letter;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S71.enums.T7160_F07;
import com.dimeng.p2p.console.servlets.system.AbstractSystemServlet;
import com.dimeng.p2p.modules.systematic.console.service.LetterManage;
import com.dimeng.util.StringHelper;
import com.dimeng.util.parser.EnumParser;

@Right(id = "P2P_C_SYS_ADDLETTER", name = "添加站内信推广")
public class AddLetter extends AbstractSystemServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		LetterManage letterManage = serviceSession
				.getService(LetterManage.class);
		T7160_F07 sendType = EnumParser.parse(T7160_F07.class,
				request.getParameter("sendType"));
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String userName = request.getParameter("userName");
		String[] userNames = new String[0];
		if (!StringHelper.isEmpty(userName)) {
			userNames = userName.split("\\s");
		}
		letterManage.addLetter(sendType, title, content, userNames);
		sendRedirect(request, response,
				getController().getURI(request, LetterList.class));
	}

	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		super.onThrowable(request, response, throwable);
	}
}
