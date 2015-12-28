package com.dimeng.p2p.user.servlets.account;

import java.io.PrintWriter;
import java.util.Collection;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.http.upload.PartFile;
import com.dimeng.framework.resource.ResourceProvider;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.account.user.service.RzxxManage;
import com.dimeng.p2p.variables.defines.SystemVariable;
import com.dimeng.util.StringHelper;

@MultipartConfig
public class Rzsc extends AbstractAccountServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		forwardView(request, response, getClass());
	}

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
//		RzxxManage manage = serviceSession.getService(RzxxManage.class);
//		int rzID = Integer.parseInt(request.getParameter("id"));
//		Collection<Part> parts = request.getParts();
//		for (final Part part : parts) {
//			if (part.getContentType() == null) {
//				continue;
//			}
//			manage.uploadFile(rzID, new PartFile(part));
//		}
//		sendRedirect(request, response, getController().getURI(request, Attestationmsg.class));
		ResourceProvider resourceProvider = getResourceProvider();
		ConfigureProvider configureProvider = resourceProvider
				.getResource(ConfigureProvider.class);
		String allowFileType = configureProvider
				.getProperty(SystemVariable.ALLOW_UPLOAD_FILE_TYPE);
		RzxxManage manage = serviceSession.getService(RzxxManage.class);
		int rzID = Integer.parseInt(request.getParameter("id"));
		Collection<Part> parts = request.getParts();
		String rtnMsg = "";
		for (final Part part : parts) {
			if (StringHelper.isEmpty(part.getContentType())) {
				continue;
			}
			String content = part.getHeaders("content-disposition").toString();
			String fileType = content.substring(content.lastIndexOf(".") + 1,
					content.length() - 2);
			if (!allowFileType.contains(fileType)) {
				rtnMsg = "不支持" + fileType + "此类文件上传！";
				break;
			}
			manage.uploadFile(rzID, new PartFile(part));
			rtnMsg = "附件已经上传成功！";
		}
		PrintWriter out = response.getWriter();
		out.print(rtnMsg);
		out.close();
	}
	
	

}
