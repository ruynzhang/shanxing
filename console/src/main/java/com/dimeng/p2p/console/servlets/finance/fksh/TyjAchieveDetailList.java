package com.dimeng.p2p.console.servlets.finance.fksh;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.p2p.modules.bid.console.service.BidtyjManage;
import com.dimeng.p2p.modules.bid.console.service.entity.ExpemonyAchieveDetail;
import com.dimeng.p2p.modules.bid.console.service.query.TyjselcodeQuery;
import com.dimeng.util.parser.IntegerParser;
import com.dimeng.util.parser.TimestampParser;

// @Right(id = "P2P_C_FINANCE_TYJACHIEVEDETAILLIST", name = "已领取体验金统计明细")
public class TyjAchieveDetailList extends AbstractFinanceServlet {
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
		//已领取体验金明细
		String createTimeStart=request.getParameter("createTimeStart");
		String createTimeEnd=request.getParameter("createTimeEnd");
		String user_id=request.getParameter("user_id");
		String ass_account=request.getParameter("ass_account");
		String account_name=request.getParameter("account_name");
		String username=request.getParameter("username");
		String sumtyj=request.getParameter("sumtyj");
		String invemoney=request.getParameter("invemoney");
		String noinvemoney=request.getParameter("noinvemoney");
		String inveint=request.getParameter("inveint");
		
		PagingResult<ExpemonyAchieveDetail> result =bidManage.SetyjAchieveDetailPage(new TyjselcodeQuery(){
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
		},Integer.parseInt(user_id));
	
		request.setAttribute("createTimeStart", createTimeStart);
		request.setAttribute("createTimeEnd", createTimeEnd);
		request.setAttribute("user_id", user_id);
		request.setAttribute("ass_account", ass_account);
		request.setAttribute("account_name", account_name);
		request.setAttribute("username", username);
		request.setAttribute("sumtyj", sumtyj);
		request.setAttribute("invemoney", invemoney);
		request.setAttribute("noinvemoney", noinvemoney);
		request.setAttribute("inveint", inveint);
		request.setAttribute("result", result);
		forwardView(request, response, getClass());
	}
}
