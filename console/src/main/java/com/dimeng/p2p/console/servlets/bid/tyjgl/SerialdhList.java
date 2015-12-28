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
import com.dimeng.p2p.modules.bid.console.service.entity.ExpemoneyCode;
import com.dimeng.p2p.modules.bid.console.service.query.TyjselcodeQuery;
import com.dimeng.util.parser.IntegerParser;
import com.dimeng.util.parser.TimestampParser;

@Right(id = "P2P_C_BUSI_KLDHLIST", isMenu = true, name = "口令兑换")
public class SerialdhList extends AbstractBidServlet {
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
		//ExpemoneyCode query =new ExpemoneyCode();
		//设置页面传来的参数
		//query.parse(request);
		//已兑换序号人数
		int type = 2;
		int expenum =bidManage.getExpecodeNum(type);
		//未兑换序号人数
		int notexpenum = bidManage.getnotExpeserialNum(type);
		//已兑换口令总额
		BigDecimal expesumme = bidManage.getExpecodeMoney(type);
		//口令活动实名认证人数
		int relcodename = bidManage.getExpecoderelNum(type);
		
		PagingResult<ExpemoneyCode> result =bidManage.SetyjcodePagin(new TyjselcodeQuery(){
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
		},type);
		request.setAttribute("expenum", expenum);
		request.setAttribute("notexpenum", notexpenum);
		request.setAttribute("expesumme", expesumme);
		request.setAttribute("relcodename", relcodename);
		request.setAttribute("result", result);
		forwardView(request, response, getClass());
	}
}
