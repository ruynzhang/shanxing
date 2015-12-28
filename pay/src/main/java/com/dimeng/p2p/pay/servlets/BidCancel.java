package com.dimeng.p2p.pay.servlets;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;

public class BidCancel extends AbstractPayServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
//		BidManage manage = serviceSession.getService(BidManage.class);
//		String location = manage.CreateBidCancleUri(new BidCancleCond() {
//			
//			@Override
//			public String usrCustId() {
//				return "6000060000207048";
//			}
//			
//			@Override
//			public String transAmt() {
//				return "100.00";
//			}
//			
//			@Override
//			public String retUrl() {
//				return null;
//			}
//			
//			@Override
//			public String ordId() {
//				return "1188";
//			}
//			
//			@Override
//			public String ordDate() {
//				return "20140807";
//			}
//		});
//		sendRedirect(request, response, location);
//	}
//	
//	@Override
//	protected boolean mustAuthenticated() {
//		return false;
	}

}
