package com.dimeng.p2p.pay.servlets;

import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.http.session.Session;
import com.dimeng.framework.http.session.SessionManager;
import com.dimeng.framework.http.session.authentication.AuthenticationException;
import com.dimeng.framework.message.sms.SmsSender;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S61.entities.Reward;
import com.dimeng.p2p.modules.account.pay.service.MobileSafetyManage;
import com.dimeng.p2p.modules.account.pay.service.UserManage;
import com.dimeng.p2p.service.TasteActivityManage;
import com.dimeng.p2p.variables.defines.URLVariable;

/**
 * 对实名认证后抽奖的处理
 * 
 * @description TODO
 * @author wuyongchang
 * @date 2014年12月12日
 * 
 */

public class RealnameAwardServlet extends AbstractPayServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected boolean mustAuthenticated() {
		return false;
	}

	private SimpleDateFormat format = new SimpleDateFormat(
			"yyyy/MM/dd HH:mm:ss");

	@Override
	protected void processGet(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		// 获取session
		Session session = serviceSession.getSession();

		if (session == null) {
			session = getResourceProvider().getResource(SessionManager.class)
					.getSession(request, response, true);
		}
		try {

			// MobileSafetyManage mSafetyManage = serviceSession
			// .getService(MobileSafetyManage.class);
			UserManage userManage = serviceSession.getService(UserManage.class);

			// 活动类型 1：注册认证活动 2：实名认证活动
			int activetype = 2;
			List<Reward> list = userManage.selectlistward(activetype);
			// String accountName = "jt_1989";
			String accountName = userManage.getAccountName();
			String status = session.getAttribute("UpdateNameStatus"
					+ accountName);
			if (status == null || !"1".equals(status)) {
				ConfigureProvider configureProvider = getResourceProvider()
						.getResource(ConfigureProvider.class);
				sendRedirect(request, response,
						configureProvider.format(URLVariable.USER_SAFETY_MSG));
				return;
			}
			session.removeAttribute("UpdateNameStatus" + accountName);
			request.setAttribute("accountName", accountName);
			// 所有的奖品信息
			request.setAttribute("listward", list);
			// 获取自己的推广码
			String pcode = userManage.getByCodeaccountName(accountName);
			request.setAttribute("code", pcode);

			// 减少抽奖次数 TODO
			userManage.updatrenameward();
			// 查询所有人的中奖信息
			request.setAttribute("winUserList",
					userManage.selectlistwarduser(activetype));
			// 存在抽奖次数

			String myRewardId = serviceSession.getSession().getAttribute(
					"renameMyRewardId");
			if (myRewardId == null) {
				// 概率总值
				int randdo = 100000;
				// 奖项图片
				Reward reward = userManage.randomByList(activetype, randdo);
				request.setAttribute("reward", reward);
				serviceSession.getSession().setAttribute(
						"renameSmscommend" + accountName, reward.smscommend);
				serviceSession.getSession().setAttribute(
						"renameMyRewardId" + accountName, reward.id + "");
				System.out.println("获取奖品用户名:" + accountName + "，奖品id"
						+ reward.id + "，时间:" + format.format(new Date()));
			} else if (request.getAttribute("reward") == null) {
				request.setAttribute("reward",
						userManage.getRewardById(Integer.parseInt(myRewardId)));
			}

		} catch (AuthenticationException e) {
			e.printStackTrace();
		}
		// 跳转到抽奖页面
		forwardView(request, response, RealnameAward.class);
	}

	// ajax处理中奖信息
	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		SmsSender smsSender = serviceSession.getService(SmsSender.class);
		String mg = request.getParameter("mgr");
		if (null != mg && !"null".equals(mg) && !mg.isEmpty()) {
			UserManage userManage = serviceSession.getService(UserManage.class);
			MobileSafetyManage mUserManage = serviceSession
					.getService(MobileSafetyManage.class);
			String accountName = userManage.getAccountName();
			String phone = userManage.getphonecode(accountName);
			String smscommend = serviceSession.getSession().getAttribute(
					"renameSmscommend" + accountName);
			String myRewardIdStr = serviceSession.getSession().getAttribute(
					"renameMyRewardId" + accountName);
			// 有中奖
			if (smscommend != null && !"".equals(smscommend.trim())
					&& myRewardIdStr != null
					&& !"".equals(myRewardIdStr.trim())
					&& !"null".equals(smscommend.trim())) {
				serviceSession.getSession().removeAttribute(
						"renameSmscommend" + accountName);
				serviceSession.getSession().removeAttribute(
						"renameMyRewardId" + accountName);
				int myRewardId = Integer.parseInt(myRewardIdStr);
				// if(userManage.isExistAward(myRewardId)){
				userManage.UpdatRenameaward(accountName, phone, myRewardId);
				// 减少抽奖次数
				// userManage.updatrenameward();TODO
				smsSender.send(0, accountName + "," + smscommend + "[善行创投]",
						phone);
				//mUserManage.sendLetter(serviceSession.getSession().getAccountId(), "恭喜中奖", smscommend);
			TasteActivityManage manage=serviceSession.getService(TasteActivityManage.class);
			manage.sendLetter(serviceSession.getSession().getAccountId(), "恭喜中奖", smscommend);
				// }
				serviceSession.commit();
			} else {
				System.out.println("非法抽奖，没找到奖品id " + accountName);
			}
		} else {
			ConfigureProvider configureProvider = getResourceProvider()
					.getResource(ConfigureProvider.class);
			sendRedirect(request, response,
					configureProvider.format(URLVariable.USER_SAFETY_MSG));
		}

	}

	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		throwable.printStackTrace();
		getResourceProvider().log(throwable.getMessage());
		ConfigureProvider configureProvider = getResourceProvider()
				.getResource(ConfigureProvider.class);
		String location = configureProvider.format(URLVariable.REGISTER_MOBILE);
		if (throwable instanceof SQLException) {
			prompt(request, response, PromptLevel.ERROR, "系统繁忙，请稍后再试");
			sendRedirect(request, response, location);
		} else {
			prompt(request, response, PromptLevel.ERROR, throwable.getMessage());
			sendRedirect(request, response, location);
		}
	}
}
