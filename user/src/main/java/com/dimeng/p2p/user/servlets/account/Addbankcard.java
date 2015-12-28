package com.dimeng.p2p.user.servlets.account;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.account.user.service.BankCardManage;
import com.dimeng.p2p.account.user.service.UserInfoManage;
import com.dimeng.p2p.account.user.service.entity.BankCard;
import com.dimeng.p2p.account.user.service.entity.BankCardQuery;
import com.dimeng.p2p.common.enums.BankCardStatus;
import com.dimeng.util.StringHelper;
import com.dimeng.util.parser.IntegerParser;

public class Addbankcard extends AbstractAccountServlet{
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, final ServiceSession serviceSession)
			throws Throwable {
		BankCardManage  bankCardManage = serviceSession.getService(BankCardManage.class);
		
		String banknumber = request.getParameter("banknumber");
		if(StringHelper.isEmpty(banknumber) || !checkBankCard(banknumber)){
			getController().prompt(request, response, PromptLevel.ERROR,
					"银行卡错误");
			getController().forwardView(request, response, Addbankcard.class);
			return ;
		}
		BankCard bcd = bankCardManage.getBankCar(banknumber);
		
		if(!serviceSession.getService(UserInfoManage.class).isSmrz()){
			getController().forwardView(request, response, Addbankcard.class);
			//未实名认证
			return;
		}
		
		BankCardQuery query = new BankCardQuery() {
			@Override
			public String getSubbranch() {
				return request.getParameter("subbranch");
			}
			
			@Override
			public String getStatus() {
				return BankCardStatus.QY.name();
			}
			
			@Override
			public String getCity() {
				return request.getParameter("xian");
			}
			
			@Override
			public String getBankNumber() {
				return request.getParameter("banknumber");
			}
			
			@Override
			public int getBankId() {
				return IntegerParser.parse(request.getParameter("bankname"));
			}
			
			@Override
			public int getAcount() {
				return serviceSession.getSession().getAccountId();
			}
		};
		if(bcd != null){
			//启用银行卡
			int id = bcd.id;
			if(bcd.acount != serviceSession.getSession().getAccountId())
			{
				getController().prompt(request, response, PromptLevel.ERROR,
						"当前银行卡号已存在！");
				getController().forwardView(request, response, Addbankcard.class);
				return ;
			}
			bankCardManage.update(id, query);
		}else{
			bankCardManage.AddBankCar(query);
		}
		request.setAttribute("close", "close");
		getController().forwardView(request, response, Addbankcard.class);
		
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
