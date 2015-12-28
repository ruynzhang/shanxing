package com.dimeng.p2p.user.servlets.account;

import java.util.Collection;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.dimeng.framework.http.upload.PartFile;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.account.user.service.UserBaseManage;
import com.dimeng.p2p.account.user.service.entity.UserBase;
import com.dimeng.p2p.utlis.JfResource;

@MultipartConfig
public class Upload extends AbstractAccountServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		Collection<Part> parts = request.getParts();
		if (parts != null) {
			for (Part part : parts) {
				if (part == null || part.getContentType() == null
						|| part.getSize() == 0) {
					continue;
				}
				UserBaseManage userBaseManage = serviceSession
						.getService(UserBaseManage.class);
				UserBase userBase = userBaseManage.getUserBase();
				if(userBase.icon == null || userBase.icon.trim().length() == 0){
					JfResource jfResource = getResourceProvider().getResource(JfResource.class);
					jfResource.addCredits(userBase.userName, 4, "turl=", true);
				}
				userBaseManage.upload(new PartFile(part));
				break;
			}
		}
		
		request.setAttribute("close", "close");
		getController().forwardView(request, response, Upload.class);
	}
}
