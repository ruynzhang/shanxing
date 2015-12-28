package com.dimeng.p2p.pay.servlets;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.config.ConfigureProvider;
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
 * 活动
 * 
 * @author yangjh
 * 
 */
public class Activity extends AbstractPayServlet {

	private static final long serialVersionUID = 69537323306150658L;

	@Override
	protected boolean mustAuthenticated() {
		return true;
	}

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		try{
			SmsSender smsSender = serviceSession.getService(SmsSender.class);
			String mg = request.getParameter("mgr");
			if (null != mg && !"null".equals(mg) && !mg.isEmpty()) {
				UserManage userManage = serviceSession.getService(UserManage.class);
			//	MobileSafetyManage mUserManage = serviceSession.getService(MobileSafetyManage.class);
				String accountName = userManage.getAccountName();
				String phone = userManage.getphonecode(accountName);
				String smscommend = serviceSession.getSession().getAttribute("smscommend" + accountName);
				String myRewardIdStr = serviceSession.getSession().getAttribute("myRewardId" + accountName);
//				System.out.println("web抽奖" + accountName+ ":::::smscommend " + smscommend);
//				System.out.println("web抽奖" + accountName+ ":::::phone " + phone);
//				System.out.println("web抽奖" + accountName+ ":::::accountName " + accountName);
//				System.out.println("web抽奖" + accountName+ ":::::myRewardIdStr " + myRewardIdStr);
				// 有中奖
				if (smscommend != null && !"".equals(smscommend.trim()) && myRewardIdStr != null 
						&& !"".equals(myRewardIdStr.trim()) && !"null".equals(smscommend.trim())) {
					serviceSession.getSession().removeAttribute("smscommend" + accountName);
					serviceSession.getSession().removeAttribute("myRewardId" + accountName);
					int myRewardId = Integer.parseInt(myRewardIdStr);
	//				if(userManage.isExistAward(myRewardId)){
					if(userManage.getCountAward() > 0){
//						System.out.println("web抽奖" + accountName+ "::::开始更新 ");
						userManage.updatsaveaward(accountName, phone, myRewardId);
						smsSender.send(0, accountName + "," +smscommend + "[善行创投]", phone);
						TasteActivityManage manage=serviceSession.getService(TasteActivityManage.class);
						manage.sendLetter(serviceSession.getSession().getAccountId(), "恭喜中奖",smscommend);
						//mUserManage.sendLetter(serviceSession.getSession().getAccountId(), "恭喜中奖", smscommend);
						
						serviceSession.commit();
//						System.out.println("web抽奖" + accountName+ "::::更新成功 ");
					}
	//				}
				}else{
					System.out.println("非法抽奖，没找到奖品id" + userManage.getAccountName());
					sendRedirect(request, response, getResourceProvider().getResource(ConfigureProvider.class)
							.format(URLVariable.USER_AWARD));
				}
			} else {
				processPost(request, response, serviceSession);
			}
		}catch (Exception e){
			getResourceProvider().log(e.getMessage());
			sendRedirect(request, response, getResourceProvider().getResource(ConfigureProvider.class)
					.format(URLVariable.LOGIN));
		}

	}
	private SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		try {
			UserManage userManage = serviceSession.getService(UserManage.class);
			int count = userManage.getCountAward();
			//活动类型 1：注册活动 2：实名认证活动
			int activetype = 1;
			List<Reward> list = userManage.selectlistward(activetype);
			String accountName = userManage.getAccountName();
			request.setAttribute("accountName", accountName);
			//所有的奖品信息
			request.setAttribute("listward",list);
			//获取自己的推广码
			String pcode = userManage.getByCodeaccountName(accountName);
			request.setAttribute("code", pcode);
			
			// 查询所有人的中奖信息
			request.setAttribute("winUserList", userManage.selectlistwarduser(activetype));
			//存在抽奖次数
//			System.out.println("test:"+accountName+"抽奖次数"+count);
			if(count > 0){
				String myRewardId = serviceSession.getSession().getAttribute("myRewardId" + accountName);
//				System.out.println("test:"+accountName+"奖品id"+myRewardId);
//				System.out.println("test:"+accountName+"奖品id"+ list);
				
				if(myRewardId == null || "-1".equals(myRewardId)){
					//概率总值
					int randdo = 100000;
					// 奖项图片
					Reward reward = userManage.randomByList(activetype, randdo);
					request.setAttribute("reward", reward);
					serviceSession.getSession().setAttribute("smscommend" + accountName, reward.smscommend);
					serviceSession.getSession().setAttribute("myRewardId" + accountName, reward.id + "");
//					System.out.println("重新获取奖品:"+accountName+"奖品"+reward);
//					System.out.println("重新获取奖品:"+accountName+"奖品id"+reward.id);
					System.out.println("获取奖品用户名:"+accountName+"，奖品id"+reward.id + "，时间:" + format.format(new Date()));
//					System.out.println("重新获取奖品:"+accountName+"奖品图片"+reward.jpgname);
				} else if (request.getAttribute("reward") == null) {
//					System.out.println("开始获取之前奖品");
					request.setAttribute("reward", userManage.getRewardById(Integer.parseInt(myRewardId)));
//					System.out.println("之前的奖品:"+accountName+"奖品"+userManage.getRewardById(Integer.parseInt(myRewardId)).toString());
//					System.out.println("之前的奖品:"+accountName+"奖品id"+userManage.getRewardById(Integer.parseInt(myRewardId)).id);
//					System.out.println("之前的奖品:"+accountName+"奖品图片"+userManage.getRewardById(Integer.parseInt(myRewardId)).jpgname);
				}else{
					System.out.println("都不是");
				}
			}else{
				Reward reward = new Reward();
				reward.id = -2;
				reward.jpgname = "award16.jpg";
				request.setAttribute("reward", reward);
			}
		} catch (AuthenticationException e) {
			getResourceProvider().log(e.getMessage());
			prompt(request, response, PromptLevel.ERROR, "会话超时，请重新登录");
			sendRedirect(request, response, getResourceProvider().getResource(ConfigureProvider.class)
					.format(URLVariable.LOGIN));
		}
		//转发到jsp
		forwardView(request, response, getClass());

	}
}
