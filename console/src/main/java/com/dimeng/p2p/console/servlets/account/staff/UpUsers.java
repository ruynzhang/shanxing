package com.dimeng.p2p.console.servlets.account.staff;

import java.util.List;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.http.upload.PartFile;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.account.AbstractAccountServlet;
import com.dimeng.p2p.modules.account.console.service.AccountManage;
import com.dimeng.p2p.modules.account.console.service.entity.Ptgl;
import com.dimeng.p2p.utlis.ReadExcel;

@MultipartConfig
@Right(id = "P2P_C_ACCOUNT_UPUSERS", name = "上传用户")
public class UpUsers extends AbstractAccountServlet{
	
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		forwardView(request, response, UpUsers.class);
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			final HttpServletResponse response,
			final ServiceSession serviceSession) throws Throwable {
		try {
			AccountManage manage = serviceSession.getService(AccountManage.class);
			Ptgl ptgl = new Ptgl();
			ptgl.parse(request);
			PartFile partFile=(PartFile)ptgl.qtlg;
			List<List<Object>> list=ReadExcel.read2007Excel(partFile.getInputStream());
			String resultStr=manage.addUser(serviceSession, list);
			request.setAttribute("msg", resultStr);
			forwardView(request, response, UpUsers.class);
		} catch (Exception e) {
			prompt(request, response, PromptLevel.ERROR, e.getMessage());
			processGet(request, response, serviceSession);
		}
	}
}
