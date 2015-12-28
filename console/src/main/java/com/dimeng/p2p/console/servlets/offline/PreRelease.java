package com.dimeng.p2p.console.servlets.offline;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.LogicalException;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.modules.bid.console.service.OfflineManage;
import com.dimeng.util.parser.IntegerParser;
import com.dimeng.util.parser.TimestampParser;

@Right(id = "P2P_C_BID_PRERELEASE", name = "标的预发布")
public class PreRelease extends AbstractBidServlet {

	private static final long serialVersionUID = -268955794485557959L;

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
		try {
			int loanId = IntegerParser.parse(request.getParameter("loanId"));
			Timestamp releaseTime = TimestampParser.parse(request
					.getParameter("releaseTime"));
			Timestamp now = new Timestamp(System.currentTimeMillis());
			if (releaseTime.getTime() <= now.getTime()) {
				throw new LogicalException("预发布时间不能小于当前时间");
			}
			OfflineManage bidManage = serviceSession
					.getService(OfflineManage.class);
			bidManage.preRelease(loanId, releaseTime);
		} catch (Throwable throwable) {
			getController().prompt(request, response, PromptLevel.WARRING,
					throwable.getMessage());
		}
		sendRedirect(request, response,
				getController().getURI(request, OfflineLoanList.class));
	}
}
