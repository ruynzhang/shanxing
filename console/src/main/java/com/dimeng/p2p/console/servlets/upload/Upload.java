package com.dimeng.p2p.console.servlets.upload;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.dimeng.framework.http.upload.FileStore;
import com.dimeng.framework.http.upload.PartFile;
import com.dimeng.framework.http.upload.UploadFile;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.AbstractConsoleServlet;
import com.dimeng.util.parser.IntegerParser;

@MultipartConfig
public class Upload extends AbstractConsoleServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		List<UploadFile> uploadFiles = null;
		Collection<Part> parts = request.getParts();
		if (parts != null && parts.size() > 0) {
			for (Part part : parts) {
				if (part.getContentType() == null) {
					continue;
				}
				if (uploadFiles == null) {
					uploadFiles = new ArrayList<>();
				}
				uploadFiles.add(new PartFile(part));
			}
		}
		PrintWriter out = response.getWriter();
		if (uploadFiles == null || uploadFiles.size() == 0) {
			out.print("{\"error\":1,\"message\":\"没有需要上传的文件.\"}");
			return;
		}
		try {
			int type = IntegerParser.parse(request.getParameter("type"));
			FileStore fileStore = getResourceProvider().getResource(
					FileStore.class);
			String[] strings = fileStore.upload(type,
					uploadFiles.toArray(new UploadFile[uploadFiles.size()]));
			if (strings == null || strings.length == 0) {
				out.print("{\"error\":1,\"message\":\"没有需要上传的文件.\"}");
				return;
			}
			out.print("{\"error\":0,\"url\":");
			if (strings.length == 1) {
				out.print("\"");
				out.print(fileStore.getURL(strings[0]));
				out.print("\"}");
			} else {
				out.print('[');
				boolean notFirst = false;
				for (String string : strings) {
					if (notFirst) {
						out.print(',');
					} else {
						notFirst = true;
					}
					out.print("\"");
					out.print(fileStore.getURL(string));
					out.print("\"");
				}
				out.print(']');
			}
		} catch (Throwable t) {
			out.print("{'error':1,'message':'" + t.getMessage() + "'}");
		}
	}
}
