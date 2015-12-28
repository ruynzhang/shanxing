package com.dimeng.p2p.console.servlets.system.email;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.resource.ResourceProvider;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.config.ConsoleConst;
import com.dimeng.p2p.console.servlets.system.AbstractSystemServlet;
import com.dimeng.p2p.modules.systematic.console.service.EmailManage;
import com.dimeng.util.StringHelper;

@MultipartConfig
@Right(id = "P2P_C_SYS_IMPORTEMAIL", name = "邮件推广导入")
public class ImportEmail extends AbstractSystemServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		EmailManage emailManage = serviceSession.getService(EmailManage.class);
		ResourceProvider resourceProvider = getResourceProvider();
		Part part = request.getPart("file");
		if (!StringHelper.isEmpty(part.getContentType())
				&& (part.getContentType().equals(ConsoleConst.CVS_STR)
						|| part.getContentType().equals(ConsoleConst.TXT_STR)
						|| part.getContentType().equals(ConsoleConst.EXCLE_STR))) {
			String[] emails = emailManage.importEmail(part.getInputStream(),
					resourceProvider.getCharset());
			request.setAttribute("emails", emails);
		}
		forwardView(request, response, AddEmail.class);
	}

	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		super.onThrowable(request, response, throwable);
	}
}
