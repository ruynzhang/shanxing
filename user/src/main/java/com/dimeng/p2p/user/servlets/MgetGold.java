package com.dimeng.p2p.user.servlets;

import java.math.BigDecimal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S10.entities.ExchangeRecord;
import com.dimeng.p2p.S61.enums.T6141_F04;
import com.dimeng.p2p.account.user.service.SafetyManage;
import com.dimeng.p2p.account.user.service.entity.Safety;
import com.dimeng.p2p.service.TasteActivityManage;
import com.dimeng.p2p.utlis.JfUtil;
import com.dimeng.p2p.variables.defines.URLVariable;
import com.dimeng.util.StringHelper;

/**
 * 手机领取体验金
 * @author yangjh
 * @time 2015年3月16日
 */
public class MgetGold extends AbstractMobileServicer {
	private static final long serialVersionUID = 1L;

	@Override
	protected boolean mustAuthenticated() {
		return true;
	}
	
	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
					throws Throwable {
		processPost(request, response, serviceSession);
	}
	
	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		SafetyManage userManage = serviceSession.getService(SafetyManage.class);
		Safety data = userManage.get();
		boolean flag=!StringHelper.isEmpty(data.isIdCard) && data.isIdCard.equals(T6141_F04.TG.name());
		if(!flag){//没有实名认证处理
			sendRedirect(request, response,getController().getViewURI(request, Mauth.class));
			return;
		}
		/**序号处理*/
		String randNo=request.getParameter("randNo");//序号
		if(StringHelper.isEmpty(randNo)||randNo.length()!=7){
			getController().prompt(request, response,PromptLevel.ERROR, "序号输入错误,请重新输入!");
			forwardView(request, response, getClass());
			return;
		}
		/**************************活动开始 *********************/
		int userId=serviceSession.getSession().getAccountId();
		TasteActivityManage manage=serviceSession.getService(TasteActivityManage.class);
		if(JfUtil.properties.get("activity_Code").equals(randNo)){
			int count=manage.recordCount(userId,"SMRZ");//看是否存在实名认证记录
			if(count>0){
				getController().prompt(request, response,PromptLevel.ERROR, "该序号体验金只面向资深会员哦");
				sendRedirect(request, response,getController().getViewURI(request, Mshare.class));
				return;
			}
			int _count=manage.recordCount(userId,"LYH");//看是否存在记录
			if(_count>0){
				getController().prompt(request, response,PromptLevel.ERROR, "您已领过序号体验金");
				sendRedirect(request, response,getController().getViewURI(request, Mshare.class));
				return;
			}
			/**添加资深会员记录处理*/
			String amount=JfUtil.properties.getProperty("xhje");
			//插入体验金记录
			ExchangeRecord exRecord=new ExchangeRecord();
			exRecord.userId=userId;
			exRecord.money=new BigDecimal(amount);
			exRecord.source="LYH";
			manage.addRecord(exRecord);
			///更正用户体验金金额
			manage.updGold(userId,new BigDecimal(amount));
			getController().prompt(request, response,PromptLevel.ERROR, "您已成功领取序号"+amount+"元体验金");
			/**发送站内信息*/
			sendMsg(serviceSession, userId, "您通过体验金序号获得"+amount+"元体验金，每个账户只有一次兑换机会");
			sendRedirect(request, response, getConfigureProvider().format(URLVariable.MSHARE));
			return;
		}
		/**************************活动结束 *********************/
		forwardView(request, response, getClass());
	}
}
