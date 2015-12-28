package com.dimeng.p2p.console.servlets.finance.dzgl;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.escrow.huichao.function.model.ResultVo;
import com.dimeng.p2p.escrow.huichao.service.DzglManager;
import com.dimeng.util.parser.IntegerParser;

public class TransStat extends AbstractDzglServlet {

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		DzglManager manage = serviceSession.getService(DzglManager.class);
		int id = IntegerParser.parse(request.getParameter("id"));
		ResultVo resultVo=manage.query(id);
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html");
		if(resultVo.getErrorNo()<0){
			response.getWriter().write("查询失败,失败的原因["+resultVo.getErrorMessage()+"]");
		}else{
			List<Map<String,String>>tradeList=(List<Map<String, String>>) resultVo.getData().get("tradeList");
			if(tradeList.size()>0){
				Map<String,String> maps=tradeList.get(0);
				String status="00".equals(maps.get("tradeStatus"))?"成功":"失败";
				response.getWriter().write("订单号为：["+id+"]的状态为:["+status+"]状态码:["+maps.get("tradeStatus")+"]");
			}else{
				response.getWriter().write("未能查询到订单信息");
			}
			
		}
		
	}
}
