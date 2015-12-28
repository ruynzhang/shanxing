package com.dimeng.p2p.console.servlets.finance.yccl;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.Controller;
import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.S65.enums.T6501_F03;
import com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet;
import com.dimeng.p2p.escrow.huichao.entity.ChargeItem;
import com.dimeng.p2p.order.ChargeOrderExecutor;
import com.dimeng.util.StringHelper;
import com.dimeng.util.parser.DateParser;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_FINANCE_CZTH", isMenu = true, name = "充值对账数据修正")
public class Czth extends AbstractFinanceServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		final String startDate = request.getParameter("startDate");
		final String endDate = request.getParameter("endDate");
		Controller controller = getController();
		String location = controller.getViewURI(request, getClass());
		if (StringHelper.isEmpty(startDate) && StringHelper.isEmpty(endDate)) {
			controller.prompt(request, response, PromptLevel.INFO, "请选择时间");
			sendRedirect(request, response, location);
			return;
		}
		if (StringHelper.isEmpty(startDate)) {
			controller.prompt(request, response, PromptLevel.INFO, "请选择起始时间");
			sendRedirect(request, response, location);
			return;
		}
		if (StringHelper.isEmpty(endDate)) {
			controller.prompt(request, response, PromptLevel.INFO, "请选择结束时间");
			sendRedirect(request, response, location);
			return;
		}
		final Date sDate = DateParser.parse(startDate, "yyyy-MM-dd");
		final Date eDate = DateParser.parse(endDate, "yyyy-MM-dd");
		if (sDate.getTime() >= eDate.getTime()) {
			controller.prompt(request, response, PromptLevel.INFO,
					"时间范围错误，起始时间不能大于结束时间");
			processGet(request, response, serviceSession);
			return;
		}
//		ChargeQueryManage manage = serviceSession
//				.getService(ChargeQueryManage.class);
//
//		final int pageSize = 100;
//		int pageNum = 1;
//		int count = 0;
//		Set<Integer> ids = new HashSet<>();
//		do {
//			manage.setPageNum(pageNum);
//			PagingResult<ChargeItem> chargeItems = manage
//					.query(new QueryCond() {
//
//						@Override
//						public String pageSize() {
//							return String.valueOf(pageSize);
//						}
//
//						@Override
//						public String pageNum() {
//							return null;
//						}
//
//						@Override
//						public String endDate() {
//							return DateParser.format(eDate, "yyyyMMdd");
//						}
//
//						@Override
//						public String beginDate() {
//							return DateParser.format(sDate, "yyyyMMdd");
//						}
//					});
//			pageNum++;
//			ChargeItem[] items = chargeItems.getItems();
//			if (items != null && items.length > 0) {
//				for (ChargeItem item : items) {
//					int ordId = IntegerParser.parse(item.OrdId);
//					T6501_F03 status = manage.getOrderStat(ordId);
//					if (status != null && T6501_F03.CG != status
//							&& "S".equals(item.TransStat)) {
//						ids.add(ordId);
//						manage.updateOrderStat(ordId, T6501_F03.DQR);
//						serviceSession.commit();
//						Map<String, String> params = new HashMap<>();
//						params.put("paymentOrderId", item.OrdId);
//						getResourceProvider().getResource(
//								ChargeOrderExecutor.class).confirm(
//								IntegerParser.parse(item.OrdId), params);
//					}
//				}
//			}
//		} while (count >= pageSize);
//
//		ChargeAmend[] amends = manage.chargeInfo(ids);
//		request.setAttribute("amends", amends);
		forwardView(request, response, getClass());
	}

	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		throwable.printStackTrace();
		Controller controller = getController();
		controller.prompt(request, response, PromptLevel.INFO,
				throwable.getMessage());
		sendRedirect(request, response,
				controller.getViewURI(request, getClass()));
	}
}
