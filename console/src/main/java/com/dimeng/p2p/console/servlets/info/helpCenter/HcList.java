package com.dimeng.p2p.console.servlets.info.helpCenter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.console.servlets.info.AbstractInformationServlet;
import com.dimeng.p2p.modules.base.console.service.HelpCenterManage;
import com.dimeng.p2p.modules.base.console.service.entity.HelpCenterVO;
import com.dimeng.util.parser.IntegerParser;
@Right(id = "P2P_C_INFO_HELPCENTER_HCLIST", isMenu = true, name = "帮助中心")
public class HcList extends AbstractInformationServlet {

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
		HelpCenterManage manage=serviceSession.getService(HelpCenterManage.class);
		HelpCenterVO vo=new HelpCenterVO();
		vo.parse(request);
		PagingResult<HelpCenterVO> list=manage.paging(vo, new Paging() {
			@Override
			public int getSize() {

				return 10;
			}
			@Override
			public int getCurrentPage() {
				return IntegerParser
						.parse(request.getParameter(PAGING_CURRENT));
			}
		});
		request.setAttribute("list", list);
		forwardView(request, response, getClass());
	}

}
