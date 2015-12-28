package com.dimeng.p2p.user.servlets.bid;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.resource.ResourceProvider;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.LogicalException;
import com.dimeng.framework.service.exception.ParameterException;
import com.dimeng.p2p.variables.defines.URLVariable;
import com.dimeng.util.parser.IntegerParser;

public class Yxlc extends AbstractBidServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = -7876567899014690119L;

	protected String getURL(int yxId) throws IOException {
		ResourceProvider resourceProvider = getResourceProvider();
		final ConfigureProvider configureProvider = resourceProvider
				.getResource(ConfigureProvider.class);
		StringBuilder url = new StringBuilder(
				configureProvider.format(URLVariable.FINANCING_YX_XQ));
		url.append(Integer.toString(yxId)).append(
				resourceProvider.getSystemDefine().getRewriter()
						.getViewSuffix());
		return url.toString();
	}

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
	/*	int yxId=IntegerParser.parse(request.getParameter("yxId"));
		CreditBestManage bestManage = serviceSession.getService(CreditBestManage.class);
		bestManage.BidBest(yxId, new BigDecimal(request.getParameter("gmMoney")));
		getController().prompt(request, response, PromptLevel.INFO, "恭喜你，投标成功");
		sendRedirect(request, response, getURL(yxId));*/
	}
	
	
	
	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)throws ServletException, IOException {
				getResourceProvider().log(throwable.getMessage());
				int yxId=IntegerParser.parse(request.getParameter("yxId"));
				if (throwable instanceof ParameterException
						|| throwable instanceof SQLException) {
					throwable.printStackTrace();
					getController().prompt(request, response, PromptLevel.ERROR,
							"系统繁忙，请您稍后再试");
					sendRedirect(request, response, getURL(yxId));
			
				} else if (throwable instanceof LogicalException) {
					getController().prompt(request, response, PromptLevel.WARRING,
							throwable.getMessage());
					sendRedirect(request, response, getURL(yxId));
				} else {
					super.onThrowable(request, response, throwable);
				}
	}
}
