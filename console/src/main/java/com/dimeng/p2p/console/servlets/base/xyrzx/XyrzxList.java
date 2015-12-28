package com.dimeng.p2p.console.servlets.base.xyrzx;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.S51.entities.T5123;
import com.dimeng.p2p.S51.enums.T5123_F03;
import com.dimeng.p2p.S51.enums.T5123_F04;
import com.dimeng.p2p.console.servlets.base.AbstractBaseServlet;
import com.dimeng.p2p.modules.base.console.service.CreditCertificationManage;
import com.dimeng.p2p.modules.base.console.service.entity.AttestationQuery;
import com.dimeng.util.parser.EnumParser;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_BASE_XYRZXLIST", isMenu = true, name = "信用认证项管理")
public class XyrzxList extends AbstractBaseServlet {
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
		CreditCertificationManage creditCertificationManage = serviceSession
				.getService(CreditCertificationManage.class);
		PagingResult<T5123> result = creditCertificationManage.search(
				new AttestationQuery() {

					@Override
					public T5123_F03 getType() {
						return EnumParser.parse(T5123_F03.class,
								request.getParameter("type"));
					}

					@Override
					public T5123_F04 getStatus() {
						return EnumParser.parse(T5123_F04.class,
								request.getParameter("status"));
					}

					@Override
					public int getScore() {
						return 0;
					}

					@Override
					public String getName() {
						return request.getParameter("name");
					}

					@Override
					public int getId() {
						return 0;
					}
				}, new Paging() {

					@Override
					public int getSize() {
						return 10;
					}

					@Override
					public int getCurrentPage() {
						return IntegerParser.parse(request
								.getParameter(PAGING_CURRENT));
					}
				});

		request.setAttribute("result", result);
		forwardView(request, response, getClass());
	}

}
