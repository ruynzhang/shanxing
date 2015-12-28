package com.dimeng.p2p.console.servlets.account.qyxx.dgzh;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.ParameterException;
import com.dimeng.p2p.S61.entities.T6114;
import com.dimeng.p2p.console.servlets.account.AbstractAccountServlet;
import com.dimeng.p2p.console.servlets.account.qyxx.QyList;
import com.dimeng.p2p.modules.account.console.service.QyManage;
import com.dimeng.util.StringHelper;
import com.dimeng.util.parser.IntegerParser;

@Right(id = "P2P_C_ACCOUNT_QYXX_UPDATEDGZH",  name = "企业对公账户修改")
public class UpdateDgzh extends AbstractAccountServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		QyManage manage = serviceSession.getService(QyManage.class);
		int id = IntegerParser.parse(request.getParameter("id"));
		request.setAttribute("info", manage.getDgzh(id));
		request.setAttribute("bank", manage.getBank());
		forwardView(request, response, getClass());
	}

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		try {
			T6114 entity = new T6114();
			entity.parse(request);
			entity.F04 = IntegerParser.parse(request.getParameter("xian"));
			String bankCarNum = entity.F07;
			if(!bankCarNum.equals(entity.F06)){
				throw new ParameterException("银行卡两次输入不一致");
			}
			if(StringHelper.isEmpty(bankCarNum) || !checkBankCard(bankCarNum)){
				throw new ParameterException("银行卡错误");
			}
			entity.F07 = StringHelper.encode(bankCarNum);
			StringBuilder sb = new StringBuilder();
			sb.append(bankCarNum.substring(0,3));
	    	sb.append("*************");
	    	sb.append(bankCarNum.substring(bankCarNum.length()-4,bankCarNum.length()));
	    	entity.F06 = sb.toString();
			QyManage manage = serviceSession.getService(QyManage.class);
			manage.updateDgzh(entity);
			sendRedirect(request, response, getController().getURI(request, QyList.class));
		} catch (Exception e) {
			prompt(request, response, PromptLevel.ERROR, e.getMessage());
			processGet(request, response, serviceSession);
		}
		
	}
	
	
	/**
	   * 校验银行卡卡号
	   * 
	    * @param cardId
	   * @return
	   */
	   protected boolean checkBankCard(String cardId) {
	      if (cardId.trim().length() < 16) {
	         return false;
	      }
	      char bit = getBankCardCheckCode(cardId
	            .substring(0, cardId.length() - 1));
	      if (bit == 'N') {
	         return false;
	      }
	      return cardId.charAt(cardId.length() - 1) == bit;
	   }
	 

	   /**
	   * 从不含校验位的银行卡卡号采用 Luhm 校验算法获得校验位
	   * 
	    * @param nonCheckCodeCardId
	   * @return
	   */
	   protected char getBankCardCheckCode(String nonCheckCodeCardId) {
	      if (nonCheckCodeCardId == null
	            || nonCheckCodeCardId.trim().length() == 0
	            || !nonCheckCodeCardId.matches("\\d+")) {
	         // 如果传的不是数据返回N
	         return 'N';
	      }
	      char[] chs = nonCheckCodeCardId.trim().toCharArray();
	      int luhmSum = 0;
	      for (int i = chs.length - 1, j = 0; i >= 0; i--, j++) {
	         int k = chs[i] - '0';
	         if (j % 2 == 0) {
	            k *= 2;
	            k = k / 10 + k % 10;
	         }
	         luhmSum += k;
	      }
	      return (luhmSum % 10 == 0) ? '0' : (char) ((10 - luhmSum % 10) + '0');
	   }

	
	
}
