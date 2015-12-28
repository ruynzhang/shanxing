package com.dimeng.p2p.user.servlets.account;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.codec.digest.UnixCrypt;
import org.apache.log4j.Logger;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.account.user.service.SafetyManage;
import com.dimeng.p2p.account.user.service.UserManage;
import com.dimeng.p2p.bbs.client.ClientClub;
import com.dimeng.p2p.utlis.JfResource;
import com.dimeng.p2p.variables.defines.SystemVariable;
import com.dimeng.util.StringHelper;
import com.shanlin.framework.communication.http.HttpUtil;

public class UpdatePasswordajx extends AbstractAccountServlet{
	private static final long serialVersionUID = 1L;
	
	private final static Logger log = Logger.getLogger(UpdatePasswordajx.class);
	
	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, final ServiceSession serviceSession)
			throws Throwable {
		SafetyManage safetyManage = serviceSession.getService(SafetyManage.class);
		String ph = safetyManage.get().phoneNumber;
		PrintWriter out=response.getWriter();
		final String newpassword = request.getParameter("code");
		String phonenumber = request.getParameter("number");
		if(StringHelper.isEmpty(newpassword)){
			out.write("02");
			return;
		}
		if(StringHelper.isEmpty(phonenumber) || !ph.equals(phonenumber)){
			out.write("01");
			return;
		}
		
		safetyManage.updatePassword(UnixCrypt.crypt(newpassword,
				DigestUtils.sha256Hex(newpassword)));
		
//		final Client uc = new Client();
		final String accunname =safetyManage.get().username;
		final String oldpassword = safetyManage.get().password;
		final String nepasswordp=UnixCrypt.crypt(newpassword,DigestUtils.sha256Hex(newpassword));
		final ClientClub club =new ClientClub();
		final UserManage userManage = serviceSession.getService(UserManage.class);
		final ConfigureProvider configureProvider = getResourceProvider().getResource(ConfigureProvider.class);
		JfResource.threadPool.execute(new Runnable() {
			public void run() {
				try {
					try{
						String jxglUrl = configureProvider.getProperty(SystemVariable.JXGL_SYSTEM_URL);
						Map<String, String> params = new HashMap<>();
						params.put("userName", accunname);
						params.put("password", newpassword);
						Map<String, Object> returnVal = HttpUtil.create()
								.post(jxglUrl + "/aPe/modifyPassword", params).execute2Map();
						if(returnVal != null){
							Boolean isSuccess = (Boolean) returnVal.get("isSuccess");
							if(!isSuccess){
								log.error("同步修改绩效管理系统密码失败, userName:" + accunname + " 原因：" + returnVal.get("messageContent"));
							}
						}
					}catch(Exception e){
						log.error("同步修改绩效管理系统密码失败, userName:"+accunname, e);
					}
					
					//同步修改php论坛
					/**try{
						String  rs=uc.uc_user_edit(accunname, oldpassword, nepasswordp, "", 1, "", "");
						
						int prs=Integer.parseInt(rs);
						if(prs==1 || prs==0){
							System.out.println(accunname+"同步修改成功");
						}else{
							System.out.println(accunname+"同步修改不成功");
						}}catch(Exception e){
							
						}**/
				       //end
					//同步修改善林汇
					  try{
						  String  rs2=club.uc_user_edit(accunname, oldpassword, nepasswordp, "", 1, "", "");
						  int prs=Integer.parseInt(rs2);
						if(prs==1 || prs==0){
							System.out.println(accunname+"同步修改成功");
						}else{
							System.out.println(accunname+"同步修改不成功");
							userManage.addexcepdisclub(accunname,"善林汇异常","修改不成功");
						}}catch(Exception e){
							userManage.addexcepdisclub(accunname,"善林汇异常","修改异常");
						}
					  //end 
				} catch (Throwable e) {
					//e.printStackTrace();
				}
			}
		});
	   
	
			
		
	}
	
}
