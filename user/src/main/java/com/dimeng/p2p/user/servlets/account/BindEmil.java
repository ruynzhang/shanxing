package com.dimeng.p2p.user.servlets.account;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.session.Session;
import com.dimeng.framework.http.session.authentication.AuthenticationException;
import com.dimeng.framework.http.session.authentication.VerifyCodeAuthentication;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S61.enums.T6118_F04;
import com.dimeng.p2p.account.user.service.SafetyManage;
import com.dimeng.p2p.account.user.service.entity.Safety;
import com.dimeng.p2p.bbs.client.Client;
import com.dimeng.p2p.utlis.JfResource;
import com.dimeng.util.StringHelper;

public class BindEmil extends AbstractAccountServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, final ServiceSession serviceSession)
			throws Throwable {
		SafetyManage safetyManage = serviceSession
				.getService(SafetyManage.class);
		String emil = request.getParameter("bemil");
		String code = request.getParameter("bemilCode");
		String type = request.getParameter("type");
		String href = getController().getViewURI(request, Safetymsg.class);
		if(type != null && "2".equals(type)){
			href = "safetyemail.html";
		}
		if (StringHelper.isEmpty(emil)) {
			getController().prompt(request, response, PromptLevel.ERROR,
					"邮箱地址错误");
			sendRedirect(request, response, href);
			return;
		} else if (StringHelper.isEmpty(code)) {
			getController().prompt(request, response, PromptLevel.ERROR,
					"验证码错误");
			sendRedirect(request, response, href);
			return;
		} else {
			// String ocode =
			// serviceSession.getSession().getAttribute("ebandsendCode");
			Session session = serviceSession.getSession();
			VerifyCodeAuthentication verfycode = new VerifyCodeAuthentication();
			verfycode.setVerifyCodeType("eband");
			verfycode.setVerifyCode(code);
			try {
				session.authenticateVerifyCode(verfycode);
			} catch (AuthenticationException e) {
				getController().prompt(request, response, PromptLevel.ERROR,
						"验证码错误");
				sendRedirect(request, response, href);
				return;
			}
			if (safetyManage.isEmil(emil)) {
				getController().prompt(request, response, PromptLevel.ERROR,
						"邮箱已存在");
				sendRedirect(request, response, href);
				return;
			}
			session.invalidVerifyCode("eband");
			//增加积分 add by zhengxin 20150309
			Safety safety = safetyManage.get();
			String accunname = safety.username;
			if(safety.emil == null){
				JfResource jfResource = getResourceProvider().getResource(JfResource.class);
				jfResource.addCredits(accunname, 1, "email="+emil, true);
			}
			// end
			safetyManage.bindEmil(emil, T6118_F04.TG.name());
			serviceSession.commit();
			sendRedirect(request, response, href);
		   }
			// 同步修改php论坛
			/**Client uc = new Client();
			String rs = uc.uc_user_edit(accunname, safety.password, safety.password,emil, 1, "", "");
			System.out.println("rs:" + rs);
			if (rs != null && !"".equals(rs)) {
				int prs = Integer.parseInt(rs);
				if (prs == 1 || prs == 0) {
					System.out.println("bbs:" + accunname + "同步修改成功");
				} else {
					System.out.println("bbs:" + accunname + "同步修改不成功");
				}
			} else {
				System.out.println("bbs:" + accunname + "同步修改不成功");
			}
			// end
			sendRedirect(request, response, href);
		}**/

		// 实名认证抽奖跳转;
		/**
		 * try { String DateStr2 = "2014-12-04 10:00:00"; //10点开放 DateFormat
		 * dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); Date date1
		 * =dateFormat.parse(DateStr2); Date datem =new Date(); String mpsa =
		 * dateFormat.format(datem); Date date2 =dateFormat.parse(mpsa); int mgm
		 * = date2.compareTo(date1);
		 * 
		 * ConfigureProvider configureProvider = getResourceProvider()
		 * .getResource(ConfigureProvider.class); UserManage userManage =
		 * serviceSession.getService(UserManage.class); int awarcount =
		 * userManage.getYnrenameAward(); if(awarcount>0 && mgm>=0 &&
		 * System.currentTimeMillis() < 1418572800000l){ String accountName =
		 * userManage.getAccountName();
		 * serviceSession.getSession().setAttribute("UpdateNameStatus" +
		 * accountName, "1"); sendRedirect(request, response,
		 * configureProvider.format(URLVariable.REGISTER_REALNAMEAWARDS));
		 * }else{ sendRedirect(request, response,
		 * getController().getViewURI(request, Safetymsg.class)); }
		 * 
		 * }catch(Exception e){
		 * 
		 * 
		 * }
		 **/
		// 实名认证送体验金
		/**
		 * try { int mnum = 1; UserManage userManage =
		 * serviceSession.getService(UserManage.class); //判断是否已经实名认证送过体验金了 mnum
		 * = userManage.getSfsmrz(); if(mnum==0){ String DateStr2 =
		 * "2015-01-11 00:00:00"; DateFormat dateFormat = new
		 * SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); Date date1
		 * =dateFormat.parse(DateStr2);
		 * 
		 * //取注册时间 String mpsa = userManage.getZcDate(); Date date2
		 * =dateFormat.parse(mpsa); int mgm = date2.compareTo(date1); int
		 * awarcount = userManage.getTyjsmrz(); if(awarcount>0 && mgm>=0){
		 * //新注册用户送1500体验金 userManage.addTyjsmrzNum(awarcount,1000); }else
		 * if(awarcount>0 && mgm<0){ //老用户送1000体验金
		 * userManage.addTyjsmrzNum(awarcount,1500); } } sendRedirect(request,
		 * response, getController().getViewURI(request, Safetymsg.class));
		 * 
		 * }catch(Exception e){ }
		 **/
		// end

	}

}
