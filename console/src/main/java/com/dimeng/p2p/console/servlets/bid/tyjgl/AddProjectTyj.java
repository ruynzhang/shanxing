package com.dimeng.p2p.console.servlets.bid.tyjgl;




import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.resource.ResourceProvider;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.LogicalException;
import com.dimeng.framework.service.exception.ParameterException;
import com.dimeng.p2p.common.Expemonyinfo;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.modules.account.console.service.UserManage;
import com.dimeng.p2p.modules.bid.console.service.BidManage;
import com.dimeng.p2p.variables.defines.SystemVariable;
import com.dimeng.util.parser.BigDecimalParser;
import com.dimeng.util.parser.BooleanParser;


@Right(id = "P2P_C_BUSI_ADDPROJECTTYJ", name = "添加体验金信息")
public class AddProjectTyj extends AbstractBidServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -268955794485557959L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		super.processGet(request, response, serviceSession);
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		// serviceSession.openTransactions();
		ResourceProvider resourceProvider = getResourceProvider();
		BidManage bidManage = serviceSession.getService(BidManage.class);
		UserManage userManage = serviceSession.getService(UserManage.class);
		ConfigureProvider configureProvider = resourceProvider
				.getResource(ConfigureProvider.class);
		Boolean tg = BooleanParser.parseObject(configureProvider
				.getProperty(SystemVariable.SFZJTG));
		try {
			Expemonyinfo bid = new Expemonyinfo();
			// 账号
			String zhname = request.getParameter("name");
			int userId = userManage.getIdByName(zhname);

			if (userId <= 0) {
				throw new ParameterException("该用户名不存在或者被锁定，请重新输入");
			}
			if (tg && !userManage.isTg(userId)) {
				throw new ParameterException("该用户没用注册第三方托管账号");
			}

			bid.account_name = zhname;
			// 借款标题
			bid.title = request.getParameter("F03");
			// 借款金额
			bid.borrmoney = BigDecimalParser.parse(request.getParameter("F05"));
			// 借款期限
			bid.borrterm = Integer.parseInt(request.getParameter("F09"));
			// 借款的年利率
			bid.borrint = BigDecimalParser.parse(request.getParameter("F06"));
			// 筹款期限
			bid.fundraterm = Integer.parseInt(request.getParameter("F08"));
			bid.mortinfo = request.getParameter("dywxx");
			bid.detail = request.getParameter("detail");
			
			// 状态
			// bid.Tyjsfsh = Tyjbdinfo_status.DFB.name();
			bidManage.addTyjBid(bid);
			getController().prompt(request, response, PromptLevel.WARRING,
					"保存成功");
			sendRedirect(request, response,
					getController().getURI(request, TyjglList.class));

			// processGet(request, response, serviceSession);

		} catch (Throwable throwable) {
			if (throwable instanceof ParameterException
					|| throwable instanceof LogicalException) {
				getController().prompt(request, response, PromptLevel.WARRING,
						throwable.getMessage());
				processGet(request, response, serviceSession);
			} else {
				super.onThrowable(request, response, throwable);
			}
		}
	}
}
