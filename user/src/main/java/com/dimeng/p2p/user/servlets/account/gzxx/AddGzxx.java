package com.dimeng.p2p.user.servlets.account.gzxx;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.LogicalException;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.p2p.S61.entities.T6143;
import com.dimeng.p2p.account.user.service.UserBaseManage;
import com.dimeng.p2p.common.FormToken;
import com.dimeng.p2p.user.servlets.account.AbstractAccountServlet;
import com.dimeng.p2p.utlis.JfResource;
import com.dimeng.util.parser.IntegerParser;


public class AddGzxx extends AbstractAccountServlet{
	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		if(!FormToken.verify(serviceSession.getSession(), request.getParameter(FormToken.parameterName()))){
			throw new LogicalException("很抱歉，请不要重复提交请求！");
		}
		UserBaseManage manage = serviceSession.getService(UserBaseManage.class);
		int count = manage.seachGzxx(new Paging() {
			@Override
			public int getSize() {
				return 1;
			}
			@Override
			public int getCurrentPage() {
				return 1;
			}
		}).getItemCount();
		T6143 entity = new T6143();
		entity.parse(request);
		entity.F07 = IntegerParser.parse(request.getParameter("xian"));
		manage.addGzxx(entity);
		if(count == 0){
			//增加积分
			JfResource jfResource = getResourceProvider().getResource(JfResource.class);
			jfResource.addCredits(manage.getUserBase().userName, 17, null, true);
		}
		sendRedirect(request, response, getController().getURI(request, Gzxx.class));
	}
	
	
}
