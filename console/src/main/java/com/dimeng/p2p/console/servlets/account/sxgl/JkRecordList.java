package com.dimeng.p2p.console.servlets.account.sxgl;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.console.servlets.account.AbstractAccountServlet;
import com.dimeng.p2p.modules.account.console.service.AccountManage;
import com.dimeng.p2p.modules.account.console.service.entity.JkRecordVO;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_ACCOUNT_JKRECORDLIST", isMenu = true, name = "借款记录管理")
public class JkRecordList extends AbstractAccountServlet {

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
		AccountManage manage = serviceSession.getService(AccountManage.class);
		JkRecordVO query = new JkRecordVO();
		query.parse(request);//设置界面传来的参数
		//借款记录分页
		PagingResult<JkRecordVO> list = manage.JkRecordPagin(query, new Paging() {
			@Override
			public int getSize() {
				return 10;
			}
			@Override
			public int getCurrentPage() {
				return IntegerParser.parse(request.getParameter(PAGING_CURRENT));
			}
		});
		request.setAttribute("list", list);
		//全部标的号
		Map<Integer, String> bidList=manage.getBdxx();
		request.setAttribute("bidList", bidList);
		forwardView(request, response, getClass());
	}
}
