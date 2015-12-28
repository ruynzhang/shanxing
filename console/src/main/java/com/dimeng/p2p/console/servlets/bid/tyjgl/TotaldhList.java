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
import com.dimeng.p2p.modules.bid.console.service.entity.ExpemoneyTotal;
import com.dimeng.p2p.modules.bid.console.service.query.TyjselgameQuery;
import com.dimeng.util.parser.IntegerParser;
import com.dimeng.util.parser.TimestampParser;

@Right(id = "P2P_C_BUSI_TOTALDHLIST", isMenu = true, name = "体验金兑换统计")
public class TotaldhList extends AbstractBidServlet {
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
		//已兑换人数统计
		int totaldlnum =bidManage.getexpetotalNum();
		
		//已兑换总额
		BigDecimal ertotalamount = bidManage.getExpetotalMoney();
	
		//实名认证人数
		int reltotalname = bidManage.getexpetotalrelNum();
		
		//未兑换总额
		int notexpenum = bidManage.getnotExpecodeNum(1);
		int notexpeser = bidManage.getnotExpeserialNum(2);
		
		BigDecimal ernoamount = bidManage.getgamenotAmount();
		BigDecimal tnotdhmoney = BigDecimal.valueOf(ernoamount.doubleValue()+notexpenum*100+notexpeser*1000);
		
		
		PagingResult<ExpemoneyTotal> result =bidManage.SetyjtotalPagin(new TyjselgameQuery(){
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
		
		
		request.setAttribute("totaldlnum", totaldlnum);
		request.setAttribute("ertotalamount", ertotalamount);
		request.setAttribute("reltotalname", reltotalname);
		request.setAttribute("tnotdhmoney", tnotdhmoney);
		
		request.setAttribute("result", result);
		forwardView(request, response, getClass());
	}
}
