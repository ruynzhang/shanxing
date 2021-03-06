package com.dimeng.p2p.console.servlets.bid.htgl;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.S61.enums.T6110_F06;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.modules.bid.console.service.PtdzxyManage;
import com.dimeng.p2p.modules.bid.console.service.entity.Qyjkxy;
import com.dimeng.p2p.modules.bid.console.service.query.DzxyQuery;
import com.dimeng.util.parser.IntegerParser;
import com.dimeng.util.parser.TimestampParser;

@Right(id = "P2P_C_BUSI_DZXY", isMenu=true, name = "电子协议")
public class GrjkDzxy extends AbstractBidServlet {

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
		PtdzxyManage ptdzxyManage = serviceSession.getService(PtdzxyManage.class);
		PagingResult<Qyjkxy>  result=ptdzxyManage.search(new DzxyQuery() {
			
			@Override
			public String getName() {
				return request.getParameter("name");
			}
			
			@Override
			public Timestamp getCreateTimeStart() {
				return TimestampParser.parse(request
						.getParameter("createTimeStart"));
			}
			
			@Override
			public Timestamp getCreateTimeEnd() {
				return TimestampParser.parse(request
						.getParameter("createTimeEnd"));
			}
		},T6110_F06.ZRR, new Paging() {

			@Override
			public int getSize() {
				return 10;
			}

			@Override
			public int getCurrentPage() {
				return IntegerParser.parse(request.getParameter(PAGING_CURRENT));
			}
		});
		request.setAttribute("result", result);
		forwardView(request, response, getClass());
	}
}
