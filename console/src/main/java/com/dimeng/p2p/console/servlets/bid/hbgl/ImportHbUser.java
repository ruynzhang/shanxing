package com.dimeng.p2p.console.servlets.bid.hbgl;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.ParameterException;
import com.dimeng.p2p.console.config.ConsoleConst;
import com.dimeng.p2p.console.servlets.system.AbstractSystemServlet;
import com.dimeng.util.StringHelper;

@MultipartConfig
public class ImportHbUser extends AbstractSystemServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		Part part = request.getPart("file");
		if (!StringHelper.isEmpty(part.getContentType())
				&& (part.getContentType().equals(ConsoleConst.CVS_STR)
						|| part.getContentType().equals(ConsoleConst.TXT_STR)
						|| part.getContentType().equals(ConsoleConst.EXCLE_STR))) {
			InputStream inputStream=part.getInputStream();
			if (inputStream == null) {
				throw new ParameterException("读取文件流不存在.");
			}
			List<String> list = new ArrayList<>();
			try (BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream, "GBK"))) {
				String line = "";
				while ((line = reader.readLine()) != null) {
					list.add(line);
				}
			}
			String[] userNames=list.toArray(new String[list.size()]);
			request.setAttribute("userNames", userNames);
		}
		forwardView(request, response, AddRedpRecord.class);
	}

	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		super.onThrowable(request, response, throwable);
	}
}
