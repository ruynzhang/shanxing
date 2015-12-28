package com.dimeng.p2p.console.servlets.finance.fksh;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.p2p.modules.bid.console.service.BidtyjManage;
import com.dimeng.p2p.modules.bid.console.service.entity.ExpemonyAchieve;
import com.dimeng.p2p.modules.bid.console.service.entity.ExpemonyAchieveDetail;
import com.dimeng.p2p.modules.bid.console.service.query.TyjselcodeQuery;
import com.dimeng.util.parser.TimestampParser;

//@Right(id = "P2P_C_FINANCE_TYJACHIEVELISTEXPORT", name = "已领取体检金统计导出")
public class TyjAchieveDetailExport extends AbstractFinanceServlet {
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
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		ExpemonyAchieve ecr=new ExpemonyAchieve();
		if(createTimeStart!=null && !"".equals(createTimeStart)){
		ecr.createTimeStart =new Timestamp(sdf.parse(createTimeStart).getTime());
		}
		if(createTimeEnd!=null && !"".equals(createTimeEnd)){
			ecr.createTimeEnd =new Timestamp(sdf.parse(createTimeEnd).getTime());
		}
		ecr.account_name = account_name;
		ecr.ass_account = ass_account;
		ecr.username = username;
		ecr.sumtyj =BigDecimal.valueOf(Double.parseDouble(sumtyj));
		ecr.invemoney =BigDecimal.valueOf(Double.parseDouble(invemoney));
		ecr.noinvemoney =BigDecimal.valueOf(Double.parseDouble(noinvemoney));
		ecr.inveint =BigDecimal.valueOf(Double.parseDouble(inveint));
		
		
		
		
		ExpemonyAchieveDetail[] list=bidManage.seTyjAcDatilebefoExpor(new TyjselcodeQuery(){
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
		},Integer.parseInt(user_id)
			);
		 bidManage.exporExpemonyAchdetail(list, response.getOutputStream(),ecr, "GBK");
	}
	
	
}
