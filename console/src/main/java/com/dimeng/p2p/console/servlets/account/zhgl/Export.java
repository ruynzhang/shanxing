package com.dimeng.p2p.console.servlets.account.zhgl;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.console.servlets.account.AbstractAccountServlet;
import com.dimeng.p2p.modules.account.console.service.ZhglManage;
import com.dimeng.p2p.modules.account.console.service.entity.User;
import com.dimeng.p2p.modules.account.console.service.query.UserQuery;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_ACCOUNT_EXPORT", name = "导出账号")
public class Export extends AbstractAccountServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			final HttpServletResponse response,
			final ServiceSession serviceSession) throws Throwable {
		ZhglManage manage = serviceSession.getService(ZhglManage.class);
		response.setHeader("Content-disposition", "attachment;filename="
				+ new Timestamp(System.currentTimeMillis()).getTime() + ".csv");
		response.setContentType("application/csv");
		UserQuery query = new UserQuery();
		query.parse(request);
		PagingResult<User> list = manage.search(query, new Paging() {

			@Override
			public int getSize() {
				return Integer.MAX_VALUE;
			}

			@Override
			public int getCurrentPage() {
				return IntegerParser.parse(request.getParameter(PAGING_CURRENT));
			}
		});
		manage.export(list.getItems(), response.getOutputStream(), "");
	}

}
