package com.dimeng.p2p.console.servlets.offline;

import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.upload.FileStore;
import com.dimeng.framework.http.upload.UploadFile;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S62.entities.T6233;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.modules.bid.console.service.AnnexManage;
import com.dimeng.p2p.modules.bid.console.service.BidManage;
import com.dimeng.util.parser.IntegerParser;

public class SetViewPic extends AbstractBidServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		int userId = IntegerParser.parse(request.getParameter("userId"));
		int loanId = IntegerParser.parse(request.getParameter("loanId"));
		int id = IntegerParser.parse(request.getParameter("id"));
		AnnexManage annexManage = serviceSession.getService(AnnexManage.class);
		BidManage bidManage = serviceSession.getService(BidManage.class);
		final T6233 t6233 = annexManage.getFgk(id);
		FileStore fileStore = getResourceProvider()
				.getResource(FileStore.class);
		String[] fileCode = fileStore.upload(1, new UploadFile() {

			@Override
			public String getSuffix() {
				return t6233.F07;
			}

			@Override
			public InputStream getInputStream() throws IOException {
				try {
					return t6233.F06.getBinaryStream();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				return null;
			}
		});
		if (fileCode != null && fileCode.length > 0) {
			bidManage.setPic(loanId, fileCode[0]);
		}
		getController().prompt(request, response, PromptLevel.WARRING, "设置成功");
		sendRedirect(request, response,
				getController().getURI(request, DetailAnnexWz.class)
						+ "?loanId=" + loanId + "&userId=" + userId);
	}
}
