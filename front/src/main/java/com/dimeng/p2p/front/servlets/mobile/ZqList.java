package com.dimeng.p2p.front.servlets.mobile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.modules.bid.front.service.TransferManage;
import com.dimeng.p2p.modules.bid.front.service.entity.Zqzqlb;
import com.dimeng.util.Formater;
import com.dimeng.util.StringHelper;
import com.dimeng.util.parser.IntegerParser;

/**
 * 债权转让列表
 * @author yangjh
 *
 */
public class ZqList extends AbstractMobileServlet {
	
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
		TransferManage service = serviceSession.getService(TransferManage.class);
		PagingResult<Zqzqlb> result = service.searchAccount(null,new Paging() {
			@Override
			public int getSize() {
				return size;
			}
			@Override
			public int getCurrentPage() {
				return page;
			}
		});
		Zqzqlb[] creditAssignments=result.getItems();
		StringBuilder buff = new StringBuilder();
		buff.append("{\"hasNext\":").append(result.getPageCount()>page).append(",");
		buff.append("\"content\":[");
		if(creditAssignments!=null){
  	      for (Zqzqlb vo:creditAssignments) {
        		buff.append("{\"id\":\"").append(vo.F25).append("\",");
        		buff.append("\"bdName\":\"").append(StringHelper.truncation(vo.F12, 12)).append("\",");
        		buff.append("\"rate\":\"").append(Formater.formatRate(vo.F14,false)).append("\",");
        		buff.append("\"qx\":\"").append(vo.F23 + "/"+vo.F22).append("\",");
        		buff.append("\"cyje\":\"").append(Formater.formatAmount(vo.F11)).append("\",");
        		buff.append("\"dsbx\":\"").append(Formater.formatAmount(vo.dsbx)).append("\",");
        		buff.append("\"zrje\":\"").append(Formater.formatAmount(vo.F02)).append("\"");
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
