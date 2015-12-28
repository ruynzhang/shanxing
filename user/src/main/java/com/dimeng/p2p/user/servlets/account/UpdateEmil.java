package com.dimeng.p2p.user.servlets.account;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.codec.digest.UnixCrypt;

import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.account.user.service.SafetyManage;
import com.dimeng.p2p.account.user.service.entity.Safety;
import com.dimeng.p2p.bbs.client.Client;
import com.dimeng.p2p.utlis.JfResource;
import com.dimeng.util.StringHelper;

public class UpdateEmil extends AbstractAccountServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, final ServiceSession serviceSession)
			throws Throwable {
		String emil = request.getParameter("bemil");
		String code = request.getParameter("bemilCode");
		SafetyManage safetyManage = serviceSession
				.getService(SafetyManage.class);
		if (!StringHelper.isEmpty(emil) && !StringHelper.isEmpty(code)) {
			String scode = serviceSession.getSession().getAttribute("code");
			if (!StringHelper.isEmpty(scode)) {
				if (scode.split(",").length >= 3) {
					String e = scode.split(",")[1];
					String c = scode.split(",")[2];
					if (emil.endsWith(e) && code.equals(c)) {
						safetyManage.updateEmil(emil);
						serviceSession.commit();
						Safety safety = safetyManage.get();
						String accunname = safety.username;
						//同步修改php论坛
						/**Client uc = new Client();
						String rs=uc.uc_user_edit(accunname, safety.password, safety.password, emil, 1, "", "");
						
						int prs=Integer.parseInt(rs);
					 if(rs!=null && !"".equals(rs)){
						if(prs==1 || prs==0){
							System.out.println(accunname+"同步修改成功");
						}else{
							System.out.println(accunname+"同步修改不成功");
						}}else{
							System.out.println(accunname+"同步修改不成功");
						}**/
				    // end
					//增加积分 add by zhengxin 20150309
					JfResource jfResource = getResourceProvider().getResource(JfResource.class);
					jfResource.addCredits(accunname, 10, "email="+emil, true);
					// end
						
					}
				}
			} else {
				getController().prompt(request, response, PromptLevel.ERROR,
						"验证码输入错误");
				forward(request, response,
						getController().getViewURI(request, Safetymsg.class));
			}
		}

		sendRedirect(request, response,
				getController().getViewURI(request, Safetymsg.class));
	}

}
