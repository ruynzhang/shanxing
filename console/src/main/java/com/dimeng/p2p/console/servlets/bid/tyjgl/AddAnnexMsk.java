package com.dimeng.p2p.console.servlets.bid.tyjgl;

import java.util.Collection;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.dimeng.framework.http.upload.FileStore;
import com.dimeng.framework.http.upload.PartFile;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S62.entities.MortFile;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.modules.bid.console.service.AnnexManage;
import com.dimeng.p2p.modules.bid.console.service.entity.MskAnnex;
import com.dimeng.util.parser.IntegerParser;

//@Right(id = "P2P_C_LOAN_ADDLOAN", name = "上传马赛克附件")
@MultipartConfig
public class AddAnnexMsk extends AbstractBidServlet {

	private static final long serialVersionUID = -268955794485557959L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		AnnexManage annexManage = serviceSession.getService(AnnexManage.class);
		int loanId = IntegerParser.parse(request.getParameter("loanId"));
		request.setAttribute("loanId", loanId);
		MskAnnex[] mortFiles = annexManage.searchMortFiles(loanId);
		request.setAttribute("mortFiles", mortFiles);
		forwardView(request, response, getClass());
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		AnnexManage annexManage = serviceSession.getService(AnnexManage.class);
		Collection<Part> parts = request.getParts();
		final int loanId = IntegerParser.parse(request.getParameter("loanId"));
		int typeId = IntegerParser.parse(request.getParameter("typeId"));
		if (typeId <= 0) {
			// return;
		}
		int i = 0;
		for (final Part part : parts) {
			FileStore fileStore = getResourceProvider().getResource(
					FileStore.class);
			String[] fileCodes = fileStore.upload(i, new PartFile(part));
			if (part.getContentType() == null) {
				continue;
			}
			String fileCode = "";
			if (fileCodes != null) {
				fileCode = fileCodes[i];
			}
			String value = part.getHeader("content-disposition");
			String fileName = value.substring(value.lastIndexOf("=") + 2,
					value.lastIndexOf("."));
			MortFile mortFile = new MortFile();
			mortFile.F02 = loanId;
			mortFile.F03 = typeId;
			mortFile.F04 = fileCode;
			mortFile.F05 = fileName;
			annexManage.addMortFile(mortFile, new PartFile(part));
			i++;
		}
		sendRedirect(request, response,
				getController().getURI(request, AddAnnexMsk.class) + "?loanId="
						+ loanId);
	}
}
