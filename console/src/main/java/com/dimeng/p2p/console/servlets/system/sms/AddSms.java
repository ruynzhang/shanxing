package com.dimeng.p2p.console.servlets.system.sms;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.message.sms.SmsSender;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S71.enums.T7162_F06;
import com.dimeng.p2p.console.servlets.system.AbstractSystemServlet;
import com.dimeng.p2p.modules.systematic.console.service.SmsManage;
import com.dimeng.util.StringHelper;
import com.dimeng.util.parser.EnumParser;

@Right(id = "P2P_C_SYS_ADDSMS", name = "添加短信推广")
public class AddSms extends AbstractSystemServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		SmsManage smsManage = serviceSession.getService(SmsManage.class);
		SmsSender smsSender = serviceSession.getService(SmsSender.class);
		T7162_F06 sendType = EnumParser.parse(T7162_F06.class,
				request.getParameter("sendType"));
		String content = request.getParameter("content");
		String mobile = request.getParameter("mobile");
		String[] mobiles = new String[0];
		if (!StringHelper.isEmpty(mobile)) {
			mobiles = mobile.split("\\s");
		}
		List<String> mobileLists = new ArrayList<>();
		for (String s : mobiles) {
			if (!StringHelper.isEmpty(s) && !mobileLists.contains(s)) {
				mobileLists.add(s);
			}
		}
		smsManage.addSms(sendType, content,
				mobileLists.toArray(new String[mobileLists.size()]));
		if (T7162_F06.SY == sendType) {
			mobiles = smsManage.getUserMobiles();
			smsSender.send(0, content, mobiles);
		} else if (T7162_F06.ZDR == sendType) {
			smsSender.send(0, content,
					mobileLists.toArray(new String[mobileLists.size()]));
		}
		sendRedirect(request, response,
				getController().getURI(request, SmsList.class));
	}

	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		super.onThrowable(request, response, throwable);
	}
}
