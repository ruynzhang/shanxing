package com.dimeng.p2p.console.servlets.bid.tyjgl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.common.Expemonyinfo;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.modules.bid.console.service.BidManage;
import com.dimeng.util.parser.IntegerParser;

/**
 * 查看体验标的详情
 * @description TODO
 * @author wuyongchang
 * @date 2015年1月15日
 *
 */

@Right(id = "P2P_C_BUSI_VIEWPROJECTTYJ", name = "体验标的项目信息")
public class ViewProjectTyj extends AbstractBidServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -268955794485557959L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		final BidManage bidManage = serviceSession.getService(BidManage.class);
		int loanId = IntegerParser.parse(request.getParameter("loanId"));
		Expemonyinfo loan = bidManage.getTyj(loanId);
		request.setAttribute("loan", loan);
		super.processGet(request, response, serviceSession);
	}
}
