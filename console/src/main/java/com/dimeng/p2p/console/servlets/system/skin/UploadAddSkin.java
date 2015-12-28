package com.dimeng.p2p.console.servlets.system.skin;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.http.upload.FileStore;
import com.dimeng.framework.http.upload.PartFile;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.system.AbstractSystemServlet;

@Right(id = "P2P_C_SYS_ADDSKIN", name = "前台皮肤设置添加")
@MultipartConfig
public class UploadAddSkin extends AbstractSystemServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		Part part = request.getPart("file");
		FileStore fileStore = getResourceProvider()
				.getResource(FileStore.class);
		String fileCode = fileStore.upload(0, new PartFile(part))[0];
		request.setAttribute("fileCode", fileCode);
		forwardView(request, response, AddSkin.class);
	}
}
