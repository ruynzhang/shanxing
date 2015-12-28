package com.dimeng.p2p.user.servlets.mobile;

import java.io.PrintWriter;
import java.math.BigDecimal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.S61.enums.T6101_F03;
import com.dimeng.p2p.account.user.service.ZjlsManage;
import com.dimeng.p2p.account.user.service.entity.CapitalLs;
import com.dimeng.p2p.modules.base.front.service.TradeTypeManage;
import com.dimeng.util.Formater;
import com.dimeng.util.StringHelper;
import com.dimeng.util.parser.DateTimeParser;
import com.dimeng.util.parser.IntegerParser;

public class FdetailList extends AbstractMobileServlet{
	private static final long serialVersionUID = 1L;
	
	@Override
	protected boolean mustAuthenticated() {
		return true;
	}

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		final int size=IntegerParser.parse(request.getParameter("size"));
		final int page=IntegerParser.parse(request.getParameter("page"));
		ZjlsManage manage = serviceSession.getService(ZjlsManage.class);
		
		//资金账户
		String zhlx = StringHelper.isEmpty(request.getParameter("zhlx"))?"WLZH":request.getParameter("zhlx") ;
		T6101_F03 f03 = null;
		if(!StringHelper.isEmpty(zhlx)){
			f03 = T6101_F03.valueOf(zhlx);
		}else{
			f03 = T6101_F03.WLZH;
		}
		
	    Paging paging = new Paging() {
			
			@Override
			public int getSize() {
				return size;
			}
			
			@Override
			public int getCurrentPage() {
				return page;
			}
		};
		
		PagingResult<CapitalLs> result = manage.searchLs(0,null,null,f03, paging);
		
		
		TradeTypeManage tradeTypeManage = serviceSession.getService(TradeTypeManage.class);
		 
		CapitalLs[] CapitalLss=result.getItems();
		StringBuilder buff = new StringBuilder();
		buff.append("{\"hasNext\":").append(result.getPageCount()>page).append(",");
		buff.append("\"content\":[");
		if (CapitalLss != null && CapitalLss.length > 0) {
        	for(int i = 0, len = CapitalLss.length; i < len; i++){ 
        		CapitalLs capitalLs = CapitalLss[i];
        		buff.append("{\"crDatetime\":\"").append(DateTimeParser.format(capitalLs.F05,"yyyy-MM-dd HH:mm")).append("\",");
        		buff.append("\"typeName\":\"").append(tradeTypeManage.get(capitalLs.F03)).append("\",");
        		buff.append("\"gcrMoney\":\"").append(capitalLs.F06.compareTo(BigDecimal.ZERO)==1?Formater.formatAmount(capitalLs.F06):"").append("\",");
        		buff.append("\"raMoney\":\"").append(capitalLs.F07.compareTo(BigDecimal.ZERO)==1?Formater.formatAmount(capitalLs.F07):"").append("\"");
        		buff.append("},");
        	}
        	buff.deleteCharAt(buff.length() - 1);
		}
		buff.append("]}");
		response.setContentType("text/html;charset="
				+ getResourceProvider().getCharset());
		response.getWriter().print(buff.toString());
		response.getWriter().flush();

//		writeJsonMsg(buff.toString(), response);
	}
	

public static void writeJsonMsg(String content, HttpServletResponse response) {
		PrintWriter out = null;// 写返回值
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=" + "UTF-8");
		response.setHeader("cache-control", "no-cache");
		response.setDateHeader("expires", 0);
		try {
			out = response.getWriter();
			if (content==null||content.trim().equals("")) {
				out.write("");
			} else {
				out.write(content);
			}
			out.flush();
			out.close();
		} catch (Exception e) {
			throw new RuntimeException("写内容到客户端(Json格式)异常", e);
		}
	}


}
