package com.dimeng.p2p.user.servlets.mobile;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.common.enums.QueryType;
import com.dimeng.p2p.modules.bid.user.service.BidManage;
import com.dimeng.p2p.modules.bid.user.service.WdzqManage;
import com.dimeng.p2p.modules.bid.user.service.entity.BackOffList;
import com.dimeng.p2p.modules.bid.user.service.entity.Bdxq;
import com.dimeng.p2p.modules.bid.user.service.query.BackOffQuery;
import com.dimeng.util.Formater;
import com.dimeng.util.StringHelper;
import com.dimeng.util.parser.EnumParser;
import com.dimeng.util.parser.IntegerParser;

public class BackMoney extends AbstractMobileServlet {

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
		WdzqManage offManage =  serviceSession.getService(WdzqManage.class);
		BidManage bidManage = serviceSession.getService(BidManage.class);
		PagingResult<BackOffList> list=offManage.searchList(new BackOffQuery() {
			@Override
			public Date getTimeStart() {
				return null;
			}
			@Override
			public Date getTimeEnd() {
				return null;
			}
			@Override
			public QueryType getQueryType() {
				String queryType = request.getParameter("queryType");
				if(!StringHelper.isEmpty(queryType)){
					return EnumParser.parse(QueryType.class, queryType);
				}
				return QueryType.DS;
			}
		}, new Paging() {
			@Override
			public int getSize() {
				return size;
			}
			@Override
			public int getCurrentPage() {
				return page;
			}
		});
		BackOffList[] vos=list.getItems();
		StringBuilder buff = new StringBuilder();
		buff.append("{\"hasNext\":").append(list.getPageCount()>page).append(",");
		buff.append("\"content\":[");
		if (vos != null && vos.length > 0) {
			for (BackOffList vo : vos) {
				Bdxq bdxq =bidManage.get(vo.jkbId);
				buff.append("{\"id\":\"").append(vo.assestsId).append("\",");
        		buff.append("\"bdName\":\"").append(bdxq.F03).append("\",");
        		buff.append("\"amount\":\"").append(Formater.formatAmount(vo.money)).append("\",");
        		buff.append("\"date\":\"").append(Formater.formatDate(vo.receiveDate)).append("\"");
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
