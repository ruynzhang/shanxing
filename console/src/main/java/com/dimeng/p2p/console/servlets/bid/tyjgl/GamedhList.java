package com.dimeng.p2p.console.servlets.bid.tyjgl;

import java.math.BigDecimal;
import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.modules.bid.console.service.BidtyjManage;
import com.dimeng.p2p.modules.bid.console.service.entity.ExpemoneyGame;
import com.dimeng.p2p.modules.bid.console.service.query.TyjselgameQuery;
import com.dimeng.util.parser.IntegerParser;
import com.dimeng.util.parser.TimestampParser;

@Right(id = "P2P_C_BUSI_GAMEDHLIST", isMenu = true, name = "游戏兑换")
public class GamedhList extends AbstractBidServlet {
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
		//已兑换人数
		int ernum =bidManage.getExpegameNum();
		//未兑换人数
		int nernum = bidManage.getnotExpegameNum();
		//已兑换游戏总额
		BigDecimal eramount = bidManage.getExpegameAmount();
		//未兑换游戏总额
		BigDecimal ernoamount = bidManage.getgamenotAmount();
		//被邀人数
		int invinum = bidManage.getgameinviteNum();
		//游戏活动实名认证人数
		int relgamename = bidManage.getgamerelName();
		
		PagingResult<ExpemoneyGame> result =bidManage.SetyjgamePagin(new TyjselgameQuery(){
			@Override
			public String getinviteNum(){
				return request.getParameter("inviteNum");
				
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
		
		request.setAttribute("ernum", ernum);
		request.setAttribute("nernum",nernum);
		request.setAttribute("eramount",eramount);
		request.setAttribute("ernoamount",ernoamount);
		request.setAttribute("invinum",invinum);
		request.setAttribute("relgamename",relgamename);
		
		request.setAttribute("result", result);
		forwardView(request, response, getClass());
	}
}
