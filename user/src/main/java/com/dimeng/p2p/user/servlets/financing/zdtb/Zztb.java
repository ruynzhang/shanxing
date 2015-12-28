package com.dimeng.p2p.user.servlets.financing.zdtb;

import java.math.BigDecimal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.modules.bid.user.service.ZdtbManage;
import com.dimeng.p2p.modules.bid.user.service.query.AutoBidQuery;
import com.dimeng.p2p.user.servlets.financing.AbstractFinancingServlet;
import com.dimeng.util.parser.IntegerParser;

public class Zztb extends AbstractFinancingServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -2258438940746128554L;

	@Override
	protected void processPost(final HttpServletRequest request,
			final HttpServletResponse response,
			final ServiceSession serviceSession) throws Throwable {
		ZdtbManage autoUtilFinacingManage = serviceSession
				.getService(ZdtbManage.class);

		autoUtilFinacingManage.save(new AutoBidQuery() {
			@Override
			public BigDecimal getTimeMoney() {
				return new BigDecimal(request.getParameter("timeMoney"));
			}

			@Override
			public BigDecimal getSaveMoney() {
				return new BigDecimal(request.getParameter("saveMoney"));
			}

			@Override
			public BigDecimal getRateStart() {
				return new BigDecimal(request.getParameter("rateStart"))
						.divide(new BigDecimal(100));
			}

			@Override
			public BigDecimal getRateEnd() {
				return new BigDecimal(request.getParameter("rateEnd"))
						.divide(new BigDecimal(100));
			}

			@Override
			public int getLevelStart() {
				return IntegerParser.parse(request.getParameter("levelStart"));
			}

			@Override
			public int getLevelEnd() {
				return IntegerParser.parse(request.getParameter("levelEnd"));
			}


			@Override
			public int getJkqxStart() {
				return IntegerParser.parse(request.getParameter("jkqxStart"));
			}

			@Override
			public int getJkqxEnd() {
				return IntegerParser.parse(request.getParameter("jkqxEnd"));
			}
		});

		forward(request, response, getController().getURI(request, Index.class));
	}
}
