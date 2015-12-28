package com.dimeng.p2p.pay.servlets;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.session.Session;
import com.dimeng.framework.http.session.authentication.AuthenticationException;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S61.entities.Reward;
import com.dimeng.p2p.S61.entities.Rewarduser;
import com.dimeng.p2p.modules.account.pay.service.UserManage;

//跳转到抽奖的页面
public class Award extends AbstractPayServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected boolean mustAuthenticated() {
		return false;
	}
	private SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		try{
			// 获取session
			Session session = serviceSession.getSession();
			// 判断用户名是否存在
			if (session == null || !session.isAuthenticated()) {
				sendRedirect(request, response,
						getController().getViewURI(request,M_login.class));
				return;
			}
			UserManage userManage = serviceSession.getService(UserManage.class);
			// 参数哪次活动和查询所有的奖品信息
			//String accountName = request.getParameter("accountName");// 账户名
			//String phone = request.getParameter("phone");// 手机号码
			String accountName = userManage.getAccountName();
			String phone = userManage.getphonecode(accountName);
			int activetype = 1;
			List<Reward> list = userManage.selectlistward(activetype);

			// 概率总值
			int randdo = 100000;
			//判断还有没有抽奖机会  0表示没机会了
			int shopwardnumber = userManage.getCountAward();
			// 奖项图片
			if(shopwardnumber > 0) {
				String myRewardId = serviceSession.getSession().getAttribute("myRewardId" + accountName);
				if(myRewardId == null || "-1".endsWith(myRewardId)){
					//概率总值
					// 奖项图片
					Reward reward = userManage.randomByList(activetype, randdo);
					request.setAttribute("reward", reward);
					serviceSession.getSession().setAttribute("smscommend" + accountName, reward.smscommend);
					serviceSession.getSession().setAttribute("myRewardId" + accountName, reward.id + "");
					System.out.println("获取奖品用户名:"+accountName+"，奖品id"+reward.id + "，时间:" + format.format(new Date()));
				} else if (request.getAttribute("reward") == null) {
					request.setAttribute("reward", userManage.getRewardById(Integer.parseInt(myRewardId)));
				}
			}else {
				Reward reward = new Reward();
				reward.id = -2;
				reward.jpgname = "award16.jpg";
				request.setAttribute("reward", reward);
			}
			
			// 传递中奖人的登陆名，和手机
			request.setAttribute("accountName", accountName);
			request.setAttribute("phone", phone);

			// 获取自己的推广码
			String pcode = userManage.getByCodeaccountName(accountName);
			request.setAttribute("code", pcode);

			// 所有的中奖信息
			request.setAttribute("listward", list);

			// 查询所有人的中奖信息
			List<Rewarduser> list1 = new ArrayList<Rewarduser>();
			list1 = userManage.selectlistwarduser(activetype);
			request.setAttribute("listw", list1);
			
			//转发到jsp
			forwardView(request, response, getClass());
			//sendRedirect(request, response,getController().getViewURI(request, getClass()));
		} catch (AuthenticationException e) {
			getResourceProvider().log(e.getMessage());
			sendRedirect(request, response,
					getController().getViewURI(request,M_login.class));
				return;
			}
	}
	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request,response,serviceSession);
	}

}
