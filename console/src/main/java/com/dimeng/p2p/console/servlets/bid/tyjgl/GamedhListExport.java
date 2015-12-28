package com.dimeng.p2p.console.servlets.bid.tyjgl;


import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.modules.bid.console.service.BidtyjManage;
import com.dimeng.p2p.modules.bid.console.service.entity.ExpemoneyCode;
import com.dimeng.p2p.modules.bid.console.service.entity.ExpemoneyGame;
import com.dimeng.p2p.modules.bid.console.service.query.TyjselcodeQuery;
import com.dimeng.p2p.modules.bid.console.service.query.TyjselgameQuery;
import com.dimeng.util.parser.TimestampParser;

@Right(id = "P2P_C_BUSI_GAMEDHLISTEXPORT", name = "游戏兑换列表导出")
public class GamedhListExport extends AbstractBidServlet {
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
		response.setHeader("Content-disposition", "attachment;filename="
				+ new Timestamp(System.currentTimeMillis()).getTime() + ".csv");
		response.setContentType("application/csv");
		
		BidtyjManage bidManage = serviceSession.getService(BidtyjManage.class);
		
		ExpemoneyGame[] list =bidManage.seproemGame(new TyjselgameQuery(){
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
	      	});
		
		  bidManage.exporExpogame(list, response.getOutputStream(), "GBK");
	}
}
