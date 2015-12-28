package com.dimeng.p2p.console.servlets.bid.sxbaogl;

import java.math.BigDecimal;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.LogicalException;
import com.dimeng.framework.service.exception.ParameterException;
import com.dimeng.p2p.S62.entities.SxbaoConfig;
import com.dimeng.p2p.S62.entities.T6230;
import com.dimeng.p2p.S62.entities.T6231;
import com.dimeng.p2p.S62.entities.T6238;
import com.dimeng.p2p.S62.enums.T6230_F12;
import com.dimeng.p2p.S62.enums.T6230_F17;
import com.dimeng.p2p.S62.enums.T6230_F27;
import com.dimeng.p2p.S62.enums.T6231_F21;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.modules.bid.console.service.BidManage;
import com.dimeng.p2p.service.SxbaoManage;
import com.dimeng.util.parser.DateParser;

@Right(id = "P2P_C_FINANCE_RELEASESXBAO", name = "发售善行宝")
public class ReleaseSxbao extends AbstractBidServlet{
	
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void processGet(HttpServletRequest request, HttpServletResponse response, ServiceSession serviceSession) throws Throwable {
		processPost(request, response, serviceSession);
	}
	
	@Override
	protected void processPost(HttpServletRequest request, HttpServletResponse response, ServiceSession serviceSession) throws Throwable {
		BidManage bidManage = serviceSession.getService(BidManage.class);
		SxbaoManage sxbaoManage = serviceSession.getService(SxbaoManage.class);
		serviceSession.openTransactions();
		Long cid = Long.valueOf(request.getParameter("id"));
		SxbaoConfig sxbaoConfig = sxbaoManage.findConfigById(cid);
		try{
			if(sxbaoConfig.bid != null){
				throw new LogicalException("不能重复发售");
			}
			T6230 t6230 = new T6230();
			t6230.F02 = sxbaoConfig.loaner.intValue();
			t6230.F03 = sxbaoConfig.title + DateParser.format(new Date(), "yyyyMMdd");
			t6230.F04 = 1;
			BigDecimal money = new BigDecimal("99999999999999");
			t6230.F05 = money;
			t6230.F06 = sxbaoConfig.rate.multiply(new BigDecimal(100));
			t6230.F07 = money;
			t6230.F08 = 365;
			t6230.F09 = sxbaoConfig.loanPeriod.intValue();
			t6230.F10 = sxbaoConfig.mode;
			t6230.F12 = T6230_F12.BXQEDB;
			t6230.F17 = T6230_F17.ZRY;
			t6230.F18 = 1;
			t6230.F19 = 1;
			t6230.F27 = T6230_F27.F;
			T6231 t6231 = new T6231();
			t6231.F07 = 440303;
			t6231.F08 = sxbaoConfig.title;
			t6231.F09 = sxbaoConfig.title;
			t6231.F16 = sxbaoConfig.title;
			T6238 t6238 = new T6238();
			t6238.F02 = BigDecimal.ZERO;
			t6238.F03 = BigDecimal.ZERO;
			t6238.F04 = BigDecimal.ZERO;
			t6231.F21 = T6231_F21.F;
			t6231.F22 = 0;
			sxbaoConfig.bid = Long.valueOf(bidManage.add(t6230, t6231, t6238));
			sxbaoManage.updateBid(sxbaoConfig);
			serviceSession.commit();
			getController().prompt(request, response, PromptLevel.INFO,
					"发售成功");
		} catch (Throwable throwable) {
			if (throwable instanceof ParameterException
					|| throwable instanceof LogicalException) {
				getController().prompt(request, response, PromptLevel.WARRING,
						throwable.getMessage());
			} else {
				super.onThrowable(request, response, throwable);
			}
		}
		sendRedirect(request, response,
				getController().getURI(request, SxbaoList.class));
	}
	
}
