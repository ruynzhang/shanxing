package com.dimeng.p2p.console.servlets.bid.lcgl.zqzrgl;

import java.sql.Timestamp;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.S62.enums.T6260_F07;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.modules.financial.console.service.CreditorTransferManage;
import com.dimeng.p2p.modules.financial.console.service.entity.TransferDsh;
import com.dimeng.p2p.modules.financial.console.service.query.TransferDshQuery;
import com.dimeng.util.parser.DateParser;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_BUSI_ZQZR", isMenu=true, name = "债权转让管理")
public class TransferDshList extends AbstractBidServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}
	
	@Override
	protected void processPost(final HttpServletRequest request,final HttpServletResponse response,
			final ServiceSession serviceSession) throws Throwable {
		CreditorTransferManage creditorTransferManage = serviceSession.getService(CreditorTransferManage.class);
		PagingResult<TransferDsh> transferDshs = creditorTransferManage.transferDshSearch(new TransferDshQuery() {
			@Override
			public Timestamp getCreateTimeStart() {
				Date date = DateParser.parse(request
						.getParameter("createTimeStart"));
				return date == null ? null : new Timestamp(date.getTime());
			}
			
			@Override
			public Timestamp getCreateTimeEnd() {
				Date date = DateParser.parse(request
						.getParameter("createTimeEnd"));
				return date == null ? null : new Timestamp(date.getTime());
			}
		},T6260_F07.DSH, new Paging() {
			
			@Override
			public int getSize() {
				return 10;
			}

			@Override
			public int getCurrentPage() {
				return IntegerParser.parse(request.getParameter(PAGING_CURRENT));
			}
		});
		
		request.setAttribute("transferDshs", transferDshs);
		
		forwardView(request, response, getClass());
	}

}
