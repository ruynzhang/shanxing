package com.dimeng.p2p.user.servlets.account;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.http.session.Session;
import com.dimeng.framework.http.session.authentication.AuthenticationException;
import com.dimeng.framework.http.session.authentication.VerifyCodeAuthentication;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.account.user.service.SafetyManage;
import com.dimeng.p2p.account.user.service.entity.Safety;
import com.dimeng.p2p.utlis.JfResource;
import com.dimeng.p2p.variables.defines.SystemVariable;
import com.dimeng.util.StringHelper;
import com.shanlin.framework.communication.http.HttpUtil;

public class CheckNewCode extends AbstractAccountServlet{
	private static final long serialVersionUID = 1L;
	
	private final static Logger log = Logger.getLogger(CheckNewCode.class);
	
	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, final ServiceSession serviceSession)
			throws Throwable {
		PrintWriter out=response.getWriter();
		 SafetyManage safetyManage = serviceSession.getService(SafetyManage.class);
		 final String value = request.getParameter("value");
		 String codeType = request.getParameter("ctp");
		 //上次需要校验的类型
		 String utype = request.getParameter("utp");
		 if(StringHelper.isEmpty(codeType) || StringHelper.isEmpty(utype)){
			 out.write("00");
			 return; 
		 }
		 String istrue = serviceSession.getSession().getAttribute(utype+"is");
		 if(!codeType.equals(utype) && StringHelper.isEmpty(istrue)){
			 out.write("00");
			return;
		 }
		//校验对象
		String evenString = request.getParameter("evencheck");
		String code = request.getParameter("code");
		if(StringHelper.isEmpty(evenString) || StringHelper.isEmpty(value)){
			out.write("01");
			return;
		}else if(StringHelper.isEmpty(code)){
			out.write("02");
			return;
		}else{
			
			Session session = serviceSession.getSession();
			VerifyCodeAuthentication verfycode = new VerifyCodeAuthentication();
			verfycode.setVerifyCodeType(codeType);
			verfycode.setVerifyCode(code);
			try {
				session.authenticateVerifyCode(verfycode);
			}catch (AuthenticationException e) {
				out.write("03");
				return;
			}
			session.invalidVerifyCode(codeType);
			if("emil".equals(evenString)){
				if(safetyManage.isEmil(value)){
					out.write("04");
					return;
				}
				safetyManage.updateEmil(value);
				Safety safety = safetyManage.get();
				String accunname = safety.username;
				//同步修改php论坛
				/**Client uc = new Client();
				String rs=uc.uc_user_edit(accunname, safety.password, safety.password,value, 0, "", "");
			if(rs!=null && !"".equals(rs)){
			   int prs=Integer.parseInt(rs);
			   if(prs==1 || prs==0){
					System.out.println("bbs:" + accunname+"同步修改成功");
				}else{
					System.out.println("bbs:" + accunname+"同步修改不成功");
				}
			 }else{
				 System.out.println("bbs:" + accunname+"同步修改不成功");
			  }**/
			 //end
			//修改邮箱 add by zhengxin 20150309
			JfResource jfResource = getResourceProvider().getResource(JfResource.class);
			jfResource.addCredits(accunname, 10, "email="+value, true);
			// end
			}else if("phone".equals(evenString)){
				if(safetyManage.isPhone(value)){
					out.write("04");
					return;
				}
				safetyManage.updatePhone(value);
				//修改手机号码 add by zhengxin 20150309
				final String accunname =safetyManage.get().username;
				JfResource jfResource = getResourceProvider().getResource(JfResource.class);
				jfResource.addCredits(accunname, 14, "mobile="+value, true);
				// end
				final ConfigureProvider configureProvider = getResourceProvider().getResource(ConfigureProvider.class);
				JfResource.threadPool.execute(new Runnable() {
					public void run() {
							try{
								String jxglUrl = configureProvider.getProperty(SystemVariable.JXGL_SYSTEM_URL);
								Map<String, String> params = new HashMap<>();
								params.put("userName", accunname);
								params.put("mobile", value);
								Map<String, Object> returnVal = HttpUtil.create()
										.post(jxglUrl + "/aPe/modifyMobile", params).execute2Map();
								if(returnVal != null){
									Boolean isSuccess = (Boolean) returnVal.get("isSuccess");
									if(!isSuccess){
										log.error("同步修改绩效管理系统手机号码失败, userName:"+accunname+" mobile:"+value + " 原因：" + returnVal.get("messageContent"));
									}
								}
							}catch(Exception e){
								log.error("同步修改绩效管理系统手机号码失败, userName:"+accunname+" mobile:"+value, e);
							}
					}
				});
			}
			
		}
		
	}
	
}
