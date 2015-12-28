package com.dimeng.p2p.pay.servlets.allinpay;

import javax.servlet.ServletContext;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.p2p.pay.servlets.AbstractPayServlet;
import com.dimeng.p2p.variables.defines.PayVariavle;

public abstract class AbstractAllinpayServlet extends AbstractPayServlet {

	private static final long serialVersionUID = 1L;

	protected static final String inputCharset = "1"; // 1:UTF-8 2:GBK
	protected static final String version = "v1.0"; // v1.0 or v2.0
	protected static final String signType = "1"; // 签名类型（1：证书 0：MD5)
	protected static final String orderCurrency = "0"; // 0：人民币
	protected static final String payType = "0"; // 支付方式（0：不指定 1：个人网银 4企业网银
													// 12快捷支付）

	protected String getCert(ServletContext servletContext) {
		ConfigureProvider configureProvider = getConfigureProvider();
		return servletContext.getRealPath(configureProvider
				.getProperty(PayVariavle.ALLINPAY_CERT_PATH));
	}

}
