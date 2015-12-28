package com.dimeng.p2p.console.servlets.spread.khgh;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S71.enums.T7166_F07;
import com.dimeng.p2p.console.servlets.spread.AbstractSpreadServlet;
import com.dimeng.p2p.modules.base.console.service.KhghManage;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_SPREAD_KHGH_CHANGESTATUS", name = "停用或启用客户关怀")
public class ChangeStatus extends AbstractSpreadServlet {
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
			serviceSession.getService(KhghManage.class)
				.changeStatus(IntegerParser.parse(request.getParameter("id")), T7166_F07.parse(request.getParameter("status")));
		} catch(Exception e){
			prompt(request, response, PromptLevel.ERROR, e.getMessage());
		}
		sendRedirect(request, response,
				getController().getURI(request, Search.class));
	}
}
