package com.dimeng.p2p.user.servlets.mobile;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.resource.ResourceProvider;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.LogicalException;
import com.dimeng.framework.service.exception.ParameterException;
import com.dimeng.p2p.S61.entities.T6110;
import com.dimeng.p2p.S65.entities.T6507;
import com.dimeng.p2p.escrow.huichao.function.model.ResultVo;
import com.dimeng.p2p.escrow.huichao.function.model.TranDataModel;
import com.dimeng.p2p.escrow.huichao.function.model.TranModel;
import com.dimeng.p2p.escrow.huichao.function.util.FunctionClientUtil;
import com.dimeng.p2p.escrow.huichao.service.BidExchangeManage;
import com.dimeng.p2p.order.TenderExchangeExecutor;
import com.dimeng.p2p.user.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.variables.defines.HuiChaoPayVariavle;
import com.dimeng.util.parser.IntegerParser;

public class MobileZqzr extends AbstractBidServlet {

	private static final long serialVersionUID = 904758214711922809L;

	@Override
	protected void processPost(HttpServletRequest request, HttpServletResponse response, ServiceSession serviceSession) throws Throwable {
		String systemSiteDomain = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();

		int zcbId = IntegerParser.parse(request.getParameter("zqzrId"));
		BidExchangeManage manage = serviceSession.getService(BidExchangeManage.class);
		final int orderId = manage.purchase(zcbId);//订单
		final T6507 t6507 = manage.selectT6507(orderId);//订单详情
		int accountId = serviceSession.getSession().getAccountId();
		T6110 t6110 = manage.selectT6110(accountId);//当前购买债权的用户信息
		T6110 t6110_1 = manage.selectZQSQRInfo(orderId);//
		String outTradeNo = manage.getOutTradeNo(7, t6507.F01);
		ConfigureProvider configureProvider = this.getResourceProvider().getResource(ConfigureProvider.class);
		String accountNumber = configureProvider.format(HuiChaoPayVariavle.NUMBER_ID);
		String key = configureProvider.format(HuiChaoPayVariavle.MERCHANTKEY);
		TranDataModel tranDataModel = new TranDataModel(accountNumber, "zqall_" + orderId);
		List<TranModel> list = new ArrayList<TranModel>();
		TranModel jyModel = new TranModel(outTradeNo, t6507.F05.doubleValue(), t6110_1.F02, t6110.F02, accountNumber, key);
		list.add(jyModel);
		if (t6507.F06.compareTo(new BigDecimal(0)) > 0) {
			String feeoutTradeNo = manage.getOutTradeNo(8, t6507.F01);
			TranModel feeModel = new TranModel(feeoutTradeNo, t6507.F06.doubleValue(), accountNumber, t6110_1.F02, accountNumber, key);
			list.add(feeModel);
		}
		tranDataModel.setTranList(list);
		ResultVo resultVo = FunctionClientUtil.sendTrade(tranDataModel, this.getResourceProvider());
		if (resultVo.getErrorNo() >= 0) {
			serviceSession.commit();
			TenderExchangeExecutor executor = getResourceProvider().getResource(TenderExchangeExecutor.class);
			executor.submit(orderId, null);
			executor.confirm(orderId, null);
			
			getController().prompt(request, response, PromptLevel.INFO, "恭喜你，购买成功");
			sendRedirect(request, response, systemSiteDomain + "/user/mobile/cl_detail.html");
		} else {
			throw new LogicalException(resultVo.getErrorMessage());
		}
	}

	@SuppressWarnings("unused")
	@Override
	protected void onThrowable(HttpServletRequest request, HttpServletResponse response, Throwable throwable) throws ServletException, IOException {
		ResourceProvider resourceProvider = getResourceProvider();
		final ConfigureProvider configureProvider = resourceProvider.getResource(ConfigureProvider.class);
		getResourceProvider().log(throwable);
		String systemSiteDomain = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();

		int zcbId = 0;
		zcbId = IntegerParser.parse(request.getParameter("zqzrId"));

		if (throwable instanceof ParameterException || throwable instanceof SQLException) {
			getController().prompt(request, response, PromptLevel.ERROR, "系统繁忙，请您稍后再试");
			sendRedirect(request, response, systemSiteDomain + "/user/mobile/bidZrDetail.html?zqApplyId=" + zcbId);
		} else if (throwable instanceof LogicalException) {
			getController().prompt(request, response, PromptLevel.ERROR, throwable.getMessage());
			sendRedirect(request, response, systemSiteDomain + "/user/mobile/bidZrDetail.html?zqApplyId=" + zcbId);
		} else {
			super.onThrowable(request, response, throwable);
		}
	}
}