package com.dimeng.p2p.front.servlets.credit.xjd;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.http.servlet.Controller;
import com.dimeng.framework.http.session.authentication.AuthenticationException;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.resource.ResourceProvider;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S62.entities.T6230;
import com.dimeng.p2p.S62.entities.T6231;
import com.dimeng.p2p.account.front.service.UserInfoManage;
import com.dimeng.p2p.front.servlets.credit.AbstractCreditServlet;
import com.dimeng.p2p.modules.base.front.service.CreditLevelManage;
import com.dimeng.p2p.modules.bid.front.service.BusinessManage;
import com.dimeng.p2p.variables.defines.URLVariable;
import com.dimeng.util.parser.IntegerParser;

public class AddCredit extends AbstractCreditServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, final ServiceSession serviceSession)
			throws Throwable {
		BusinessManage manage = serviceSession.getService(BusinessManage.class);
		UserInfoManage mge = serviceSession.getService(UserInfoManage.class);

		// 查询当前用户是否可以新建借款

		if (!mge.isSmrz()) {
			// 跳转到实名认证页面
			sendRedirect(request, response,
					getController().getViewURI(request, com.dimeng.p2p.front.servlets.credit.Index.class) + "?erd=2");
			return;
		}


		if (mge.isYuqi().equals("Y")) {
			// 存在逾期不能借款
			sendRedirect(request, response,
					getController().getURI(request, com.dimeng.p2p.front.servlets.credit.Index.class) + "?erd=4");
			return;
		}

		// 通过ID和状态查询，当前ID是否为新建类型，不是则提示以存在不能新建。

		if (mge.isBid()) {
			sendRedirect(request, response,
					getController().getURI(request, com.dimeng.p2p.front.servlets.credit.Index.class) + "?erd=1");
			return;
		}
		
		T6230 t6230 = new T6230();
		T6231 t6231 = new T6231();
		t6231.F07 = IntegerParser.parse(request.getParameter("xian"));
		t6231.F08 = request.getParameter("t6231_f08");
		t6231.F09 = request.getParameter("t6231_f09");
		t6231.F16 = request.getParameter("t6231_f16");
		t6230.parse(request);
		UserInfoManage userInfoManage = serviceSession.getService(UserInfoManage.class);
		CreditLevelManage creditLevelManage =serviceSession.getService(CreditLevelManage.class);
		int xyId =  creditLevelManage.getId(userInfoManage.getXyjf(serviceSession.getSession().getAccountId()));
		t6230.F23 = xyId;
		manage.add(t6230, t6231);
		
		// 跳转到用户中心
		sendRedirect(request, response,
				getResourceProvider().getResource(ConfigureProvider.class)
						.format(URLVariable.USER_JKSQCX));
	}

	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		ResourceProvider resourceProvider = getResourceProvider();
		resourceProvider.log(throwable);
		getController().prompt(request, response, PromptLevel.ERROR,
				throwable.getMessage());
		final ConfigureProvider configureProvider = resourceProvider
				.getResource(ConfigureProvider.class);
		if (throwable instanceof AuthenticationException) {
			Controller controller = getController();
			controller.redirectLogin(request, response,
					configureProvider.format(URLVariable.LOGIN));
		} else {
			getController().forward(request, response,
					getController().getViewURI(request, com.dimeng.p2p.front.servlets.credit.Index.class));
		}
	}
}
