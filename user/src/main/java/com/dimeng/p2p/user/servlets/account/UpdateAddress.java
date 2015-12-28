package com.dimeng.p2p.user.servlets.account;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.account.user.service.SafetyManage;
import com.dimeng.util.StringHelper;

public class UpdateAddress extends AbstractAccountServlet {
	private static final long serialVersionUID = 1L;

//	private final static Log log = LogFactory.getLog(UpdateAddress.class);
	
	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, final ServiceSession serviceSession)
			throws Throwable {
		SafetyManage safetyManage = serviceSession
				.getService(SafetyManage.class);
		String address = request.getParameter("address");
		String postcode = request.getParameter("postcode");
		if (StringHelper.isEmpty(address) && address.length() > 100) {
			getController().prompt(request, response, PromptLevel.ERROR,
					"联系地址错误");
		} else if (StringHelper.isEmpty(postcode) && !postcode.matches("^[0-9]{6}$")) {
			getController().prompt(request, response, PromptLevel.ERROR,
					"邮政编码错误");
		} else {
			safetyManage.updateAddressAndPostcode(address, postcode);
			getController().prompt(request, response, PromptLevel.ERROR,
					"联系地址修改成功");
			serviceSession.commit();
		}
		sendRedirect(request, response,
				getController().getViewURI(request, Safetymsg.class));
	}

}
