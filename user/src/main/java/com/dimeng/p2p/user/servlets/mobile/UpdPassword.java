package com.dimeng.p2p.user.servlets.mobile;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.codec.digest.UnixCrypt;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.account.user.service.SafetyManage;
import com.dimeng.p2p.account.user.service.UserManage;
import com.dimeng.p2p.account.user.service.entity.Safety;
import com.dimeng.p2p.bbs.client.ClientClub;
import com.dimeng.p2p.utlis.JfResource;
import com.dimeng.p2p.variables.defines.SystemVariable;
import com.dimeng.util.StringHelper;
import com.shanlin.framework.communication.http.HttpUtil;

public class UpdPassword extends AbstractMobileServlet {

	private static final long serialVersionUID = 1L;
	
	@Override
	protected boolean mustAuthenticated() {
		return true;
	}

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		String oldpassword = request.getParameter("old");
		final String newpassword = request.getParameter("new");
		SafetyManage safetyManage = serviceSession
				.getService(SafetyManage.class);
		Safety sa = safetyManage.get();
		try {
			if (StringHelper.isEmpty(oldpassword)) {
				print(response, "输入原密码");
				return;
			} 
			if (StringHelper.isEmpty(newpassword)) {
				print(response, "输入新密码");
				return;
			} 
			if (!UnixCrypt.crypt(oldpassword,
					DigestUtils.sha256Hex(oldpassword)).equals(sa.password)) {
				print(response, "原密码错误");
				return;
			}
			if (!StringHelper.isEmpty(sa.txpassword)
					&& sa.txpassword.equals(UnixCrypt.crypt(newpassword,
							DigestUtils.sha256Hex(newpassword)))) {
				print(response, "不能和提现密码相同");
				return;
			} 
			safetyManage.updatePassword(UnixCrypt.crypt(newpassword,
					DigestUtils.sha256Hex(newpassword)));
			serviceSession.commit();
			print(response, "密码修改成功");
		} catch (Throwable e) {
			print(response, e.getMessage());
		}
		final String accunname =safetyManage.get().username;
		final String _oldpassword = safetyManage.get().password;
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
						  String  rs2=club.uc_user_edit(accunname, _oldpassword, nepasswordp, "", 1, "", "");
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
	
	public void print(HttpServletResponse response,String msg) throws IOException{
		response.setContentType("text/html;charset="
				+ getResourceProvider().getCharset());
		response.getWriter().print(msg);
		response.getWriter().flush();
	}
}
