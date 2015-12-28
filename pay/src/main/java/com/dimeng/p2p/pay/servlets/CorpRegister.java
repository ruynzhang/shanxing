package com.dimeng.p2p.pay.servlets;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;

/**
 * 企业用户注册
 */
public class CorpRegister extends AbstractPayServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
//		final String busicode = request.getParameter("busicode");
//		UserManage manage = serviceSession.getService(UserManage.class);
//		String location = manage.createCorpRegisterUri(new CorpRegisterCond() {
//			
//			@Override
//			public String usrName() {
//				return null;
//			}
//			
//			@Override
//			public String usrId() {
//				return null;
//			}
//			
//			@Override
//			public String taxCode() {
//				return null;
//			}
//			
//			@Override
//			public String instuCode() {
//				return null;
//			}
//			
//			@Override
//			public String busiCode() {
//				return busicode;
//			}
//
//			@Override
//			public String GuarType() {
//				// TODO Auto-generated method stub
//				return null;
//			}
//		});
//		sendRedirect(request, response, location);
	}
	

}
