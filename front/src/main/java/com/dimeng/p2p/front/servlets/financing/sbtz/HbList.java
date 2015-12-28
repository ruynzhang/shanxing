package com.dimeng.p2p.front.servlets.financing.sbtz;

import java.math.BigDecimal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S10.entities.RedPacketRecord;
import com.dimeng.p2p.front.servlets.financing.AbstractFinancingServlet;
import com.dimeng.p2p.service.RedPacketManage;
import com.dimeng.p2p.utlis.DateUtil;

public class HbList extends AbstractFinancingServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request, HttpServletResponse response, ServiceSession serviceSession) throws Throwable {
		processPost(request, response, serviceSession);
	}

	@Override
	protected void processPost(final HttpServletRequest request, final HttpServletResponse response, final ServiceSession serviceSession) throws Throwable {

		if (serviceSession.getSession() == null) {
			return;
		}
		String amout = request.getParameter("amount");
		int userId = serviceSession.getSession().getAccountId();
		RedPacketManage manage = serviceSession.getService(RedPacketManage.class);
		RedPacketRecord query = new RedPacketRecord();
		query.parse(request);//设置界面传来的参数
		query.userId = userId;
		query.state = 1;
		query.ranges = new BigDecimal(amout);
		query.endTime = DateUtil.str2Timestamp(DateUtil.getSysDate());
		//分页对象
		List<RedPacketRecord> list = manage.getList(query);
		if (list != null && list.size() > 0) {
			StringBuffer str = new StringBuffer();
			str.append("<div class=\"info fr\" id=\"hb_div\">");
			str.append("<p class=\"f20 gray33\">选择红包</p>");
			str.append("<select name=\"hb_id\" class=\"cs-select cs-skin-border\" id=\"hb_select\">");
			str.append("<option value=\"0\">不使用红包</option>");
			for (RedPacketRecord record : list) {
				str.append("<option value=\"" + record.id + "\">" + record.amount.intValue() + "元，" + DateUtil.getDate2Str(record.endTime, "yyyy/MM/dd") + "过期</option>");
			}
			str.append("</select>");
			str.append("</div>");
			response.setContentType("text/html;charset=" + getResourceProvider().getCharset());
			response.getWriter().print(str.toString());
			response.getWriter().flush();
		}
	}
}
