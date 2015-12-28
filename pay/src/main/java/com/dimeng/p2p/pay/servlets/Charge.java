package com.dimeng.p2p.pay.servlets;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.PaymentInstitution;
import com.dimeng.p2p.S61.entities.T6110;
import com.dimeng.p2p.modules.bid.pay.service.UserInfoManage;
import com.dimeng.p2p.pay.servlets.allinpay.AllinpayCharge;
import com.dimeng.p2p.pay.servlets.huichao.ChargeServlet;
import com.dimeng.p2p.pay.servlets.shuangqian.ShuangqianCharge;
import com.dimeng.p2p.variables.defines.PayVariavle;
import com.dimeng.util.parser.BooleanParser;

/**
 * 充值
 */
public class Charge extends AbstractPayServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		ConfigureProvider configureProvider = getResourceProvider().getResource(ConfigureProvider.class);
		
		/**
		 * 后端校验是否已经绑定手机、实名认证、交易密码
		 */
		UserInfoManage manage = serviceSession.getService(UserInfoManage.class);
		T6110 userInfo=	manage.getUserInfo(serviceSession.getSession().getAccountId());
		
		String mPhone = configureProvider.getProperty(PayVariavle.CHARGE_MUST_PHONE);
		String mRealName = configureProvider.getProperty(PayVariavle.CHARGE_MUST_NCIIC);
		String mWithPsd = configureProvider.getProperty(PayVariavle.CHARGE_MUST_WITHDRAWPSD);
		
		boolean smrz = manage.isSmrz();
		boolean txmm = manage.isTxmm();
		
		boolean mAuth = true;
		if(BooleanParser.parse(mPhone) && userInfo.F04 == null){
			mAuth = false;
		}else if(BooleanParser.parse(mRealName) && !smrz){
			mAuth = false;
		}else if(BooleanParser.parse(mWithPsd) && !txmm){
			mAuth = false;
		}
		
		if (!mAuth) {
			//跳转到错误页面
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			return ;
		}
		PaymentInstitution institution = PaymentInstitution.parse(request
				.getParameter("paymentInstitution"));
		switch (institution) {
		case ALLINPAY: {
			forwardController(request, response, AllinpayCharge.class);
			break;
		}
		case SHUANGQIAN: {
			forwardController(request, response, ShuangqianCharge.class);
			break;
		}
		case HUICHAO: {
			this.forwardController(request, response, ChargeServlet.class);
			break;
		}
		default: {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			break;
		}
		}
	}
}

