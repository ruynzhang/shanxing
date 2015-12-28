package com.dimeng.p2p.front.servlets.mobile;

import java.math.BigDecimal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.joda.time.DateTime;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.S62.entities.T6231;
import com.dimeng.p2p.S62.enums.T6230_F20;
import com.dimeng.p2p.S62.enums.T6231_F21;
import com.dimeng.p2p.modules.bid.front.service.BidManage;
import com.dimeng.p2p.modules.bid.front.service.entity.Bdlb;
import com.dimeng.util.Formater;
import com.dimeng.util.StringHelper;
import com.dimeng.util.parser.IntegerParser;
import com.dimeng.util.parser.TimestampParser;

/**
 * 标的列表
 * @author yangjh
 *
 */
public class List extends AbstractMobileServlet {
	
	private static final long serialVersionUID = 1L;

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
		BidManage bidManage = serviceSession.getService(BidManage.class);
		PagingResult<Bdlb> result = bidManage.searchQyAccount(null,null,new Paging() {
			@Override
			public int getSize() {
				return size;
			}
			@Override
			public int getCurrentPage() {
				return page;
			}
		});
		Bdlb[] creditInfos=result.getItems();
		StringBuilder buff = new StringBuilder();
		buff.append("{\"hasNext\":").append(result.getPageCount()>page).append(",");
		buff.append("\"content\":[");
		if (creditInfos != null && creditInfos.length > 0) {
        	for(int i = 0, len = creditInfos.length; i < len; i++){ 
        		Bdlb creditInfo = creditInfos[i];
        		T6231 t6231 = bidManage.getExtra(creditInfo.F02);
        		buff.append("{\"id\":\"").append(creditInfo.F02).append("\",");
        		buff.append("\"investName\":\"").append(creditInfo.investName).append("\",");
        		buff.append("\"bdName\":\"").append(StringHelper.truncation(creditInfo.F04, 12)).append("\",");
        		buff.append("\"rate\":\"").append(Formater.formatRate(creditInfo.F07.subtract(creditInfo.bonus.divide(new BigDecimal("100"))),false)).append("\",");
        		buff.append("\"qx\":\"").append(T6231_F21.S == creditInfo.F19?creditInfo.F20 + "天":creditInfo.F10 + "个月").append("\",");
        		if(creditInfo.F06.intValue()>=10000){
        			buff.append("\"amount\":\"").append(Formater.formatAmount(creditInfo.F06.doubleValue()/10000)+"万").append("\",");
        		}else{
        			buff.append("\"amount\":\"").append(Formater.formatAmount(creditInfo.F06)).append("\",");
        		}
        		buff.append("\"bonus\":\"").append(Formater.formatAmount(creditInfo.bonus)).append("\",");
        		buff.append("\"hkfs\":\"").append(creditInfo.F21.getChineseName()).append("\",");
        		boolean flag=new DateTime(creditInfo.F13).plusDays(creditInfo.F09).getMillis() - System.currentTimeMillis() <= 0;
        		if((T6230_F20.TBZ==creditInfo.F11 || T6230_F20.DFK==creditInfo.F11) && flag){
        			buff.append("\"status\":\"").append("已完结").append("\",");
        		}else{
        			buff.append("\"status\":\"").append(creditInfo.F11.getChineseName()).append("\",");
        		}
        		if(T6230_F20.YFB==creditInfo.F11){
        			buff.append("\"dateTime\":\"").append(TimestampParser.format(creditInfo.F13,"yyyy-MM-dd HH:mm")).append("\",");
        		}else if(T6230_F20.YJQ==creditInfo.F11){
        			buff.append("\"dateTime\":\"").append(Formater.formatDate(t6231.F13)).append("\",");
        		}else{
        			buff.append("\"dateTime\":\"").append(Formater.formatDate(t6231.F11)).append("\",");
        		}
        		buff.append("\"proess\":").append((int)(creditInfo.proess*100));
        		buff.append("},");
        	}
        	buff.deleteCharAt(buff.length() - 1);
		}
		buff.append("]}");
		response.setContentType("text/html;charset="
				+ getResourceProvider().getCharset());
		response.getWriter().print(buff.toString());
		response.getWriter().flush();
		
	}
}
