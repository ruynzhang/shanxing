package com.dimeng.p2p.front.servlets.financing;

import com.dimeng.framework.http.servlet.annotation.PagingServlet;

@PagingServlet(itemServlet = UserInfo.class)
public class UserInfo extends AbstractFinancingServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5110466918123310054L;

}
