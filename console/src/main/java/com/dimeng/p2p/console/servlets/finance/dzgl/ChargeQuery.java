package com.dimeng.p2p.console.servlets.finance.dzgl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.S65.entities.T6501;
import com.dimeng.p2p.S65.entities.T6502;
import com.dimeng.p2p.escrow.huichao.entity.ChargeItem;
import com.dimeng.p2p.escrow.huichao.entity.HCPagingResult;
import com.dimeng.p2p.escrow.huichao.function.model.ResultVo;
import com.dimeng.p2p.escrow.huichao.function.util.FunctionClientUtil;
import com.dimeng.p2p.escrow.huichao.service.ChargeManage;
import com.dimeng.util.StringHelper;
import com.dimeng.util.parser.DateParser;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_FINANCE_CHARGEQUERY", isMenu = true, name = "充值对账")
public class ChargeQuery extends AbstractDzglServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		final int pageNum = IntegerParser.parse(request
				.getParameter(PAGING_CURRENT));
		Map<String,String> map=new HashMap<String,String>();
		int page_index=pageNum>0?pageNum:1;
		map.put("page_index",page_index+"");
		map.put("mode", "recharge");
		PagingResult<ChargeItem> pagingResult=this.getChargeQuery(map,serviceSession);
//		ChargeQueryManage manage = serviceSession
//				.getService(ChargeQueryManage.class);
//		PagingResult<ChargeItem> pagingResult = manage.query(new QueryCond() {
//
//			@Override
//			public String pageSize() {
//				return String.valueOf(20);
//			}
//
//			@Override
//			public String pageNum() {
//				return pageNum > 0 ? String.valueOf(pageNum) : "1";
//			}
//
//			@Override
//			public String endDate() {
//				return DateParser.format(date, "yyyyMMdd");
//			}
//
//			@Override
//			public String beginDate() {
//				return DateParser.format(date, "yyyyMMdd");
//			}
//		});
		request.setAttribute("pagingResult", pagingResult);
		forward(request, response,
				getController().getViewURI(request, getClass()));
	}
	
	private PagingResult<ChargeItem>  getChargeQuery(Map<String,String> map,ServiceSession serviceSession) throws Throwable{
		HCPagingResult<ChargeItem> pagingResult=new HCPagingResult<ChargeItem>();
		ResultVo result=FunctionClientUtil.sendTradeQuery(map,this.getResourceProvider());
		if(result.getErrorNo()>=0){
			Map<String, Object> data=result.getData();
			Set<String> keysSet=data.keySet();
			String [] keys=new String[keysSet.size()];
			keys=keysSet.toArray(keys);
			Arrays.sort(keys);
			for(String key:keys){
				Object value=data.get(key);
				if(value!=null){
					if("pageSize".equalsIgnoreCase(key)){
						pagingResult.setPageSize(Integer.parseInt(value.toString()));
					}else if("pageIndex".equalsIgnoreCase(key)){
						pagingResult.setCurrentPage(Integer.parseInt(value.toString()));
					}else if("tradeList".equalsIgnoreCase(key)){
						List<Map<String,String>> tradeList =(List<Map<String,String>>)value;
						List<ChargeItem> items=new ArrayList<ChargeItem>();
						for(Map tradMap:tradeList){
							String outTradeNo=tradMap.get("outTradeNo").toString();
							int orderId=0;
							if(outTradeNo.indexOf("_")!=-1){
								orderId=Integer.parseInt(outTradeNo.split("_")[1]);
							}else{
								if(outTradeNo.length()>9){
									outTradeNo="0";
								}
								orderId=Integer.parseInt(outTradeNo);
							}
							ChargeManage chargeManage=serviceSession.getService(ChargeManage.class);
							T6501 t6501=chargeManage.selectT6501(orderId);
							
							if(t6501!=null){
								T6502 t6502=chargeManage.selectT6502(t6501.F01);
								if(t6502!=null){
									ChargeItem item=new ChargeItem();
									item.setOrdId(orderId+"");
									item.setFeeAmt(t6502.F04+"");
									item.setOrdDate(t6501.F04+"");
									item.setTransAmt(t6502.F03+"");
									item.setTransStat(tradMap.get("tradeStatus").toString());
									items.add(item);
								}
								
							}
							
						}
						ChargeItem[] a=new ChargeItem[items.size()];
						if(keysSet.contains("resultCount")){
							try{
								int resultCount=IntegerParser.parse(data.get("resultCount"));
								pagingResult.setCount(resultCount);
							}catch(Exception ex){
								
							}
							
						}
						
						pagingResult.setList(items.toArray(a));
					}
				}
				
			}
		}
		return pagingResult;
	}

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		if (StringHelper.isEmpty(startDate) && StringHelper.isEmpty(endDate)) {
			processGet(request, response, serviceSession);
			return;
		}
		if (StringHelper.isEmpty(startDate)) {
			request.setAttribute("errorMsg", "请选择起始时间");
			processGet(request, response, serviceSession);
			return;
		}
		if (StringHelper.isEmpty(endDate)) {
			request.setAttribute("errorMsg", "请选择结束时间");
			processGet(request, response, serviceSession);
			return;
		}
		final Date sDate = DateParser.parse(startDate, "yyyy-MM-dd");
		final Date eDate = DateParser.parse(endDate, "yyyy-MM-dd");
		if (sDate.getTime() > eDate.getTime()) {
			request.setAttribute("errorMsg", "时间范围错误，起始时间不能大于结束时间");
			processGet(request, response, serviceSession);
			return;
		}
		final int pageNum = IntegerParser.parse(request
				.getParameter(PAGING_CURRENT));
//		ChargeQueryManage manage = serviceSession
//				.getService(ChargeQueryManage.class);
//		PagingResult<ChargeItem> pagingResult = manage.query(new QueryCond() {
//
//			@Override
//			public String pageSize() {
//				return String.valueOf(20);
//			}
//
//			@Override
//			public String pageNum() {
//				return pageNum > 0 ? String.valueOf(pageNum) : "1";
//			}
//
//			@Override
//			public String endDate() {
//				return DateParser.format(eDate, "yyyyMMdd");
//			}
//
//			@Override
//			public String beginDate() {
//				return DateParser.format(sDate, "yyyyMMdd");
//			}
//		});
		Map<String,String> map=new HashMap<String,String>();
		int page_index=pageNum>0?pageNum:1;
		map.put("page_index",page_index+"");
		map.put("mode", "recharge");
		map.put("begin_time",startDate);
		map.put("end_time",endDate);
		PagingResult<ChargeItem> pagingResult=this.getChargeQuery(map,serviceSession);
		request.setAttribute("pagingResult", pagingResult);
		forward(request, response,
				getController().getViewURI(request, getClass()));
	}
}
