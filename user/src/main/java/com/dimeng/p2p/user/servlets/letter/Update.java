package com.dimeng.p2p.user.servlets.letter;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.account.user.service.LetterManage;
import com.dimeng.p2p.user.servlets.capital.AbstractCapitalServlet;
import com.dimeng.util.parser.IntegerParser;

public class Update extends AbstractCapitalServlet {

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
		int id = IntegerParser.parse(request.getParameter("id"));
		LetterManage letterManage = serviceSession
				.getService(LetterManage.class);
		if (id > 0) {
			letterManage.updateToRead(id);
		}
		PrintWriter writer = response.getWriter();
		writer.print(1);
		writer.flush();
		writer.close();
	}

}
