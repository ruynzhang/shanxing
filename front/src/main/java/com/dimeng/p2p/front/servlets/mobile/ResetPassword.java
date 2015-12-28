package com.dimeng.p2p.front.servlets.mobile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.codec.digest.UnixCrypt;
import org.apache.log4j.Logger;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.http.session.Session;
import com.dimeng.framework.http.session.authentication.AuthenticationException;
import com.dimeng.framework.http.session.authentication.VerifyCodeAuthentication;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.account.front.service.PasswordManage;
import com.dimeng.p2p.bbs.client.ClientClub;
import com.dimeng.p2p.common.KeepParam;
import com.dimeng.p2p.front.servlets.password.Success;
import com.dimeng.p2p.utlis.JfResource;
import com.dimeng.p2p.variables.defines.SystemVariable;
import com.dimeng.p2p.variables.defines.URLVariable;
import com.dimeng.util.StringHelper;
import com.dimeng.util.parser.IntegerParser;
import com.shanlin.framework.communication.http.HttpUtil;

public class ResetPassword extends AbstractMobileServlet{
	private static final long serialVersionUID = 1L;
	private final static Logger log = Logger.getLogger(ResetPassword.class);
	
	@Override
	protected void processGet(HttpServletRequest request, HttpServletResponse response, ServiceSession serviceSession) throws Throwable {
		processPost(request, response, serviceSession);
	}
	
	@Override
	protected void processPost(HttpServletRequest request, HttpServletResponse response, ServiceSession serviceSession) throws Throwable {
		final String password = request.getParameter("password");
		final String PASSWORD_VERIFY_CODE_TYPE = "password.verify.code";
		String repassword = request.getParameter("repassword");
		String code = request.getParameter("code");
		
		final ConfigureProvider configureProvider = getResourceProvider().getResource(ConfigureProvider.class);
		String postfix=KeepParam.keepParamByString(request,ignoreKeys);

		if (StringHelper.isEmpty(password) || password.length() > 20 || password.length() < 6) {
			getController().prompt(request, response, PromptLevel.ERROR, "密码格式输入有误");
			sendRedirect(request, response, configureProvider.format(URLVariable.MWEB_RESETPASSWORD)+postfix);
			return;
		}
		if (!password.equals(repassword)) {
			getController().prompt(request, response, PromptLevel.ERROR, "两次密码输入不一致");
			sendRedirect(request, response, configureProvider.format(URLVariable.MWEB_RESETPASSWORD)+postfix);
			return;
		}
		Session session = serviceSession.getSession();
		VerifyCodeAuthentication authentication = new VerifyCodeAuthentication();
		authentication.setVerifyCode(code);
		authentication.setVerifyCodeType(PASSWORD_VERIFY_CODE_TYPE);
		session.authenticateVerifyCode(authentication);
		int id = IntegerParser.parse(session.getAttribute("PASSWORD_ACCOUNT_ID"));
		if (id <= 0) {
			sendRedirect(request, response, getController().getViewURI(request, DismePassword.class));
			return;
		}
		final PasswordManage passwordManage = serviceSession.getService(PasswordManage.class);
		passwordManage.updatePassword(password, id);
		//同步修改php论坛
		final String accunname = passwordManage.getaccoutName(id);
		
		JfResource.threadPool.execute(new Runnable() {
			public void run() {
				try {
					String jxglUrl = configureProvider.getProperty(SystemVariable.JXGL_SYSTEM_URL);
					Map<String, String> params = new HashMap<>();
					params.put("userName", accunname);
					params.put("password", password);
					Map<String, Object> returnVal = HttpUtil.create().post(jxglUrl + "/aPe/modifyPassword", params).execute2Map();
					if (returnVal != null) {
						Boolean isSuccess = (Boolean) returnVal.get("isSuccess");
						if (!isSuccess) {
							log.error("同步修改绩效管理系统密码失败, userName:" + accunname + " 原因：" + returnVal.get("messageContent"));
						}
					}
				} catch (Exception e) {
					log.error("同步修改绩效管理系统密码失败, userName:" + accunname, e);
				}
				//同步修改善林汇到
				ClientClub club = new ClientClub();
				if (accunname != null && !("").equals(accunname)) {
					String passwordp = UnixCrypt.crypt(password, DigestUtils.sha256Hex(password));
					try {
						String rs = club.uc_user_edit(accunname, passwordp, passwordp, "", 1, "", "");
						if (rs != null && !"".equals(rs)) {
							int prs = Integer.parseInt(rs);
							if (prs == 1 || prs == 0) {
								System.out.println(accunname + "善林汇同步修改成功");
							} else {
								System.out.println(accunname + "善林汇同步修改不成功" + rs);
							}
						} else {
							System.out.println(accunname + "善林汇同步修改不成功" + rs);
						}
					} catch (Exception e) {
						String mage = "club:Login failed ---- 请检查通信是否正常";
						try{
							passwordManage.addexcepdisclub(accunname, "善林汇忘记密码同步修改异常", mage);
						}catch (Throwable e2){}
					}
				}
				//end
			}
		});
		// end
		sendRedirect(request, response, getController().getViewURI(request, ResetSuccess.class));
	}

	

	@Override
	protected void onThrowable(HttpServletRequest request, HttpServletResponse response, Throwable throwable) throws ServletException, IOException {
		if (throwable instanceof AuthenticationException) {
			getController().prompt(request, response, PromptLevel.ERROR, "校验码已过期或输入校验码错误");
			sendRedirect(request, response, getController().getViewURI(request, ResetPassword.class));
		}
	}
	
	
private static List<String> ignoreKeys = new ArrayList<String>();
	
	static {
		ignoreKeys.add("password");
		ignoreKeys.add("repassword");
	}
	
	
	
	

}
