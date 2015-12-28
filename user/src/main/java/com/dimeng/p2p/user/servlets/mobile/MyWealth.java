package com.dimeng.p2p.user.servlets.mobile;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.service.MobileManage;
import com.dimeng.p2p.vo.UserBase;
import com.dimeng.util.Formater;

/**
 * 我的财富
 * @author yangjh
 *
 */
public class MyWealth extends AbstractMobileServlet {

	private static final long serialVersionUID = 1L;
	
	@Override
	protected boolean mustAuthenticated() {
		return true;
	}
	
	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		Map<String, Object> resultMap=new HashMap<String, Object>();
		MobileManage manage=serviceSession.getService(MobileManage.class);
		UserBase userBase=manage.getUserBase();
		Map<String, Object> userBaseInfo=manage.getUserBaseInfo();
		Map<String, Object> unpayEarnings=manage.getUnpayEarnings();
		Map<String, Object> earnFinancingTotal=manage.getEarnFinancingTotal();
		BigDecimal wh_bj=manage.getDsCorpus();
		BigDecimal investTotal=manage.getInvestTotal();
		manage.getLoanAccountInfo();
		resultMap.put("icon", userBase.icon);
		resultMap.put("userName", userBase.userName);
		resultMap.put("phone", userBase.phoneNumber);
		//净资产=资产总额-负债总额
		BigDecimal jzze=((BigDecimal)userBaseInfo.get("balance")).add(((BigDecimal)userBaseInfo.get("freezeFunds"))).add(wh_bj).add(((BigDecimal)unpayEarnings.get("total")));
		BigDecimal fzze=manage.getUnpayTotal();
		resultMap.put("jzc", Formater.formatAmount(jzze.subtract(fzze)));
		//可用余额
		resultMap.put("balance", Formater.formatAmount((BigDecimal)userBaseInfo.get("balance")));
		//冻结资金
		resultMap.put("djzj", Formater.formatAmount((BigDecimal)userBaseInfo.get("freezeFunds")));
		//待收资金
		resultMap.put("dszj", Formater.formatAmount(wh_bj));
		//待收收益
		resultMap.put("dssy", Formater.formatAmount((BigDecimal)unpayEarnings.get("total")));
		//累计投资
		resultMap.put("ljtz", Formater.formatAmount(investTotal));
		//累计收益
		resultMap.put("ljsy", Formater.formatAmount((BigDecimal)earnFinancingTotal.get("total")));
		request.setAttribute("resultMap", resultMap);
		forwardView(request, response, getClass());
	}
}
