package com.dimeng.p2p.console.servlets.spread.khgh;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S71.entities.T7166;
import com.dimeng.p2p.S71.enums.T7166_F03;
import com.dimeng.p2p.S71.enums.T7166_F04;
import com.dimeng.p2p.console.servlets.spread.AbstractSpreadServlet;
import com.dimeng.p2p.modules.base.console.service.KhghManage;
import com.dimeng.util.parser.IntegerParser;
import com.dimeng.util.parser.SQLDateParser;

@Right(id = "P2P_C_SPREAD_KHGH_UPDATE", name = "修改客户关怀")
public class Update extends AbstractSpreadServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		try {
			KhghManage manage = serviceSession.getService(KhghManage.class);
			request.setAttribute("entity", manage.get(IntegerParser.parse(request.getParameter("id"))));
			forwardView(request, response, getClass());
		} catch(Exception e) {
			prompt(request, response, PromptLevel.ERROR, e.getMessage());
			sendRedirect(request, response,
					getController().getURI(request, Search.class));
		}
	}
	
	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		try {
			KhghManage manage = serviceSession.getService(KhghManage.class);
			T7166 t7166 = new T7166();
			t7166.F01 = IntegerParser.parse(request.getParameter("id"));
			t7166.F03 = T7166_F03.parse(request.getParameter("type"));
			t7166.F04 = T7166_F04.parse(request.getParameter("channel"));
			t7166.F09 = SQLDateParser.parse(request.getParameter("sendTime"));
			t7166.F05 = request.getParameter("title");
			t7166.F06 = request.getParameter("content");
			manage.update(t7166);
			sendRedirect(request, response,
					getController().getURI(request, Search.class));
		} catch(Exception e){
			prompt(request, response, PromptLevel.ERROR, e.getMessage());
			forwardView(request, response, getClass());
		}
		
	}
}
