package com.dimeng.p2p.console.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.dimeng.framework.http.servlet.AbstractServlet;
import com.dimeng.framework.service.ServiceSession;

public abstract class AbstractThirdServlet extends AbstractServlet {

	protected static final long serialVersionUID = 1L;
	
	protected final Logger log = Logger.getLogger(getClass());
	
	@Override
	protected void processPost(HttpServletRequest request, HttpServletResponse response, ServiceSession serviceSession) throws Throwable {
		
	}
	
	@Override
	protected void processGet(HttpServletRequest request, HttpServletResponse response, ServiceSession serviceSession) throws Throwable {
		
	}
	
	@Override
	protected void onThrowable(HttpServletRequest request, HttpServletResponse response, Throwable throwable) throws ServletException, IOException {
		log.error(throwable.getMessage(), throwable);
	}
	
	@Override
	protected boolean mustAuthenticated() {
		return false;
	}
}
