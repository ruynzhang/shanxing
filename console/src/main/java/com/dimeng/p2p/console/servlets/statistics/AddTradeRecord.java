package com.dimeng.p2p.console.servlets.statistics;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.modules.statistics.console.service.TradeRecordManage;
import com.dimeng.p2p.modules.statistics.console.service.entity.TradeRecordVO;
import com.dimeng.p2p.utlis.JfUtil;
import com.shanlin.framework.communication.http.HttpUtil;

@Right(id = "P2P_C_STATISTICS_ADDTRADERECORD", name = "添加线下交易记录")
public class AddTradeRecord extends AbstractStatisticsServlet {
	private static final long serialVersionUID = 1L;
	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		forwardView(request, response, getClass());
	}
	
	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		TradeRecordManage manage = serviceSession.getService(TradeRecordManage.class);
		TradeRecordVO query = new TradeRecordVO();
		query.parse(request);//设置查询对象
		int id=manage.add(query);
		// 添加积分
		int credits=JfUtil.caljf(query.cj_amount, Integer.parseInt(query.product_qx),true);
		String post_url=JfUtil.api_url()+"&arg=13&idcard="+query.idcard+"&credits="+credits;
		Map<String, Object> result=HttpUtil.create().get(post_url).execute2Map();
		if("1".equals(result.get("status").toString())){
			manage.update(id);
		}
		sendRedirect(request, response,getController().getURI(request, TradeRecordList.class));
	}
}
