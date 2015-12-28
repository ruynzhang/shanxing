package com.dimeng.p2p.user.servlets.capital;

import java.math.BigDecimal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S10.entities.ActivityNum;
import com.dimeng.p2p.S10.entities.ExchangeRecord;
import com.dimeng.p2p.S61.enums.T6141_F04;
import com.dimeng.p2p.account.user.service.SafetyManage;
import com.dimeng.p2p.account.user.service.entity.Safety;
import com.dimeng.p2p.service.TasteActivityManage;
import com.dimeng.p2p.utlis.JfUtil;
import com.dimeng.util.StringHelper;

public class Mytyjklpaper extends AbstractCapitalServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected boolean mustAuthenticated() {
		return true;
	}
	
	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		/**************************活动开始 *********************/
		int userId=serviceSession.getSession().getAccountId();
		TasteActivityManage manage=serviceSession.getService(TasteActivityManage.class);
		if(JfUtil.isActivity()){
			String randNo=request.getParameter("randNo");//口令
			if(!StringHelper.isEmpty(randNo) && (randNo.length()>=5 && randNo.length()<=7)){
				/**口令处理*/
				if(randNo.length()==6){
					int count=manage.activityNumCount(1);
					//每个人最多只能领5次
					if(count>=5){
						request.setAttribute("msg", "太强啦！每个用户最多使用5个口令，您已成功使用，累计领取体验金500元！");
						forwardView(request, response, getClass()); 
						return;
					}
					ActivityNum record=manage.findActivityNum(randNo,1);
					if(record==null){
						request.setAttribute("msg", "很抱歉，该口令已失效。");
						forwardView(request, response, getClass());
						return;
					}
					/**体验金处理*/
					String amount=JfUtil.properties.getProperty("klje");
					//插入体验金记录
					ExchangeRecord exRecord=new ExchangeRecord();
					exRecord.activitynum_id=record.id;
					exRecord.userId=userId;
					exRecord.money=new BigDecimal(amount);
					exRecord.source="KL";
					manage.addRecord(exRecord);
					///更正用户体验金金额
					manage.updGold(userId,new BigDecimal(amount));
					//标识序号已领取
					manage.updActivityNum(record.id);
					/**发送站内信息*/
					manage.sendLetter(userId, "体验金", "恭喜您！成功领取100元体验金");
					request.setAttribute("msg", "恭喜您！成功领取100元体验金。");
					forwardView(request, response, getClass());
					return;
				}
				SafetyManage userManage = serviceSession.getService(SafetyManage.class);
				Safety data = userManage.get();
				boolean isAuth=!StringHelper.isEmpty(data.isIdCard) && data.isIdCard.equals(T6141_F04.TG.name());	
				if(!isAuth){
					getController().prompt(request, response,PromptLevel.INFO, "未实名认证");
					forwardView(request, response, getClass());
					return;
				}
				if(randNo.length()==5){
					/**体验卡处理*/
					int count=manage.activityNumCount(2);
					if(count>0){
						request.setAttribute("msg", "很抱歉，您已领取过体验卡888元体验金，不可重复领取，请知悉！");
						forwardView(request, response, getClass()); 
						return;
					}
					ActivityNum record=manage.findActivityNum(randNo,2);
					if(record==null){
						request.setAttribute("msg", "很抱歉，该体验卡已失效。");
						forwardView(request, response, getClass());
						return;
					}
					//插入体验金记录
					String amount="888";
					ExchangeRecord exRecord=new ExchangeRecord();
					exRecord.userId=userId;
					exRecord.money=new BigDecimal(amount);
					exRecord.source="XH";
					manage.addRecord(exRecord);
					///更正用户体验金金额
					manage.updGold(userId,new BigDecimal(amount));
					//标识序号已领取
					manage.updActivityNum(record.id);
					request.setAttribute("msg", "恭喜您！成功领取体验卡"+amount+"元体验金。");
					/**发送站内信息*/
					manage.sendLetter(userId, "体验金", "恭喜您！成功领取体验卡"+amount+"元体验金。体验金可用于体验标投资，所得收益可直接用于提现");
					forwardView(request, response, getClass());
					return;
				}
				/**激活码处理*/
				if(JfUtil.properties.get("activity_Code").equals(randNo)){
					int count=manage.recordCount(userId,"SMRZ");//看是否存在实名认证记录
					if(count>0){
						request.setAttribute("msg", "很抱歉，您已领取过注册实名认证1000元体验金，不可重复领取，请知悉！");
						forwardView(request, response, getClass());
						return;
					}
					int _count=manage.recordCount(userId,"LYH");//看是否存在记录
					if(_count>0){
						request.setAttribute("msg", "很抱歉，该口令已失效。");
						forwardView(request, response, getClass());
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
					request.setAttribute("msg", "恭喜您！成功领取1000元体验金。");
					/**发送站内信息*/
					manage.sendLetter(userId, "体验金", "恭喜您！成功领取1000元体验金。体验金可用于体验标投资，所得收益可直接用于提现");
					forwardView(request, response, getClass());
					return;
				}
			}
			request.setAttribute("msg", "很抱歉，您输入的口令有误,请重新输入!");
			forwardView(request, response, getClass());
			return;
		}else{
			request.setAttribute("msg", "很抱歉，活动还没开始...");
		}
		forwardView(request, response, getClass());
	}
}
