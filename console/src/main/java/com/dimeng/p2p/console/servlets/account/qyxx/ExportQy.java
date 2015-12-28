package com.dimeng.p2p.console.servlets.account.qyxx;

import java.sql.Timestamp;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.S61.enums.T6110_F07;
import com.dimeng.p2p.console.servlets.account.AbstractAccountServlet;
import com.dimeng.p2p.modules.account.console.service.EnterpriseManage;
import com.dimeng.p2p.modules.account.console.service.entity.Enterprise;
import com.dimeng.p2p.modules.account.console.service.query.EnterpriseQuery;
import com.dimeng.util.parser.DateParser;
import com.dimeng.util.parser.EnumParser;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_ACCOUNT_QYEXPORT", name = "导出企业账号")
public class ExportQy extends AbstractAccountServlet {
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
		EnterpriseManage manager = serviceSession.getService(EnterpriseManage.class);
		response.setHeader("Content-disposition", "attachment;filename="
				+ new Timestamp(System.currentTimeMillis()).getTime() + ".csv");
		response.setContentType("application/csv");
		PagingResult<Enterprise> list = manager.enterpriseSearch(new EnterpriseQuery(){

			@Override
			public String getUserId() {
				return request.getParameter("userId");
			}

			@Override
			public String getName() {
				return request.getParameter("userName");
			}

			@Override
			public String getContacts() {
				return request.getParameter("msisdn");
			}

			@Override
			public String getContactsMobile() {
				// TODO Auto-generated method stub
				return null;
			}

			@Override
			public String getLicenseNumber() {
				// TODO Auto-generated method stub
				return null;
			}

			@Override
			public String getOrganizationNumber() {
				// TODO Auto-generated method stub
				return null;
			}

			@Override
			public String getDutyNumber() {
				// TODO Auto-generated method stub
				return null;
			}

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

			@Override
			public T6110_F07 getUserState() {
				return EnumParser.parse(T6110_F07.class,
						request.getParameter("userState"));
			}
			
		}, new Paging() {

			@Override
			public int getSize() {
				return Integer.MAX_VALUE;
			}

			@Override
			public int getCurrentPage() {
				return IntegerParser.parse(request.getParameter(PAGING_CURRENT));
			}
		});
	
		
		manager.export(list.getItems(), response.getOutputStream(), "");
	}

}
