package com.dimeng.p2p.console.servlets.finance.zjgl;

import java.math.BigDecimal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.LogicalException;
import com.dimeng.framework.service.exception.ParameterException;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.p2p.modules.account.console.service.UserManage;
import com.dimeng.util.StringHelper;
import com.dimeng.util.parser.BigDecimalParser;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_FINANCE_XYOPERGLLIST", name = "信用额度调整")
public class XYCredit extends AbstractFinanceServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(final HttpServletRequest request,
			final HttpServletResponse response,
			final ServiceSession serviceSession) throws Throwable {
		try {
			UserManage userManage = serviceSession.getService(UserManage.class);
			int userId = IntegerParser.parse(request.getParameter("userId"));
			if (userId < 1) {
				throw new ParameterException("参数错误");
			}
			BigDecimal creditAmount = BigDecimalParser.parse(request
					.getParameter("userCredit"));
			userManage.updateUserCredit(userId, creditAmount);
			String fundAccountType = request.getParameter("fundAccountType");
			String loginName = request.getParameter("loginName");

			String path = getController().getURI(request, XyList.class);
			if (!StringHelper.isEmpty(loginName)) {
				if (path.contains("?")) {
					path = path + "&loginName=" + loginName;
				} else {
					path = path + "?loginName=" + loginName;
				}

			}
			if (!StringHelper.isEmpty(fundAccountType)) {
				if (path.contains("?")) {
					path = path + "&fundAccountType=" + fundAccountType;
				} else {
					path = path + "?fundAccountType=" + fundAccountType;
				}
			}
			sendRedirect(request, response, path);
			return;
		} catch (Throwable throwable) {
			if (throwable instanceof ParameterException
					|| throwable instanceof LogicalException) {
				getController().prompt(request, response, PromptLevel.WARRING,
						throwable.getMessage());
				sendRedirect(request, response,
						getController().getURI(request, XyList.class));
			}
		}
	}

}
