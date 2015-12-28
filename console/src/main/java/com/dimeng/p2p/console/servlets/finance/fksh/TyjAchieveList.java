package com.dimeng.p2p.console.servlets.finance.fksh;

import java.math.BigDecimal;
import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.p2p.modules.bid.console.service.BidtyjManage;
import com.dimeng.p2p.modules.bid.console.service.entity.ExpemonyAchieve;
import com.dimeng.p2p.modules.bid.console.service.query.TyjselcodeQuery;
import com.dimeng.util.parser.IntegerParser;
import com.dimeng.util.parser.TimestampParser;

@Right(id = "P2P_C_FINANCE_TYJACHIEVELIST", isMenu = true, name = "已领取体验金统计")
public class TyjAchieveList extends AbstractFinanceServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			final HttpServletResponse response,
			final ServiceSession serviceSession) throws Throwable {
		BidtyjManage bidManage = serviceSession.getService(BidtyjManage.class);
		
		
	
		//未使用的体验金总数(包括未到账的)
		BigDecimal suprsumcomeny = bidManage.getTyjsuprSumMoney().add(bidManage.getTyjNOtransSumMoney());
		
		//已使用的体验金总数
		BigDecimal transSumMoney = bidManage.getTyjtransSumMoney();
		
		
		
		//已获取总的体验金总数
		BigDecimal sumcomeny = suprsumcomeny.add(transSumMoney);
		
		
		
		
		PagingResult<ExpemonyAchieve> result =bidManage.SetyjAchievePage(new TyjselcodeQuery(){
			@Override
			public String getrandNum(){
				return request.getParameter("randNum");
				
			}
			
			@Override
			public  Timestamp getCreateTimeStart(){
				return TimestampParser.parse(request
						.getParameter("createTimeStart"));
			}
			
			@Override
			public Timestamp getCreateTimeEnd() {
				return TimestampParser.parse(request
						.getParameter("createTimeEnd"));
			}
			
			@Override
			public String getuserName(){
				return request.getParameter("userName");
			}
			
			@Override
			public  int getStatus(){
				if(request.getParameter("nastatus")==null){
					return 0;
				}else{
				    return Integer.parseInt(request.getParameter("nastatus"));
				}
			}
	      	}, new Paging() {
			@Override
			public int getSize() {
				return 10;
			}

			@Override
			public int getCurrentPage() {
				return IntegerParser.parse(request.getParameter(PAGING_CURRENT));
			}
		});
	
		request.setAttribute("sumcomeny", sumcomeny);
		request.setAttribute("transSumMoney", transSumMoney);
		request.setAttribute("suprsumcomeny", suprsumcomeny);
		request.setAttribute("result", result);
		forwardView(request, response, getClass());
	}
}
