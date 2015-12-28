package com.dimeng.p2p.console.servlets.offline;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.LogicalException;
import com.dimeng.framework.service.exception.ParameterException;
import com.dimeng.p2p.S61.enums.T6110_F06;
import com.dimeng.p2p.S62.entities.T6211;
import com.dimeng.p2p.S62.entities.T6230;
import com.dimeng.p2p.S62.entities.T6231;
import com.dimeng.p2p.S62.entities.T6238;
import com.dimeng.p2p.S62.entities.T6240;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.modules.account.console.service.UserManage;
import com.dimeng.p2p.modules.bid.console.service.OfflineManage;
import com.dimeng.util.parser.BigDecimalParser;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_OFFLINE_UPDATEPROJECT", name = "修改标的项目信息", isMenu = false)
public class UpdateProject extends AbstractBidServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -268955794485557959L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		final OfflineManage offlineManage = serviceSession
				.getService(OfflineManage.class);
		int loanId = IntegerParser.parse(request.getParameter("loanId"));
		int userId = IntegerParser.parse(request.getParameter("userId"));
		UserManage userManage = serviceSession.getService(UserManage.class);
		String userName = userManage.getUserNameById(userId);
		request.setAttribute("userName", userName);
		T6211[] t6211s = offlineManage.getBidType();
		request.setAttribute("t6211s", t6211s);
		T6110_F06 userType = userManage.getUserType(userId);
		request.setAttribute("userType", userType);
		T6230 loan = offlineManage.get(loanId);
		T6231 t6231 = offlineManage.getExtra(loanId);
		request.setAttribute("loan", loan);
		request.setAttribute("t6231", t6231);
		T6230 t6230 = offlineManage.getBidType(loanId);
		T6238 t6238 = offlineManage.getBidFl(loanId);
		T6240 t6240 = offlineManage.getXxzq(loanId);
		String zqrName = userManage.getUserNameById(t6240.F02);
		request.setAttribute("zqrName", zqrName);
		request.setAttribute("t6238", t6238);
		request.setAttribute("t6230", t6230);
		request.setAttribute("t6240", t6240);
		super.processGet(request, response, serviceSession);
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		final OfflineManage offlineManage = serviceSession
				.getService(OfflineManage.class);
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
			T6240 t6240 = new T6240();
			int zqrId = userManage.getIdByName(request.getParameter("zqrId"));
			if (zqrId <= 0) {
				throw new ParameterException("该债权用户不存在或者被锁定，请重新输入");
			}
			if (zqrId == userId) {
				throw new ParameterException("债权用户和借款用户不能是同一个人");
			}
			t6240.F02 = zqrId;
			t6240.F03 = IntegerParser.parse(request.getParameter("syqx"));
			t6240.F04 = BigDecimalParser.parse(request.getParameter("zqjz"));
			t6240.F05 = request.getParameter("zrbt");
			t6240.F06 = BigDecimalParser.parse(request.getParameter("yjsy"));
			t6240.F07 = BigDecimalParser.parse(request.getParameter("ystzje"));
			offlineManage.update(t6230, t6231, t6238, t6240);
			T6230 loan = offlineManage.get(loanId);
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
