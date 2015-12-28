package com.dimeng.p2p.console.servlets.bid.jkgl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.LogicalException;
import com.dimeng.framework.service.exception.ParameterException;
import com.dimeng.p2p.S61.enums.T6110_F06;
import com.dimeng.p2p.S61.enums.T6110_F10;
import com.dimeng.p2p.S62.entities.T6211;
import com.dimeng.p2p.S62.entities.T6230;
import com.dimeng.p2p.S62.entities.T6231;
import com.dimeng.p2p.S62.entities.T6238;
import com.dimeng.p2p.S62.enums.T6230_F10;
import com.dimeng.p2p.S62.enums.T6231_F21;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.modules.account.console.service.UserManage;
import com.dimeng.p2p.modules.bid.console.service.BidManage;
import com.dimeng.util.parser.BigDecimalParser;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_LOAN_UPDATEPROJECT", name = "修改标的项目信息", isMenu = false)
public class UpdateProject extends AbstractBidServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -268955794485557959L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		final BidManage bidManage = serviceSession.getService(BidManage.class);
		int loanId = IntegerParser.parse(request.getParameter("loanId"));
		int userId = IntegerParser.parse(request.getParameter("userId"));
		UserManage userManage = serviceSession.getService(UserManage.class);
		String userName = userManage.getUserNameById(userId);
		request.setAttribute("userName", userName);
		T6211[] t6211s = bidManage.getBidType();
		request.setAttribute("t6211s", t6211s);
		T6110_F06 userType = userManage.getUserType(userId);
		request.setAttribute("userType", userType);
		T6230 loan = bidManage.get(loanId);
		T6231 t6231 = bidManage.getExtra(loanId);
		request.setAttribute("loan", loan);
		request.setAttribute("t6231", t6231);
		T6230 t6230 = bidManage.getBidType(loanId);
		T6238 t6238 = bidManage.getBidFl(loanId);
		request.setAttribute("t6238", t6238);
		request.setAttribute("t6230", t6230);
		super.processGet(request, response, serviceSession);
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		final BidManage bidManage = serviceSession.getService(BidManage.class);
		UserManage userManage = serviceSession.getService(UserManage.class);
		int loanId = IntegerParser.parse(request.getParameter("loanId"));
		int userId = IntegerParser.parse(request.getParameter("userId"));
		try {
			T6110_F06 userType = userManage.getUserType(userId);
			T6230 t6230 = new T6230();
			t6230.parse(request);
			t6230.F01 = loanId;
			t6230.F02 = userId;
			T6231 t6231 = new T6231();
			t6231.F07 = IntegerParser.parse(request.getParameter("xian"));
			t6231.F08 = request.getParameter("jkyt");
			t6231.F09 = request.getParameter("jkms");
			t6231.F16 = request.getParameter("hkly");
			T6238 t6238 = new T6238();
			t6238.F02 = BigDecimalParser.parse(request.getParameter("cjfwfl"));
			t6238.F03 = BigDecimalParser.parse(request.getParameter("tzglfl"));
			t6238.F04 = BigDecimalParser.parse(request.getParameter("yqflfl"));
			T6110_F10 t6110_F10 = userManage.getDb(userId);
			if (userType == T6110_F06.FZRR && t6110_F10 == T6110_F10.S) {
				throw new LogicalException("机构不允许借款");
			}
			// 本息到期一次付清
			String accDay = request.getParameter("accDay");
			if (T6230_F10.YCFQ == t6230.F10 && "S".equals(accDay)) {
				if (t6230.F09 < 30) {
					getController().prompt(request, response,
							PromptLevel.WARRING, "本息到期，一次付清(按天计)，借款期限不能小于30天");
					processGet(request, response, serviceSession);
					return;
				}
				t6231.F21 = T6231_F21.S;
				t6231.F22 = t6230.F09;
				t6230.F09 = 0;
			} else {
				if (t6230.F09 < 1 || t6230.F09 > 36) {
					getController().prompt(request, response,
							PromptLevel.WARRING, "借款期限超出有效月数[1-36]");
					processGet(request, response, serviceSession);
					return;
				}
				t6231.F21 = T6231_F21.F;
				t6231.F22 = 0;
			}

			bidManage.update(t6230, t6231, t6238);
			T6230 loan = bidManage.get(loanId);
			request.setAttribute("loan", loan);
			request.setAttribute("loanId", loanId);
			int flag = IntegerParser.parse(request.getParameter("flag"));
			if (flag == 1 && userType == T6110_F06.ZRR) {
				// 跳转到个人信息页面
				sendRedirect(request, response,
						getController().getURI(request, AddUserInfoXq.class)
								+ "?loanId=" + loanId + "&userId=" + userId);
			} else if (flag == 1 && userType == T6110_F06.FZRR) {
				sendRedirect(request, response,
						getController().getURI(request, AddEnterpriseXq.class)
								+ "?loanId=" + loanId + "&userId=" + userId);
			} else {
				getController().prompt(request, response, PromptLevel.WARRING,
						"保存成功");
				sendRedirect(request, response,
						getController().getURI(request, UpdateProject.class)
								+ "?loanId=" + loanId + "&userId=" + userId);
			}
		} catch (Throwable throwable) {
			if (throwable instanceof ParameterException
					|| throwable instanceof LogicalException) {
				getController().prompt(request, response, PromptLevel.WARRING,
						throwable.getMessage());
				processGet(request, response, serviceSession);
			} else {
				super.onThrowable(request, response, throwable);
			}
		}
	}
}
