package com.dimeng.p2p.front.servlets.financing.sbtz;

import com.dimeng.framework.http.servlet.annotation.PagingServlet;
import com.dimeng.p2p.front.servlets.financing.AbstractFinancingServlet;

/**
 * 个人投资列表
 */
@PagingServlet(itemServlet = Bdxq.class)
public class Tyblb extends AbstractFinancingServlet {

	private static final long serialVersionUID = 5455206100909928866L;
}
