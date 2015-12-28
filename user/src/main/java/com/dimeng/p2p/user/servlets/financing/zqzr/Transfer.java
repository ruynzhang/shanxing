package com.dimeng.p2p.user.servlets.financing.zqzr;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.LogicalException;
import com.dimeng.framework.service.exception.ParameterException;
import com.dimeng.p2p.modules.bid.user.service.ZqzrManage;
import com.dimeng.p2p.modules.bid.user.service.query.addTransfer;
import com.dimeng.p2p.user.servlets.financing.AbstractFinancingServlet;
import com.dimeng.p2p.variables.defines.SystemVariable;
import com.dimeng.util.parser.BigDecimalParser;
import com.dimeng.util.parser.IntegerParser;

public class Transfer extends AbstractFinancingServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = -6826337769817263673L;
	
	@Override
	protected void processPost(final HttpServletRequest request,
			final HttpServletResponse response,final ServiceSession serviceSession)
			throws Throwable {
		
		final ZqzrManage finacingManage=serviceSession.getService(ZqzrManage.class);
		//final BigDecimal mayMoney = finacingManage.getDslx(IntegerParser.parse(request.getParameter("jkbId")));
		final ConfigureProvider configureProvider = getResourceProvider()
				.getResource(ConfigureProvider.class);
		finacingManage.transfer(new addTransfer() {
			
			@Override
			public BigDecimal getRateMoney() {
				return new BigDecimal(configureProvider.getProperty(SystemVariable.ZQZRGLF_RATE));
			}
			
			@Override
			public BigDecimal getTransferValue() {
				return BigDecimalParser.parse(request.getParameter("zrValue"));
			}
			
			@Override
			public int getTransferId() {
				return IntegerParser.parse(request.getParameter("zqId"));
			}
			
			
			@Override
			public BigDecimal getBidValue() {
				return BigDecimalParser.parse(request.getParameter("zqValue"));
			}
		});
		
		sendRedirect(request, response, getController().getViewURI(request, Zqzrz.class));
	}
	
	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		getResourceProvider().log(throwable);
		if (throwable instanceof SQLException) {
			getController().prompt(request, response, PromptLevel.ERROR,
					"系统繁忙，请您稍后再试");
			sendRedirect(request, response, getController().getViewURI(request, Zqkzc.class));
		} else if (throwable instanceof LogicalException || throwable instanceof ParameterException) {
			getController().prompt(request, response, PromptLevel.WARRING,
					throwable.getMessage());
			sendRedirect(request, response, getController().getViewURI(request, Zqkzc.class));
		} else {
			super.onThrowable(request, response, throwable);
		}
	}

}
