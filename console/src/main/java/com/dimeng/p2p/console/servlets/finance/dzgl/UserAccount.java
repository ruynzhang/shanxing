package com.dimeng.p2p.console.servlets.finance.dzgl;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.LogicalException;
import com.dimeng.p2p.S61.entities.T6101;
import com.dimeng.p2p.S61.entities.T6110;
import com.dimeng.p2p.S61.enums.T6101_F03;
import com.dimeng.p2p.escrow.huichao.function.model.ResultVo;
import com.dimeng.p2p.escrow.huichao.function.util.FunctionClientUtil;
import com.dimeng.p2p.escrow.huichao.service.UserManger;
import com.dimeng.util.parser.IntegerParser;

public class UserAccount extends AbstractDzglServlet {

	private static final long serialVersionUID = -8763942853365053754L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		int id = IntegerParser.parse(request.getParameter("id"));
		UserManger userManager=serviceSession.getService(UserManger.class);
		T6110 t6110=userManager.selectT6110(id, false);
		Map<String,String> param=new HashMap<String,String>();
		param.put("nick_name", t6110.F02);
		ResultVo resultVo=FunctionClientUtil.sendCheckBalance(param,this.getResourceProvider());
		if(resultVo.getErrorNo()>=0){
			Map<String,Object> data=resultVo.getData();
			T6101 t6101_w=userManager.selectT6101(t6110.F01, T6101_F03.WLZH);
			T6101 t6101_s=userManager.selectT6101(t6110.F01, T6101_F03.SDZH);
			data.put("AvlBal", t6101_w.F06);
			data.put("FrzBal", t6101_s.F06);
			request.setAttribute("entity", data);
		}else{
			throw new LogicalException(resultVo.getErrorMessage());
		}
//		UserAcctQueryManage manage = serviceSession.getService(UserAcctQueryManage.class);
//		UserAcctQueryEntity entity = manage.accountInfo(id);
//		request.setAttribute("entity", entity);
		forward(request, response,
				getController().getViewURI(request, getClass()));
	}
}
