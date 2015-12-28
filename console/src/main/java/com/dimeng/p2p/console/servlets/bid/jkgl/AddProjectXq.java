package com.dimeng.p2p.console.servlets.bid.jkgl;

import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.resource.ResourceProvider;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.LogicalException;
import com.dimeng.framework.service.exception.ParameterException;
import com.dimeng.p2p.S61.entities.T6161;
import com.dimeng.p2p.S61.enums.T6110_F06;
import com.dimeng.p2p.S61.enums.T6110_F10;
import com.dimeng.p2p.S62.entities.T6211;
import com.dimeng.p2p.S62.entities.T6230;
import com.dimeng.p2p.S62.entities.T6231;
import com.dimeng.p2p.S62.entities.T6238;
import com.dimeng.p2p.S62.enums.T6230_F10;
import com.dimeng.p2p.S62.enums.T6231_F21;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.modules.account.console.service.EnterpriseManage;
import com.dimeng.p2p.modules.account.console.service.GrManage;
import com.dimeng.p2p.modules.account.console.service.UserManage;
import com.dimeng.p2p.modules.account.console.service.entity.Grxx;
import com.dimeng.p2p.modules.bid.console.service.BidManage;
import com.dimeng.p2p.variables.defines.SystemVariable;
import com.dimeng.util.DateHelper;
import com.dimeng.util.StringHelper;
import com.dimeng.util.parser.BigDecimalParser;
import com.dimeng.util.parser.BooleanParser;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_BID_ADDPROJECT", name = "添加标的项目信息", isMenu = false)
public class AddProjectXq extends AbstractBidServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -268955794485557959L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		BidManage bidManage = serviceSession.getService(BidManage.class);
		int userId = IntegerParser.parse(request.getParameter("userId"));
		UserManage userManage = serviceSession.getService(UserManage.class);
		String userName = userManage.getUserNameById(userId);
		T6211[] t6211s = bidManage.getBidType();
		request.setAttribute("t6211s", t6211s);
		request.setAttribute("userName", userName);
		super.processGet(request, response, serviceSession);
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		serviceSession.openTransactions();
		BidManage bidManage = serviceSession.getService(BidManage.class);
		GrManage personalManage = serviceSession.getService(GrManage.class);
		EnterpriseManage enterpriseManage = serviceSession
				.getService(EnterpriseManage.class);
		UserManage userManage = serviceSession.getService(UserManage.class);
		int loanId = IntegerParser.parse(request.getParameter("loanId"));
		int userId = IntegerParser.parse(request.getParameter("userId"));
		ResourceProvider resourceProvider = getResourceProvider();
		ConfigureProvider configureProvider = resourceProvider
				.getResource(ConfigureProvider.class);
		Boolean tg = BooleanParser.parseObject(configureProvider
				.getProperty(SystemVariable.SFZJTG));
		try {
			T6230 t6230 = new T6230();
			if (userId <= 0) {
				userId = userManage.getIdByName(request.getParameter("name"));
			}
			if (userId <= 0) {
				throw new ParameterException("该用户名不存在或者被锁定，请重新输入");
			}
			if (tg && !userManage.isTg(userId)) {
				throw new ParameterException("该用户没用注册第三方托管账号");
			}
			T6110_F06 userType = userManage.getUserType(userId);
			T6110_F10 t6110_F10 = userManage.getDb(userId);
			if (userType == T6110_F06.ZRR) {
				Grxx user = personalManage.getUser(userId);
				if (user == null
						|| StringHelper.isEmpty(user.name)
						|| StringHelper.isEmpty(user.userName)
						|| (StringHelper.isEmpty(user.phone) && StringHelper
								.isEmpty(user.email))
						|| StringHelper.isEmpty(user.sfzh)) {
					throw new LogicalException("该用户的个人资料未填写完整,不能进行发标操作");
				}
			} else if (userType == T6110_F06.FZRR) {
				T6161 t6161 = enterpriseManage.getEnterprise(userId);
				if (t6161 == null || StringHelper.isEmpty(t6161.F02)
						|| StringHelper.isEmpty(t6161.F03)
						|| StringHelper.isEmpty(t6161.F04)
						|| StringHelper.isEmpty(t6161.F05)
						|| StringHelper.isEmpty(t6161.F05)) {
					throw new LogicalException("该企业的必要基础信息未填写完整,不能进行发标操作");
				}
				if (t6110_F10 == T6110_F10.S) {
					throw new LogicalException("机构不允许借款");
				}
			} 
			t6230.parse(request);
			t6230.F02 = userId;
			t6230.F01 = loanId;
			T6231 t6231 = new T6231();
			t6231.F07 = IntegerParser.parse(request.getParameter("xian"));
			t6231.F08 = request.getParameter("jkyt");
			t6231.F09 = request.getParameter("jkms");
			t6231.F16 = request.getParameter("hkly");
			T6238 t6238 = new T6238();
			t6238.F02 = BigDecimalParser.parse(request.getParameter("cjfwfl"));
			t6238.F03 = BigDecimalParser.parse(request.getParameter("tzglfl"));
			t6238.F04 = BigDecimalParser.parse(request.getParameter("yqflfl"));

			// 本息到期一次付清
			String accDay = request.getParameter("accDay");
			if (T6230_F10.YCFQ == t6230.F10 && "S".equals(accDay)) {
				Calendar cal = Calendar.getInstance();
				cal.setTime(new Date());
				cal.set(Calendar.HOUR_OF_DAY, 0);
				cal.set(Calendar.MINUTE, 0);
				cal.set(Calendar.SECOND, 0);
				long curDateInMills = cal.getTimeInMillis();
				cal.add(Calendar.MONTH, 36);
				long upDateInMills = cal.getTimeInMillis();
				int upDays = (int) ((upDateInMills - curDateInMills) / DateHelper.DAY_IN_MILLISECONDS);
				int lowDays = IntegerParser.parse(configureProvider
						.getProperty(SystemVariable.JK_BXDQ_LEAST_DAYS), 1);
				if (t6230.F09 < lowDays || t6230.F09 > upDays) {
					getController().prompt(
							request,
							response,
							PromptLevel.WARRING,
							"本息到期，一次付清(按天计)，借款期限超出有效天数[" + lowDays + ","
									+ upDays + "]");
					processGet(request, response, serviceSession);
					return;
				}
				t6231.F21 = T6231_F21.S;
				t6231.F22 = t6230.F09;
				t6230.F09 = 0;
			} else {
				if (t6230.F09 < 1 || t6230.F09 > 36) {
					getController().prompt(request, response,
							PromptLevel.WARRING, "借款期限超出有效月数[1-36]");
					processGet(request, response, serviceSession);
					return;
				}
				t6231.F21 = T6231_F21.F;
				t6231.F22 = 0;
			}
			int id = 0;
			if (loanId > 0) {
				bidManage.update(t6230, t6231, t6238);
			} else {
				id = bidManage.add(t6230, t6231, t6238);
			}
			//*************添加惊喜奖 add by zhengxin 2014/12/24
			String[] surpriseNames = request.getParameterValues("SURPRISE_NAME");
			String[] surpriseRates = request.getParameterValues("surpriseRate");
			if(surpriseNames != null && surpriseRates != null){
				if (loanId > 0) {//update
					bidManage.updateSurpriseConfig(loanId, surpriseNames, surpriseRates);
				} else{//add
					bidManage.addSurpriseConfig(id, surpriseNames, surpriseRates);
				}
			}
			//**************
			loanId = loanId == 0 ? id : loanId;
			request.setAttribute("loanId", loanId);
			int flag = IntegerParser.parse(request.getParameter("flag"));
			if (flag == 1 && userType == T6110_F06.ZRR) {
				// 跳转到个人信息页面
				sendRedirect(request, response,
						getController().getURI(request, AddUserInfoXq.class)
								+ "?loanId=" + loanId + "&userId=" + userId);
			} else if (flag == 1 && userType == T6110_F06.FZRR) {
				sendRedirect(request, response,
						getController().getURI(request, AddEnterpriseXq.class)
								+ "?loanId=" + loanId + "&userId=" + userId);
			} else {
				getController().prompt(request, response, PromptLevel.WARRING,
						"保存成功");
				processGet(request, response, serviceSession);
			}
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
