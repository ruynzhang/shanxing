package com.dimeng.p2p.front.servlets;


public class Register extends AbstractFrontServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected boolean mustAuthenticated() {
		return false;
	}

}
