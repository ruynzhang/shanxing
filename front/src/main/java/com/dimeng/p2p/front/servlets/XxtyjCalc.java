package com.dimeng.p2p.front.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.account.front.service.XxTyjManage;

public class XxtyjCalc extends AbstractFrontServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, final ServiceSession serviceSession)
			throws Throwable {
		String result = "";
		BigDecimal tyj = BigDecimal.ZERO;
		String accountName = request.getParameter("accountName");
		if (accountName != null) {
			XxTyjManage xxTyjManage = serviceSession
					.getService(XxTyjManage.class);
			boolean is = xxTyjManage.isByAccountExsit(accountName);
			if (is) {
				tyj = xxTyjManage.searchTyjByAccountName(accountName);
				result = "{\"status\":1,\"result\":" + tyj + "}";
			} else {
				result = "{\"status\":0,\"result\":" + tyj + "}";
			}
		}

		writeJsonMsg(result, response);
	}

	public static void writeJsonMsg(String content, HttpServletResponse response)
			throws IOException {
		PrintWriter out = null;// 写返回值
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		response.setHeader("cache-control", "no-cache");
		response.setDateHeader("expires", 0);
		try {
			out = response.getWriter();
			if (content == null || content.trim().equals("")) {
				out.write("");
			} else {
				out.write(content);
			}
			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
