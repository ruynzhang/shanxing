package com.dimeng.p2p.console.servlets.account.grxx;

import java.sql.Timestamp;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.S62.enums.T6230_F20;
import com.dimeng.p2p.console.servlets.account.AbstractAccountServlet;
import com.dimeng.p2p.modules.account.console.service.GrManage;
import com.dimeng.p2p.modules.account.console.service.entity.BasicInfo;
import com.dimeng.p2p.modules.account.console.service.entity.TenderRecord;
import com.dimeng.p2p.modules.account.console.service.query.TenderRecordQuery;
import com.dimeng.util.parser.DateParser;
import com.dimeng.util.parser.EnumParser;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_ACCOUNT_GRVIEW", name = "查询个人账号详情")
public class TbjlView extends AbstractAccountServlet {

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
		GrManage manage = serviceSession.getService(GrManage.class);
		int userId = IntegerParser.parse(request.getParameter("userId"));
		BasicInfo basicInfo = manage.findBasicInfo(userId);
		if (basicInfo == null) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			return;
		}
		PagingResult<TenderRecord> tenderRecords = manage.findTenderRecord(
				new TenderRecordQuery() {

					@Override
					public int getUserId() {
						return IntegerParser.parse(request
								.getParameter("userId"));
					}

					@Override
					public String getTenderRecordTitle() {
						return request.getParameter("tenderRecordTitle");
					}

					@Override
					public String getTenderRecordId() {
						return request.getParameter("tenderRecordId");
					}

					@Override
					public T6230_F20 getTenderRecordState() {
						return EnumParser.parse(T6230_F20.class,
								request.getParameter("loanRecordState"));
					}

					@Override
					public Timestamp getCreateTimeStart() {
						Date date = DateParser.parse(request
								.getParameter("createTimeStart"));
						return date == null ? null : new Timestamp(date
								.getTime());
					}

					@Override
					public Timestamp getCreateTimeEnd() {
						Date date = DateParser.parse(request
								.getParameter("createTimeEnd"));
						return date == null ? null : new Timestamp(date
								.getTime());
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

		request.setAttribute("basicInfo", basicInfo);
		request.setAttribute("tenderRecords", tenderRecords);
		forwardView(request, response, getClass());
	}

}
