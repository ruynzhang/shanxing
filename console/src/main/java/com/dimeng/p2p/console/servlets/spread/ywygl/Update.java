package com.dimeng.p2p.console.servlets.spread.ywygl;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.http.session.authentication.AuthenticationException;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.ParameterException;
import com.dimeng.p2p.console.servlets.spread.AbstractSpreadServlet;
import com.dimeng.p2p.modules.salesman.console.service.SalesmanManage;
import com.dimeng.p2p.modules.salesman.console.service.query.SalesmanQuery;
@Right(id = "P2P_C_SPREAD_TGXQ_SEARCH", isMenu=true, name = "修改业务员信息")
public class Update extends AbstractSpreadServlet{

	private static final long serialVersionUID = 1L;
	
	
	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		final SalesmanManage manage = serviceSession.getService(SalesmanManage.class);
		try{
			String str = manage.searchTel(request.getParameter("tel"));
			final String ywyId = request.getParameter("ywyId");
			if(str != null && !str.equals(ywyId)  && !str.isEmpty()){
				throw new ParameterException("手机号已存在");
			}
			
			
			manage.update(new SalesmanQuery() {
				@Override
				public String ywyId() {
					return ywyId;
				}
				
				@Override
				public String tel() {
					return request.getParameter("tel");
				}
				
				@Override
				public String name() {
					return request.getParameter("name");
				}
			});
			sendRedirect(request, response, getController().getURI(request, SalesmanList.class));
		}catch (AuthenticationException e) {
		}
	}
	
	
	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		final String ywyId = request.getParameter("ywyId");
		getResourceProvider().log(throwable);
		if (throwable instanceof ParameterException
				|| throwable instanceof SQLException) {
			getController().prompt(request, response, PromptLevel.ERROR,
					throwable.getMessage());
			sendRedirect(request, response, getController().getURI(request, UpdateSalesman.class)+"?ywyId="+ywyId);
		}  else {
			super.onThrowable(request, response, throwable);
		}
	}


}
