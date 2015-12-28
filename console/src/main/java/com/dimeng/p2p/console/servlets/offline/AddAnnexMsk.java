package com.dimeng.p2p.console.servlets.offline;

import java.util.Collection;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.dimeng.framework.http.upload.FileStore;
import com.dimeng.framework.http.upload.PartFile;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S61.enums.T6110_F06;
import com.dimeng.p2p.S62.entities.T6230;
import com.dimeng.p2p.S62.entities.T6232;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.modules.account.console.service.UserManage;
import com.dimeng.p2p.modules.bid.console.service.AnnexManage;
import com.dimeng.p2p.modules.bid.console.service.OfflineManage;
import com.dimeng.util.parser.IntegerParser;
import com.dimeng.p2p.modules.bid.console.service.entity.MskAnnex;

//@Right(id = "P2P_C_OFFLINE_ADDLOAN", name = "上传马赛克附件")
@MultipartConfig
public class AddAnnexMsk extends AbstractBidServlet {

	private static final long serialVersionUID = -268955794485557959L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		AnnexManage annexManage = serviceSession.getService(AnnexManage.class);
		int loanId = IntegerParser.parse(request.getParameter("loanId"));
		int userId = IntegerParser.parse(request.getParameter("userId"));
		UserManage userManage = serviceSession.getService(UserManage.class);
		T6110_F06 userType = userManage.getUserType(userId);
		request.setAttribute("userType", userType);
		OfflineManage OfflineManage = serviceSession.getService(OfflineManage.class);
		T6230 t6230 = OfflineManage.getBidType(loanId);
		request.setAttribute("t6230", t6230);
		MskAnnex[] t6232s = annexManage.searchGk(loanId);
		request.setAttribute("t6232s", t6232s);
		forwardView(request, response, getClass());
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		AnnexManage annexManage = serviceSession.getService(AnnexManage.class);
		Collection<Part> parts = request.getParts();
		final int loanId = IntegerParser.parse(request.getParameter("loanId"));
		int userId = IntegerParser.parse(request.getParameter("userId"));
		int typeId = IntegerParser.parse(request.getParameter("typeId"));
		if (typeId <= 0) {
			return;
		}
		int i = 0;
		for (final Part part : parts) {
			FileStore fileStore = getResourceProvider().getResource(
					FileStore.class);
			String fileCode = fileStore.upload(i, new PartFile(part))[i];
			if (part.getContentType() == null) {
				continue;
			}
			String value = part.getHeader("content-disposition");
			String fileName = value.substring(value.lastIndexOf("=") + 2,
					value.lastIndexOf("."));
			T6232 t6232 = new T6232();
			t6232.F02 = loanId;
			t6232.F03 = typeId;
			t6232.F04 = fileCode;
			t6232.F05 = fileName;
			annexManage.addGk(t6232, new PartFile(part));
			i++;
		}
		sendRedirect(request, response,
				getController().getURI(request, AddAnnexWz.class) + "?loanId="
						+ loanId + "&userId=" + userId);
	}
}
