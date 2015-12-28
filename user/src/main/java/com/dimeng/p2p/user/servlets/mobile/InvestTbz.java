package com.dimeng.p2p.user.servlets.mobile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.S62.enums.T6230_F13;
import com.dimeng.p2p.modules.bid.user.service.WdzqManage;
import com.dimeng.p2p.modules.bid.user.service.entity.Tbzdzq;
import com.dimeng.util.Formater;
import com.dimeng.util.parser.IntegerParser;

public class InvestTbz extends AbstractMobileServlet {

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
		WdzqManage manage= serviceSession.getService(WdzqManage.class);
		PagingResult<Tbzdzq> list=manage.getLoanAssests(0,new Paging() {
			@Override
			public int getSize() {
				return size;
			}
			@Override
			public int getCurrentPage() {
				return page;
			}
		});
		Tbzdzq[] vos=list.getItems();
		StringBuilder buff = new StringBuilder();
		buff.append("{\"hasNext\":").append(list.getPageCount()>page).append(",");
		buff.append("\"content\":[");
		if (vos != null && vos.length > 0) {
			for (Tbzdzq vo : vos) {
				buff.append("{\"id\":\"").append(vo.F16).append("\",");
        		buff.append("\"bdName\":\"").append(vo.F02).append("\",");
        		buff.append("\"amount\":\"").append(Formater.formatAmount(vo.F13)).append("\",");
        		buff.append("\"proSj\":\"").append(Formater.formatAmount(vo.proSj)).append("\",");
        		buff.append("\"date\":\"").append(T6230_F13.F==vo.isSxbao?Formater.formatDate(vo.F10):"无").append("\"");
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
