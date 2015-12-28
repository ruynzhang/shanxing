package com.dimeng.p2p.pay.servlets;

import java.math.BigDecimal;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.LogicalException;
import com.dimeng.framework.service.exception.ParameterException;
import com.dimeng.p2p.S62.entities.SxbaoConfig;
import com.dimeng.p2p.S62.enums.T6230_F13;
import com.dimeng.p2p.account.user.service.UserInfoManage;
import com.dimeng.p2p.account.user.service.UserManage;
import com.dimeng.p2p.escrow.huichao.service.FKOrder;
import com.dimeng.p2p.modules.bid.pay.service.TenderManage;
import com.dimeng.p2p.order.TenderOrderExecutor;
import com.dimeng.p2p.service.SxbaoManage;
import com.dimeng.p2p.variables.defines.URLVariable;

public class SxbaoInvest extends AbstractPayServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(HttpServletRequest request, HttpServletResponse response, ServiceSession serviceSession) throws Throwable {
		BigDecimal amount = new BigDecimal(request.getParameter("amount"));
		Long cid = Long.valueOf(request.getParameter("cid"));
		UserManage userManage = serviceSession.getService(UserManage.class);
		UserInfoManage userInfoManage = serviceSession.getService(UserInfoManage.class);
		String usrCustId = userManage.getUsrCustId();
		String isYuqi = userInfoManage.isYuqi();
		SxbaoManage sxbaoManage = serviceSession.getService(SxbaoManage.class);
		serviceSession.openTransactions();
		SxbaoConfig config = sxbaoManage.findConfigByIdAndBidNotNull(cid);
		String url = null;
		try {
			url = new StringBuilder(getResourceProvider().getResource(ConfigureProvider.class).format(URLVariable.SXBAO))
				.append(config.type.id).append(getResourceProvider().getSystemDefine().getRewriter()
							.getViewSuffix()).toString();
			if(usrCustId == null){
				throw new LogicalException("您需要在第三方托管平台上进行注册，才可购买！");
			}
			if("Y".equalsIgnoreCase(isYuqi)){
				throw new LogicalException("您有逾期未还的贷款，还完才能进行投标操作");
			}
			if(amount.compareTo(config.investFloor) < 0){
				throw new LogicalException("您的购买金额小于最低购买金额");
			}
			if(config.type.sellStatus == T6230_F13.F){
				throw new LogicalException("不是发售状态，不能购买");
			}
			int bid = config.bid.intValue();
			TenderManage tenderManage = serviceSession.getService(TenderManage.class);
			FKOrder fkOrder = serviceSession.getService(FKOrder.class);
			if (!fkOrder.isFullBid(bid)) {
				TenderOrderExecutor executor = getResourceProvider().getResource(TenderOrderExecutor.class);
				int orderId = 0;
				//没有满标
				synchronized (Bid.class) {
					//如果没满标一个一个的下订单
					if (!fkOrder.isFullBid(bid)) {
						orderId = tenderManage.bid(bid, amount);
						serviceSession.commit();
					}
				}
				if (orderId <= 0) {
					throw new LogicalException("购买善行宝生成订单失败!");
				}
				executor.submit(orderId, null);
				getController().prompt(request, response, PromptLevel.INFO, "恭喜你，购买善行宝成功");
				sendRedirect(request, response, url);
			}
		} catch (Throwable e) {
			getResourceProvider().log(e);
			if (e instanceof ParameterException || e instanceof SQLException) {
				getController().prompt(request, response, PromptLevel.ERROR, "系统繁忙，请您稍后再试");
				sendRedirect(request, response, url);
			} else if (e instanceof LogicalException) {
				getController().prompt(request, response, PromptLevel.WARRING, e.getMessage());
				sendRedirect(request, response, url);
			} else {
				super.onThrowable(request, response, e);
			}
		}
	}

}
