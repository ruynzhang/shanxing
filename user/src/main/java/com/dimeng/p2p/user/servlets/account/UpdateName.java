package com.dimeng.p2p.user.servlets.account;

import java.io.IOException;
import java.math.BigDecimal;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.Controller;
import com.dimeng.framework.http.session.authentication.AuthenticationException;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.resource.ResourceProvider;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S10.entities.ExchangeRecord;
import com.dimeng.p2p.account.user.service.SafetyManage;
import com.dimeng.p2p.common.enums.AttestationState;
import com.dimeng.p2p.modules.gzt.service.NciicManage;
import com.dimeng.p2p.service.TasteActivityManage;
import com.dimeng.p2p.user.servlets.Login;
import com.dimeng.p2p.utlis.JfResource;
import com.dimeng.p2p.utlis.JfUtil;
import com.dimeng.util.StringHelper;

public class UpdateName extends AbstractAccountServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, final ServiceSession serviceSession)
			throws Throwable {
		String idcard = request.getParameter("idCard");
		String name = request.getParameter("name");
		String type = request.getParameter("type");
		String href = getController().getViewURI(request, Safetymsg.class);
		if(type != null && "2".equals(type)){
			href = "safetymsg2.html";
		}
		SafetyManage safetyManage = serviceSession.getService(SafetyManage.class);
		if (!StringHelper.isEmpty(idcard) && !StringHelper.isEmpty(name)) {
			NciicManage nic = serviceSession.getService(NciicManage.class);
			boolean is = nic.check(idcard, name);
			if (is) {
				if (!safetyManage.isIdcard(idcard)) {
					safetyManage.updateName(name, idcard,
							AttestationState.YYZ.name());
					if(type == null || !"2".equals(type)){
						getController().prompt(request, response,
								PromptLevel.ERROR, "实名认证成功");
					}
					int userId=serviceSession.getSession().getAccountId();
					TasteActivityManage manage=serviceSession.getService(TasteActivityManage.class);
					/**积分处理*/
					JfResource jfResource = getResourceProvider().getResource(JfResource.class);
					jfResource.addCredits(manage.getUserName(userId), 2, "idcard="+idcard, true);
					/**and by yangjh 体验金活动 START**/
					if(JfUtil.isActivity()){
						//先看是否有送注册体验金,有记录送800,没有送888
						int count=manage.recordCount(userId,"ZC");
						int amount=1000;//老用户送888
						if(count>0){
							amount=800;//新用户送800
						}
						//插入体验金记录
						ExchangeRecord exRecord=new ExchangeRecord();
						exRecord.money=new BigDecimal(amount);
						exRecord.userId=userId;
						exRecord.source="SMRZ";
						manage.addRecord(exRecord);
						///更正用户体验金金额
						manage.updGold(userId,new BigDecimal(amount));
						/**发送站内信息*/
						manage.sendLetter(userId, "体验金", "实名认证成功,您已获得"+amount+"元体验金");
						/**更新记录信息,并加体验金*/
						BigDecimal result=manage.updRecord(userId);
						if(result.intValue()>0){
							/**发送站内信息*/
							manage.sendLetter(userId, "体验金","您已获取"+result.intValue()+"游戏体验金");
						}
					}
					/**体验金活动 END**/
				} else {
					getController().prompt(request, response,
							PromptLevel.ERROR, "该身份证已认证过！");
				}
			} else {
				getController().prompt(request, response, PromptLevel.ERROR,
						"实名认证失败");
			}
		}else{
			getController().prompt(request, response, PromptLevel.ERROR,
					"用户名和身份证号码不能为空");
		}
		sendRedirect(request, response, href);
		
/**		//实名认证抽奖;
		 try {
			 String DateStr2 = "2014-12-04 10:00:00";
	   //10点开放
			 DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	         Date date1 =dateFormat.parse(DateStr2);
	         Date datem =new Date();
	         String mpsa = dateFormat.format(datem);
	         Date date2 =dateFormat.parse(mpsa);
	         int  mgm = date2.compareTo(date1);
	         
	         ConfigureProvider configureProvider = getResourceProvider()
	 				.getResource(ConfigureProvider.class);
	 				UserManage userManage = serviceSession.getService(UserManage.class);
	 				int awarcount = userManage.getYnrenameAward();
	 				if(awarcount>0 && mgm>=0 && System.currentTimeMillis() < 1418572800000l){
	 					String accountName = userManage.getAccountName();
	 					serviceSession.getSession().setAttribute("UpdateNameStatus" + accountName, "1");
	 					sendRedirect(request, response, configureProvider.format(URLVariable.REGISTER_REALNAMEAWARDS));
	 				}else{
	 					sendRedirect(request, response,
	 							getController().getViewURI(request, Safetymsg.class));
	 				}
	          
			 }catch(Exception e){
	        	
	        	 
	         }**/
		//实名认证送体验金
	 /**try {
			 int mnum = 1;
			 UserManage userManage = serviceSession.getService(UserManage.class);
			 //判断是否已经实名认证送过体验金了
			 mnum = userManage.getSfsmrz();
			 if(mnum==0){
			 String DateStr2 = "2015-01-11 00:00:00";
			 DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	         Date date1 =dateFormat.parse(DateStr2);
		 				
		 				//取注册时间
		   String mpsa = userManage.getZcDate();
	         Date date2 =dateFormat.parse(mpsa);
	         int  mgm = date2.compareTo(date1);
	 				int awarcount = userManage.getTyjsmrz();
	 				if(awarcount>0 && mgm>=0){
	 					//新用户送800体验金
	 					userManage.addTyjsmrzNum2(awarcount,800);
	 				}else if(awarcount>0 && mgm<0){
	 					//老用户送1000体验金
	 					userManage.addTyjsmrzNum2(awarcount,1000);	
	 				}
	 				serviceSession.commit();
			 }
	 				sendRedirect(request, response,
							getController().getViewURI(request, Safetymsg.class));
	          
			 }catch(Exception e){
				 e.printStackTrace();
	         }**/
		//end	
		
		
	}

	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		ResourceProvider resourceProvider = getResourceProvider();
		resourceProvider.log(throwable);
		getController().prompt(request, response, PromptLevel.ERROR,throwable.getMessage());
		String type = request.getParameter("type");
		String href = getController().getViewURI(request, Safetymsg.class);
		if(type != null && "2".equals(type)){
			href = "safetymsg2.html";
		}
		if (throwable instanceof AuthenticationException) {
			Controller controller = getController();
			controller.redirectLogin(request, response,
					controller.getViewURI(request, Login.class));
		} else {
			sendRedirect(request, response,
					href);
		}
	}

}
