package com.dimeng.p2p.front.servlets.financing.sbtz;

import com.dimeng.framework.http.servlet.annotation.PagingServlet;
import com.dimeng.p2p.front.servlets.financing.AbstractFinancingServlet;

/**
 * 线上债权转让列表
 */
@PagingServlet(itemServlet = Zqxq.class)
public class Zqzrlb extends AbstractFinancingServlet {

	private static final long serialVersionUID = 5455206100909928866L;
}
