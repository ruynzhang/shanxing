package com.dimeng.p2p.user.servlets.account;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.codec.digest.UnixCrypt;

import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.account.user.service.SafetyManage;
import com.dimeng.p2p.account.user.service.entity.Safety;
import com.dimeng.p2p.utlis.JfResource;
import com.dimeng.util.StringHelper;

public class SettxPassword extends AbstractAccountServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, final ServiceSession serviceSession)
			throws Throwable {
		SafetyManage safetyManage = serviceSession
				.getService(SafetyManage.class);
		Safety sa = safetyManage.get();
		String type = request.getParameter("type");
		String href = getController().getViewURI(request, Safetymsg.class);
		if(type != null && "2".equals(type)){
			href = "safetypwd.html";
		}
		String newpassword = request.getParameter("new");
		if (StringHelper.isEmpty(newpassword)) {
			getController().prompt(request, response, PromptLevel.ERROR,
					"输入新密码");
		} else {
			if(sa.password.equals(UnixCrypt.crypt(newpassword,
					DigestUtils.sha256Hex(newpassword)))){
				getController().prompt(request, response, PromptLevel.ERROR,
						"不能和登录密码相同");
			}else{
				//增加积分 add by zhengxin 20150309
				if(StringHelper.isEmpty(sa.txpassword)){
					JfResource jfResource = getResourceProvider().getResource(JfResource.class);
					jfResource.addCredits(sa.username, 3, null, true);
				}
				// end
				if(type == null || !"2".equals(type)){
					getController().prompt(request, response, PromptLevel.ERROR,
							"密码设置成功");
				}
				safetyManage.updateTxpassword(UnixCrypt.crypt(newpassword,
						DigestUtils.sha256Hex(newpassword)));
			}
		}
		sendRedirect(request, response, href);
		 //实名认证抽奖跳转;
		/**
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
		 
		//实名认证获取体验金
		/** try {
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
	 					//新用户送1000体验金
	 					userManage.addTyjsmrzNum(awarcount,1000);
	 				}else if(awarcount>0 && mgm<0){
	 				    //老用户送1500体验金
	 					userManage.addTyjsmrzNum(awarcount,1500);	
	 				}
		 }
	 //end
		 sendRedirect(request, response,
					getController().getViewURI(request, Safetymsg.class));
		 }catch(Exception e){
         }**/
			
	}

}
