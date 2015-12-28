package com.dimeng.p2p.front.servlets.financing.sbtz;

import com.dimeng.framework.http.servlet.annotation.PagingServlet;
import com.dimeng.p2p.front.servlets.financing.AbstractFinancingServlet;
import com.dimeng.p2p.front.servlets.financing.xxzq.Xxzq;

/**
 * 线下债权转让列表
 */
@PagingServlet(itemServlet = Xxzq.class)
public class Xxzqlb extends AbstractFinancingServlet {

	private static final long serialVersionUID = 5455206100909928866L;
}
