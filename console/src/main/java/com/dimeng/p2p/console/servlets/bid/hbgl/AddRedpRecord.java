package com.dimeng.p2p.console.servlets.bid.hbgl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S10.entities.RedPacketRecord;
import com.dimeng.p2p.S71.enums.T7162_F06;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.service.RedPacketManage;
import com.dimeng.util.StringHelper;
import com.dimeng.util.parser.EnumParser;

public class AddRedpRecord extends AbstractBidServlet {
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
			RedPacketManage manage = serviceSession.getService(RedPacketManage.class);
			String userName = request.getParameter("uNames");
			T7162_F06 sendType = EnumParser.parse(T7162_F06.class,request.getParameter("sendType"));
			String[] userNames = new String[0];
			if (!StringHelper.isEmpty(userName)) {
				userNames = userName.split("\\s");
			}
			RedPacketRecord query = new RedPacketRecord();
			query.parse(request);// 设置界面传来的参数
			if (T7162_F06.SY == sendType) {
				userNames = manage.getUserNames();
			}
			manage.addRecord(serviceSession,query,userNames);
			getController().prompt(request, response, PromptLevel.WARRING,"保存成功");
			sendRedirect(request, response,getController().getURI(request, RedpRecordList.class));
		} catch (Exception e) {
			System.out.println(e);
			prompt(request, response, PromptLevel.ERROR, e.getMessage());
			processGet(request, response, serviceSession);
		}
	}
}
