package com.dimeng.p2p.console.servlets.bid.jkgl;

import java.util.Collection;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.dimeng.framework.http.upload.PartFile;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.LogicalException;
import com.dimeng.framework.service.exception.ParameterException;
import com.dimeng.p2p.S61.enums.T6110_F06;
import com.dimeng.p2p.S62.entities.T6230;
import com.dimeng.p2p.S62.entities.T6233;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.modules.account.console.service.UserManage;
import com.dimeng.p2p.modules.bid.console.service.AnnexManage;
import com.dimeng.p2p.modules.bid.console.service.BidManage;
import com.dimeng.p2p.modules.bid.console.service.entity.WzAnnex;
import com.dimeng.util.parser.IntegerParser;

//@Right(id = "P2P_C_LOAN_ADDLOAN", name = "上传马赛克附件")
@MultipartConfig
public class AddAnnexWz extends AbstractBidServlet {

	private static final long serialVersionUID = -268955794485557959L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		AnnexManage annexManage = serviceSession.getService(AnnexManage.class);
		int loanId = IntegerParser.parse(request.getParameter("loanId"));
		int userId = IntegerParser.parse(request.getParameter("userId"));
		try {
			UserManage userManage = serviceSession.getService(UserManage.class);
			T6110_F06 userType = userManage.getUserType(userId);
			request.setAttribute("userType", userType);
			BidManage bidManage = serviceSession.getService(BidManage.class);
			T6230 t6230 = bidManage.getBidType(loanId);
			request.setAttribute("t6230", t6230);
			WzAnnex[] t6233s = annexManage.searchFgk(loanId);
			request.setAttribute("t6233s", t6233s);
			forwardView(request, response, getClass());
		} catch (Throwable throwable) {
			if (throwable instanceof LogicalException
					|| throwable instanceof ParameterException) {
				getController().prompt(request, response, PromptLevel.WARRING,
						throwable.getMessage());
				sendRedirect(request, response,
						getController().getURI(request, AddAnnexMsk.class)
								+ "?loanId=" + loanId + "&userId=" + userId);
			} else {
				super.onThrowable(request, response, throwable);
			}
		}
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		AnnexManage annexManage = serviceSession.getService(AnnexManage.class);
		final int loanId = IntegerParser.parse(request.getParameter("loanId"));
		int typeId = IntegerParser.parse(request.getParameter("typeId"));
		if (typeId <= 0) {
			return;
		}
		Collection<Part> parts = request.getParts();
		for (final Part part : parts) {
			if (part.getContentType() == null) {
				continue;
			}
			String value = part.getHeader("content-disposition");
			String fileName = value.substring(value.lastIndexOf("=") + 2,
					value.lastIndexOf("."));
			T6233 t6233 = new T6233();
			t6233.F02 = loanId;
			t6233.F03 = typeId;
			t6233.F04 = fileName;
			annexManage.addFgk(t6233, new PartFile(part));
		}
		processGet(request, response, serviceSession);
	}
}
