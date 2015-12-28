package com.dimeng.p2p.front.servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.codec.digest.UnixCrypt;

import com.dimeng.framework.http.session.Session;
import com.dimeng.framework.http.session.authentication.AuthenticationException;
import com.dimeng.framework.http.session.authentication.VerifyCodeAuthentication;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.account.front.service.PasswordManage;
import com.dimeng.p2p.bbs.client.Client;
import com.dimeng.p2p.bbs.client.ClientClub;
import com.dimeng.p2p.common.KeepParam;
import com.dimeng.util.StringHelper;
import com.dimeng.util.parser.IntegerParser;

public class Mpwd2 extends AbstractMobileServicer {

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}
	
	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		String password = request.getParameter("password");
		String repassword = request.getParameter("repassword");
		String code = request.getParameter("code");
		String postfix=KeepParam.keepParamByString(request,ignoreKeys);
		if (StringHelper.isEmpty(password) || password.length() > 20
				|| password.length() < 6) {
			getController().prompt(request, response, PromptLevel.ERROR,
					"密码格式输入有误");
			sendRedirect(request, response,
					getController().getViewURI(request, Mpwd2.class)+postfix);
			return;
		}
		if (!password.equals(repassword)) {
			getController().prompt(request, response, PromptLevel.ERROR,
					"两次输入不符");
			sendRedirect(request, response,
					getController().getViewURI(request, Mpwd2.class)+postfix);
			return;
		}
		Session session = serviceSession.getSession();
		VerifyCodeAuthentication authentication = new VerifyCodeAuthentication();
		authentication.setVerifyCode(code);
		authentication.setVerifyCodeType(PASSWORD_VERIFY_CODE_TYPE);
		session.authenticateVerifyCode(authentication);
		int id = IntegerParser.parse(session
				.getAttribute("PASSWORD_ACCOUNT_ID"));
		if (id <= 0) {
			sendRedirect(request, response,
					getController().getViewURI(request, Mpwd1.class)+postfix);
			return;
		}
		PasswordManage passwordManage = serviceSession
				.getService(PasswordManage.class);
		passwordManage.updatePassword(password, id);
		String accunname = passwordManage.getaccoutName(id);
	//同步修改php论坛
	/**	Client uc = new Client();
	if(accunname!=null && !("").equals(accunname)){
		 try{
		String passwordp=UnixCrypt.crypt(password,DigestUtils.sha256Hex(password));
		String rs=uc.uc_user_edit(accunname, passwordp,passwordp, "", 1, "", "");
	 if(rs!=null && !"".equals(rs)){
		 int prs=Integer.parseInt(rs);
		if(prs==1 || prs==0){
			System.out.println(accunname+"论坛同步修改成功");
		}else{
			System.out.println(accunname+"论坛同步修改不成功");
		}}else{
			System.out.println(accunname+"论坛同步修改不成功");
		}}catch(Exception e){
			
		}
		}**/
    // end
	//同步修改善林汇到
	   ClientClub club =new ClientClub();
	   if(accunname!=null && !("").equals(accunname)){
			String passwordp=UnixCrypt.crypt(password,DigestUtils.sha256Hex(password));
		 try{
			String rs=club.uc_user_edit(accunname, passwordp,passwordp, "", 1, "", "");
		  if(rs!=null && !"".equals(rs)){
			 int prs=Integer.parseInt(rs);
			if(prs==1 || prs==0){
				System.out.println(accunname+"善林汇同步修改成功");
			}else{
				System.out.println(accunname+"善林汇同步修改不成功");
			}}else{
				System.out.println(accunname+"善林汇同步修改不成功");
			}}catch(Exception e){
				 String mage="club:Login failed ---- 请检查通信是否正常";
				 passwordManage.addexcepdisclub(accunname,"善林汇忘记密码同步修改异常",mage);
			}
		}
	   
	//end
		sendRedirect(request, response,getController().getViewURI(request, Mpwd3.class)+postfix);
	}

	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		String postfix=KeepParam.keepParamByString(request,ignoreKeys);
		if (throwable instanceof AuthenticationException) {
			getController().prompt(request, response, PromptLevel.ERROR,
					"校验码已过期或输入校验码错误");
			sendRedirect(request, response,
					getController().getViewURI(request, Mpwd2.class)+postfix);
		}
	}
	
	private static List<String> ignoreKeys = new ArrayList<String>();
	
	static {
		ignoreKeys.add("code");
		ignoreKeys.add("repassword");
	}
}
