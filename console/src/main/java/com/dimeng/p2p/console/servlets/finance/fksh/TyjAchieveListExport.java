package com.dimeng.p2p.console.servlets.finance.fksh;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.p2p.modules.bid.console.service.BidtyjManage;
import com.dimeng.p2p.modules.bid.console.service.entity.ExpemonyAchieve;
import com.dimeng.p2p.modules.bid.console.service.query.TyjselcodeQuery;
import com.dimeng.util.parser.TimestampParser;

@Right(id = "P2P_C_FINANCE_TYJACHIEVELISTEXPORT", name = "已领取体检金统计导出")
public class TyjAchieveListExport extends AbstractFinanceServlet {
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
		response.setHeader("Content-disposition", "attachment;filename="
				+ new Timestamp(System.currentTimeMillis()).getTime() + ".csv");
		response.setContentType("application/csv");
		
		
		
		
		ExpemonyAchieve[] list=bidManage.seTyjAchievebefoExpor(new TyjselcodeQuery(){
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
		}
			);
		 bidManage.exporExpemonyAchieve(list, response.getOutputStream(), "GBK");
	}
}
