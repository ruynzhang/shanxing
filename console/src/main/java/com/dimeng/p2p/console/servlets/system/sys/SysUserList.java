package com.dimeng.p2p.console.servlets.system.sys;

import java.io.IOException;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.entity.RoleBean;
import com.dimeng.framework.http.service.RoleManage;
import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.common.enums.SysAccountStatus;
import com.dimeng.p2p.console.servlets.system.AbstractSystemServlet;
import com.dimeng.p2p.modules.systematic.console.service.SysUserManage;
import com.dimeng.p2p.modules.systematic.console.service.entity.SysUser;
import com.dimeng.p2p.modules.systematic.console.service.query.SysUserQuery;
import com.dimeng.util.parser.EnumParser;
import com.dimeng.util.parser.IntegerParser;
import com.dimeng.util.parser.TimestampParser;

@Right(id = "P2P_C_SYS_SYSUSERLIST", isMenu = true, name = "管理员管理")
public class SysUserList extends AbstractSystemServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		SysUserManage sysUserManage = serviceSession
				.getService(SysUserManage.class);
		RoleManage roleManage = serviceSession.getService(RoleManage.class);
		SysUserQuery query = new SysUserQuery() {

			@Override
			public SysAccountStatus getStatus() {
				return EnumParser.parse(SysAccountStatus.class,
						request.getParameter("status"));
			}

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

			@Override
			public String getAccountName() {
				return request.getParameter("accountName");
			}

			@Override
			public int getRoleId() {
				return IntegerParser.parse(request.getParameter("roleId"));
			}
		};
		Paging paging = new Paging() {

			@Override
			public int getSize() {
				return 10;
			}

			@Override
			public int getCurrentPage() {
				return IntegerParser
						.parse(request.getParameter(PAGING_CURRENT));
			}
		};
		PagingResult<RoleBean> roles = roleManage.search(null, new Paging() {

			@Override
			public int getSize() {
				return Integer.MAX_VALUE;
			}

			@Override
			public int getCurrentPage() {
				return 1;
			}
		});
		request.setAttribute("roles", roles.getItems());
		PagingResult<SysUser> result = sysUserManage.serarch(query, paging);
		request.setAttribute("result", result);
		forwardView(request, response, SysUserList.class);
	}
	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		super.onThrowable(request, response, throwable);
	}
}
