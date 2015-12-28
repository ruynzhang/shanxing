package com.dimeng.p2p.console.servlets.system.email;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.message.email.EmailSender;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S71.enums.T7164_F07;
import com.dimeng.p2p.console.servlets.system.AbstractSystemServlet;
import com.dimeng.p2p.modules.systematic.console.service.EmailManage;
import com.dimeng.util.StringHelper;
import com.dimeng.util.parser.EnumParser;

@Right(id = "P2P_C_SYS_ADDEMAIL", name = "添加邮件推广")
public class AddEmail extends AbstractSystemServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		EmailManage emailManage = serviceSession.getService(EmailManage.class);
		EmailSender emailSender = serviceSession.getService(EmailSender.class);
		T7164_F07 sendType = EnumParser.parse(T7164_F07.class,
				request.getParameter("sendType"));
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String email = request.getParameter("email");
		String[] emails = new String[0];
		if (!StringHelper.isEmpty(email)) {
			emails = email.split("\\s");
		}
		List<String> emailLists = new ArrayList<>();
		for (String s : emails) {
			if (!StringHelper.isEmpty(s) && !emailLists.contains(s)) {
				emailLists.add(s);
			}
		}
		emailManage.addEmail(sendType, title, content,
				emailLists.toArray(new String[emailLists.size()]));
		if (sendType == T7164_F07.SY) {
			emails = emailManage.getUserEmails();
			emailSender.send(0, title, content, emails);
		} else if (sendType == T7164_F07.ZDR) {
			emailSender.send(0, title, content,
					emailLists.toArray(new String[emailLists.size()]));
		}
		sendRedirect(request, response,
				getController().getURI(request, EmailList.class));
	}

	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		super.onThrowable(request, response, throwable);
	}
}
