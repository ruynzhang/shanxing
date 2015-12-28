package com.dimeng.p2p.console.servlets.spread.hdgl;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.modules.spread.console.service.ActivityManage;
import com.dimeng.p2p.modules.spread.console.service.entity.Activity;
import com.dimeng.p2p.modules.spread.console.service.entity.ActivityList;
import com.dimeng.p2p.console.servlets.spread.AbstractSpreadServlet;
import com.dimeng.util.parser.BigDecimalParser;
import com.dimeng.util.parser.DateParser;
import com.dimeng.util.parser.IntegerParser;
import com.dimeng.util.parser.TimestampParser;

@Right(id = "P2P_C_SPREAD_HDGL_UPDATEHDGL", name = "修改活动")
public class updateHdgl extends AbstractSpreadServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		ActivityManage manage = serviceSession.getService(ActivityManage.class);
		int id = IntegerParser.parse(request.getParameter("id"));
		ActivityList activity = manage.getActivity(id);
		request.setAttribute("activity", activity);
		forwardView(request, response, getClass());
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		try {
			ActivityManage manage = serviceSession
					.getService(ActivityManage.class);
			int id = IntegerParser.parse(request.getParameter("id"));
			Activity activity = new Activity() {

				@Override
				public String title() {

					return request.getParameter("title");
				}

				@Override
				public Timestamp startTime() {
					return TimestampParser.parse(request
							.getParameter("startTime"));
				}

				@Override
				public BigDecimal money() {
					return BigDecimalParser
							.parse(request.getParameter("money"));
				}

				@Override
				public Timestamp endTime() {
					return TimestampParser.parse(request
							.getParameter("endTime"));
				}

				/**
				 * 优惠券生效时间
				 */
				public Date couponStartTime(){
					return new Date( (DateParser.parse(request
							.getParameter("couponStartTime")).getTime()));
				}
				
				/**
				 * 优惠券失效时间
				 */
				public Date couponEndTime(){
					return new Date( (DateParser.parse(request
							.getParameter("couponEndTime")).getTime()));
				}
				/**
				 *发放数量
				 */
				public int amount(){
					return Integer.parseInt(request.getParameter("amount"));
				}
				/**
				 * 最低充值金额
				 */
				public BigDecimal leastRecharge(){
					return BigDecimalParser
							.parse(request.getParameter("leastRecharge"));
				}
				/**
				 * 最低投资金额
				 */
				public BigDecimal leastInvest(){
					return BigDecimalParser
							.parse(request.getParameter("leastInvest"));
				}
				/**
				 * 推广人数 
				 */
				public int spreadPersons(){
					return Integer.parseInt(request.getParameter("spreadPersons"));
				}
				/**
				 * 发布人
				 */
				public String publisher(){
					return request.getParameter("publisher");
				}
				/**
				 * 剩余数量
				 */
				public int remain(){
					return Integer.parseInt(request.getParameter("remain"));
				}
			};
			manage.updateActivity(id, activity);
			sendRedirect(request, response,
					getController().getURI(request, SearchHdgl.class));
		} catch (Exception e) {
			prompt(request, response, PromptLevel.ERROR, e.getMessage());
			processGet(request, response, serviceSession);
		}
	}
}
