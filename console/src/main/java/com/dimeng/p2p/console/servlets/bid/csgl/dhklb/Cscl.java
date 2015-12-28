package com.dimeng.p2p.console.servlets.bid.csgl.dhklb;

import java.sql.Timestamp;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S71.enums.T7152_F04;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.modules.bid.console.service.CollectionManage;
import com.dimeng.p2p.modules.bid.console.service.entity.StayRefund;
import com.dimeng.util.parser.DateParser;
import com.dimeng.util.parser.EnumParser;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_BUSI_CS_CL", name = "催收处理")
public class Cscl extends AbstractBidServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}
	
	@Override
	protected void processPost(final HttpServletRequest request,final HttpServletResponse response,
			final ServiceSession serviceSession) throws Throwable {
		CollectionManage collectionManage = serviceSession.getService(CollectionManage.class);
		String type = request.getParameter("type");
		collectionManage.stayRefundDispose(new StayRefund() {
			
			@Override
			public int getUserId() {
				return IntegerParser.parse(request.getParameter("userId"));
			}
			
			@Override
			public String getResultDesc() {
				return request.getParameter("resultDesc");
			}
			
			@Override
			public int getLoanRecordId() {
				return IntegerParser.parse(request.getParameter("loanRecordId"));
			}
			
			@Override
			public T7152_F04 getCollectionType() {
				return EnumParser.parse(T7152_F04.class, request.getParameter("collectionType"));
			}
			
			@Override
			public String getCollectionPerson() {
				return request.getParameter("collectionPerson");
			}

			@Override
			public Timestamp getCollectionTime() {
				Date date = DateParser.parse(request
						.getParameter("collectionTime"));
				return date == null ? null : new Timestamp(date.getTime());
			}
		});
		
		if("near".equals(type)){
			// 重定向
			sendRedirect(request, response,
							getController().getURI(request, JsstList.class));
		}else if("less".equals(type)){
			// 重定向
			sendRedirect(request, response,
							getController().getURI(request, YqList.class));
		}else{
			// 重定向
			sendRedirect(request, response,
							getController().getURI(request, YzyqList.class));
		}
	}

}
