package com.dimeng.p2p.pay.servlets;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;

public class UserInfo extends AbstractPayServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		/*FreezeManage manage = serviceSession.getService(FreezeManage.class);
		manage.sendFreeze(new FreezeCond() {
			
			@Override
			public String usrCustId() {
				return "6000060000207066";
			}
			
			@Override
			public String transAmt() {
				return "10.00";
			}
			
			@Override
			public String subAcctType() {
				return "MERDT";
			}
			
			@Override
			public String subAcctId() {
				return "MDT000001";
			}
			
			@Override
			public String retUrl() {
				return null;
			}
			
			@Override
			public String ordId() {
				return "65421511415";
			}
			
			@Override
			public String ordDate() {
				return "20140807";
			}
			
			@Override
			public String bgRetUrl() {
				return "http://61.145.159.156:8088/pay/huifu/bidRet.htm";
			}
		});*/
		
		/*UnFreezeManage manage = serviceSession.getService(UnFreezeManage.class);
		manage.sendUnFreeze(new UnFreezeCond() {
			
			@Override
			public String trxId() {
				return "201408070000027601";
			}
			
			@Override
			public String retUrl() {
				return "";
			}
			
			@Override
			public String ordId() {
				return "565633556";
			}
			
			@Override
			public String ordDate() {
				return "20140807";
			}
			
			@Override
			public String bgRetUrl() {
				return "http://61.145.159.156:8088/pay/huifu/bidRet.htm";
			}
		});*/
		
//		TransferManage manage = serviceSession.getService(TransferManage.class);
//		manage.sendTansfer(new TransferCond() {
//			
//			@Override
//			public BigDecimal transAmt() {
//				// TODO Auto-generated method stub
//				return new BigDecimal(100);
//			}
//			
//			@Override
//			public String retUrl() {
//				// TODO Auto-generated method stub
//				return null;
//			}
//			
//			@Override
//			public String outCustId() {
//				// TODO Auto-generated method stub
//				return "6000060000199949";
//			}
//			
//			@Override
//			public String outAcctId() {
//				// TODO Auto-generated method stub
//				return "MDT000001";
//			}
//			
//			@Override
//			public String ordId() {
//				// TODO Auto-generated method stub
//				return "45556521454";
//			}
//			
//			@Override
//			public String inCustId() {
//				// TODO Auto-generated method stub
//				return "6000060000207066";
//			}
//			
//			@Override
//			public String inAcctId() {
//				// TODO Auto-generated method stub
//				return "MDT000001";
//			}
//		});
	}
	
	@Override
	protected boolean mustAuthenticated() {
		return false;
	}

}
