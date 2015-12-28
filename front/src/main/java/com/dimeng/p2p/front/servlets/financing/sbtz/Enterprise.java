package com.dimeng.p2p.front.servlets.financing.sbtz;

import com.dimeng.framework.http.servlet.annotation.PagingServlet;
import com.dimeng.p2p.front.servlets.financing.AbstractFinancingServlet;


/**
 * 企业标
 */
@PagingServlet(itemServlet = Bdxq.class)
public class Enterprise extends AbstractFinancingServlet {

	private static final long serialVersionUID = 4382509273369705283L;

}
