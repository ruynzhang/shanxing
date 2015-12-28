package com.dimeng.p2p.front.servlets;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.account.front.service.UserManage;
import com.dimeng.p2p.variables.defines.URLVariable;

public class YeanYueajax extends AbstractFrontServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected boolean mustAuthenticated() {
		return true;
	}

	// 处理预约标
	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		String msg = "";
		UserManage manage = serviceSession.getService(UserManage.class);
		// 第一个标
		int rename = manage.getYnrenameCount();

		if (rename <= 0) {
			msg = "请先进行实名认证!";
		} else {
			// 判断当前可以预约的标
			int nedid = manage.getDayyebean();
			if(System.currentTimeMillis() > 1418522400000l){
				msg = "活动时间已过";
			} else if (nedid == 0) {
				msg = "公司暂时没有可放的标了!";
			} else {
				int msben = manage.getYyebean(nedid);
				// 判断是否预约了
				if (msben > 0) {
					msg = "你已经预约过了，请等待下一个预约标!";
				} else {
					// 插入预约标和获赠一次获奖机会
					manage.Inserbeanward(nedid);
					serviceSession.commit();
					msg = "您已预约成功，且获得一次抽奖机会，届时发标前一个小时会有短信提醒";
				}
			}
		}
		ConfigureProvider configureProvider = getResourceProvider()
				.getResource(ConfigureProvider.class);
		String reqUrl = request.getParameter("reqUrl");
		prompt(request, response, PromptLevel.ERROR, msg);

		if (reqUrl != null) {
			String location = configureProvider
					.format(URLVariable.FINANCING_SBTZ) + reqUrl + ".html";
			sendRedirect(request, response, location);
			return;
		} else {
			sendRedirect(request, response,
					configureProvider.format(URLVariable.FINANCING_SBTZ));
			return;
		}

	}

}
