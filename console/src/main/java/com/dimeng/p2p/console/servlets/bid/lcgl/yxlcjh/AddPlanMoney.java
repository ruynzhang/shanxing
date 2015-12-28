package com.dimeng.p2p.console.servlets.bid.lcgl.yxlcjh;

import java.math.BigDecimal;
import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.LogicalException;
import com.dimeng.framework.service.exception.ParameterException;
import com.dimeng.p2p.S62.entities.T6211;
import com.dimeng.p2p.S64.enums.T6410_F07;
import com.dimeng.p2p.S64.enums.T6410_F14;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.modules.bid.console.service.BidManage;
import com.dimeng.p2p.modules.financial.console.service.PlanMoneyManage;
import com.dimeng.p2p.modules.financial.console.service.entity.PlanMoneyAdd;
import com.dimeng.util.parser.DoubleParser;
import com.dimeng.util.parser.EnumParser;
import com.dimeng.util.parser.IntegerParser;
import com.dimeng.util.parser.TimestampParser;

@Right(id = "P2P_C_BUSINESS_YXLCJHADD", name = "新增优选理财计划")
public class AddPlanMoney extends AbstractBidServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		PlanMoneyManage planMoneyManage = serviceSession
				.getService(PlanMoneyManage.class);
		boolean is = planMoneyManage.isExist();
		if (is) {
			request.setAttribute("isExist", is);
			forwardController(request, response, PlanMoneyList.class);
		} else {
			BidManage bidManage = serviceSession.getService(BidManage.class);
			T6211[] t6211s = bidManage.getBidType();

			request.setAttribute("t6211s", t6211s);
			forwardView(request, response, getClass());
		}
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			final HttpServletResponse response,
			final ServiceSession serviceSession) throws Throwable {
		try {
			PlanMoneyManage planMoneyManage = serviceSession
					.getService(PlanMoneyManage.class);

			planMoneyManage.addPlanMoney(new PlanMoneyAdd() {

				@Override
				public int getTenderScope() {
					return IntegerParser.parse(request
							.getParameter("tenderScope"));
				}

				@Override
				public T6410_F07 getState() {
					return EnumParser.parse(T6410_F07.class,
							request.getParameter("state"));
				}

				@Override
				public double getServeRate() {
					return DoubleParser.parse(request.getParameter("serveRate")) / 100;
				}

				@Override
				public double getQuitRate() {
					return DoubleParser.parse(request.getParameter("quitRate")) / 100;
				}

				@Override
				public String getPlanName() {
					return request.getParameter("planName");
				}

				@Override
				public BigDecimal getPlanMoneys() {
					return new BigDecimal(request.getParameter("planMoneys"));
				}

				@Override
				public int getLockTime() {
					return IntegerParser.parse(request.getParameter("lockTime"));
				}

				@Override
				public BigDecimal getInvestFloor() {
					return new BigDecimal(request.getParameter("investFloor"));
				}

				@Override
				public BigDecimal getInvestCeiling() {
					return new BigDecimal(request.getParameter("investCeiling"));
				}

				@Override
				public double getEarningsYearRate() {
					return DoubleParser.parse(request
							.getParameter("earningsYearRate")) / 100;
				}

				@Override
				public T6410_F14 getEarningsWay() {
					return EnumParser.parse(T6410_F14.class,
							request.getParameter("earningsWay"));
				}

				@Override
				public Timestamp getApplyStartTime() {
					return TimestampParser.parse(request
							.getParameter("applyStartTime"));
				}

				@Override
				public Timestamp getApplyEndTime() {
					return TimestampParser.parse(
							request.getParameter("applyEndTime"), "yyyy-MM-dd");
				}

				@Override
				public double getAddYearRate() {
					return DoubleParser.parse(request
							.getParameter("addYearRate")) / 100;
				}

				@Override
				public String getPlanDesc() {
					return request.getParameter("planDesc");
				}
			});

			sendRedirect(request, response,
					getController().getURI(request, PlanMoneyList.class));
		} catch (Throwable throwable) {
			if (throwable instanceof ParameterException
					|| throwable instanceof LogicalException) {
				getController().prompt(request, response, PromptLevel.WARRING,
						throwable.getMessage());
				processGet(request, response, serviceSession);
			} else {
				super.onThrowable(request, response, throwable);
			}
		}
	}
}
