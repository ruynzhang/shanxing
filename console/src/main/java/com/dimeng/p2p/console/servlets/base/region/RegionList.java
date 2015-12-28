package com.dimeng.p2p.console.servlets.base.region;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.S50.entities.T5019;
import com.dimeng.p2p.S50.enums.T5019_F11;
import com.dimeng.p2p.S50.enums.T5019_F13;
import com.dimeng.p2p.console.servlets.base.AbstractBaseServlet;
import com.dimeng.p2p.modules.base.console.service.DistrictManage;
import com.dimeng.p2p.modules.base.console.service.query.RegionQuery;
import com.dimeng.util.parser.EnumParser;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_BASE_REGION_LIST", isMenu = true, name = "区域管理")
public class RegionList extends AbstractBaseServlet {
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
		DistrictManage districtManage = serviceSession
				.getService(DistrictManage.class);
		PagingResult<T5019> result = districtManage.search(new Paging() {
			@Override
			public int getSize() {
				return 10;
			}

			@Override
			public int getCurrentPage() {
				return IntegerParser.parse(request.getParameter(PAGING_CURRENT));
			}
		}, new RegionQuery() {

			@Override
			public T5019_F13 getStatus() {
				return EnumParser.parse(T5019_F13.class,
						request.getParameter("status"));
			}

			@Override
			public T5019_F11 getType() {
				return EnumParser.parse(T5019_F11.class,
						request.getParameter("type"));
			}

			@Override
			public String getName() {
				return request.getParameter("name");
			}

		});
		request.setAttribute("result", result);
		forwardView(request, response, getClass());
	}
}
