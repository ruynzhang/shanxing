package com.dimeng.p2p.user.servlets.account;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.codec.digest.UnixCrypt;

import com.dimeng.framework.http.servlet.Controller;
import com.dimeng.framework.http.session.authentication.AuthenticationException;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.resource.ResourceProvider;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.account.user.service.SafetyManage;
import com.dimeng.p2p.account.user.service.entity.Safety;
import com.dimeng.p2p.user.servlets.Login;
import com.dimeng.util.StringHelper;

public class UpdatetxPassword extends AbstractAccountServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, final ServiceSession serviceSession)
			throws Throwable {
		SafetyManage safetyManage = serviceSession
				.getService(SafetyManage.class);
		Safety sa = safetyManage.get();
		String oldpassword = request.getParameter("old");
		String newpassword = request.getParameter("new");
		safetyManage.isUpdateTxmm();
		if (StringHelper.isEmpty(oldpassword)) {
			getController().prompt(request, response, PromptLevel.ERROR,
					"输入原密码");
		} else if (StringHelper.isEmpty(newpassword)) {
			getController().prompt(request, response, PromptLevel.ERROR,
					"输入新密码");
		} else {
			if (!UnixCrypt.crypt(oldpassword,DigestUtils.sha256Hex(oldpassword)).equals(sa.txpassword)) {getController().prompt(request, response, PromptLevel.ERROR,"原密码错误");
				safetyManage.udpatetxSize();
			} else if(sa.password.equals(UnixCrypt.crypt(newpassword,DigestUtils.sha256Hex(newpassword)))){
				getController().prompt(request, response, PromptLevel.ERROR,
						"不能和登录密码相同");
			} else {
				safetyManage.updateTxpassword(UnixCrypt.crypt(newpassword,DigestUtils.sha256Hex(newpassword)));
				getController().prompt(request, response, PromptLevel.ERROR,"提现密码修改成功");
			}
		}
		sendRedirect(request, response,
				getController().getViewURI(request, Safetymsg.class));
	}
	
	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		ResourceProvider resourceProvider = getResourceProvider();
		resourceProvider.log(throwable);
		getController().prompt(request, response, PromptLevel.ERROR,throwable.getMessage());
		if (throwable instanceof AuthenticationException) {
			Controller controller = getController();
			controller.redirectLogin(request, response,
					controller.getViewURI(request, Login.class));
		} else {
			sendRedirect(request, response,
					getController().getViewURI(request, Safetymsg.class));
		}
	}

}
