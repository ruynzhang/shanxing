package com.dimeng.p2p.console.servlets.system.jpush;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.config.ConsoleConst;
import com.dimeng.p2p.console.servlets.system.AbstractSystemServlet;
import com.dimeng.p2p.modules.systematic.console.service.JpushManage;
import com.dimeng.p2p.modules.systematic.console.service.LetterManage;
import com.dimeng.util.StringHelper;

 @MultipartConfig
// @Right(id = "P2P_C_SYS_IMPORTJPUSH", name = "极光推广导入")
public class ImportJpush extends AbstractSystemServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		JpushManage jpushManage = serviceSession.getService(JpushManage.class);
		Part part = request.getPart("file");
		//part.getName().endsWith(".csv")
		/**if (!StringHelper.isEmpty(part.getContentType())
				&& (part.getContentType().equals(ConsoleConst.CVS_STR)
						|| part.getContentType().equals(ConsoleConst.TXT_STR)
						|| part.getContentType().equals(ConsoleConst.EXCLE_STR))) {**/
		if (!StringHelper.isEmpty(part.getContentType())){
			String[] userNames = jpushManage.importUser(part.getInputStream(),"");
			request.setAttribute("userNames", userNames);
		}
		forwardView(request, response, AddJpush.class);
	}

	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		super.onThrowable(request, response, throwable);
	}
}
