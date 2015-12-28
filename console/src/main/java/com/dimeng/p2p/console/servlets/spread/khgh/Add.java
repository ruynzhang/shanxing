package com.dimeng.p2p.console.servlets.spread.khgh;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S71.entities.T7166;
import com.dimeng.p2p.S71.enums.T7166_F03;
import com.dimeng.p2p.S71.enums.T7166_F04;
import com.dimeng.p2p.S71.enums.T7166_F07;
import com.dimeng.p2p.console.servlets.spread.AbstractSpreadServlet;
import com.dimeng.p2p.modules.base.console.service.KhghManage;
import com.dimeng.util.parser.SQLDateParser;

@Right(id = "P2P_C_SPREAD_KHGH_ADD", name = "新增客户关怀")
public class Add extends AbstractSpreadServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}
	
	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		try {
			KhghManage manage = serviceSession.getService(KhghManage.class);
			T7166 t7166 = new T7166();
			t7166.F03 = T7166_F03.parse(request.getParameter("type"));
			t7166.F04 = T7166_F04.parse(request.getParameter("channel"));
			t7166.F09 = SQLDateParser.parse(request.getParameter("sendTime"));
			t7166.F05 = request.getParameter("title");
			t7166.F06 = request.getParameter("content");
			t7166.F07 = T7166_F07.QY;
			t7166.F08 = serviceSession.getSession().getAccountId();
			manage.add(t7166);
			sendRedirect(request, response,
					getController().getURI(request, Search.class));
		} catch(Exception e){
			prompt(request, response, PromptLevel.ERROR, e.getMessage());
			forwardView(request, response, getClass());
		}
		
	}
}
