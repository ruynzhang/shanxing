package com.dimeng.p2p.console.servlets.finance.dzgl;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.util.StringHelper;
import com.dimeng.util.parser.DateParser;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_FINANCE_TRFQUERY", isMenu = true, name = "商户扣款对账")
public class TrfQuery extends AbstractDzglServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
//		TrfQueryManage manage = serviceSession.getService(TrfQueryManage.class);
//		final Date date = new Date();
//		final int pageNum = IntegerParser.parse(request
//				.getParameter(PAGING_CURRENT));
//		PagingResult<TrfItem> pagingResult = manage.query(new QueryCond() {
//
//			@Override
//			public String pageSize() {
//				return String.valueOf(20);
//			}
//
//			@Override
//			public String pageNum() {
//				return pageNum > 0 ? String.valueOf(pageNum) : "1";
//			}
//
//			@Override
//			public String endDate() {
//				return DateParser.format(date, "yyyyMMdd");
//			}
//
//			@Override
//			public String beginDate() {
//				return DateParser.format(date, "yyyyMMdd");
//			}
//		});
//		request.setAttribute("pagingResult", pagingResult);
		forward(request, response,
				getController().getViewURI(request, getClass()));
	}

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		if (StringHelper.isEmpty(startDate) && StringHelper.isEmpty(endDate)) {
			processGet(request, response, serviceSession);
			return;
		}
		if (StringHelper.isEmpty(startDate)) {
			request.setAttribute("errorMsg", "请选择起始时间");
			processGet(request, response, serviceSession);
			return;
		}
		if (StringHelper.isEmpty(endDate)) {
			request.setAttribute("errorMsg", "请选择结束时间");
			processGet(request, response, serviceSession);
			return;
		}
		final Date sDate = DateParser.parse(startDate, "yyyy-MM-dd");
		final Date eDate = DateParser.parse(endDate, "yyyy-MM-dd");
		if (sDate.getTime() >= eDate.getTime()) {
			request.setAttribute("errorMsg", "时间范围错误，起始时间不能大于结束时间");
			processGet(request, response, serviceSession);
			return;
		}
		final int pageNum = IntegerParser.parse(request
				.getParameter(PAGING_CURRENT));
//		TrfQueryManage manage = serviceSession.getService(TrfQueryManage.class);
//		PagingResult<TrfItem> pagingResult = manage.query(new QueryCond() {
//
//			@Override
//			public String pageSize() {
//				return String.valueOf(20);
//			}
//
//			@Override
//			public String pageNum() {
//				return pageNum > 0 ? String.valueOf(pageNum) : "1";
//			}
//
//			@Override
//			public String endDate() {
//				return DateParser.format(eDate, "yyyyMMdd");
//			}
//
//			@Override
//			public String beginDate() {
//				return DateParser.format(sDate, "yyyyMMdd");
//			}
//		});
//		request.setAttribute("pagingResult", pagingResult);
		forward(request, response,
				getController().getViewURI(request, getClass()));
	}

}
