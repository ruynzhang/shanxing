package com.dimeng.p2p.user.servlets.capital;

import java.math.BigDecimal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S10.entities.ExchangeRecord;
import com.dimeng.p2p.S61.enums.T6141_F04;
import com.dimeng.p2p.account.user.service.SafetyManage;
import com.dimeng.p2p.account.user.service.entity.Safety;
import com.dimeng.p2p.service.TasteActivityManage;
import com.dimeng.p2p.user.servlets.account.Safetymsg;
import com.dimeng.p2p.utlis.JfUtil;
import com.dimeng.p2p.utlis.MerCached;
import com.dimeng.util.StringHelper;

/**
 * 体验金序号兑换
 * @author yangjh
 * @time 2015年3月18日
 */
public class Mytyjshpaper extends AbstractCapitalServlet {

	private static final long serialVersionUID = 1L;
	
	@Override
	protected boolean mustAuthenticated() {
		return true;
	}
	
	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		/**校验是否实名认证*/
		SafetyManage userManage = serviceSession.getService(SafetyManage.class);
		Safety data = userManage.get();
		boolean flag=!StringHelper.isEmpty(data.isIdCard) && data.isIdCard.equals(T6141_F04.TG.name());
		if(!flag){//没有实名认证处理
			sendRedirect(request, response,getController().getViewURI(request, Safetymsg.class));
			return;
		}
		/**************************活动开始 *********************/
		int userId=serviceSession.getSession().getAccountId();
		TasteActivityManage manage=serviceSession.getService(TasteActivityManage.class);
		Object obj=MerCached.client.get(MerCached.AC_PREFIX+manage.getUserName(userId));
		String activityCode=obj==null?"":obj.toString();
		boolean fff=!JfUtil.isNull(activityCode) && activityCode.equals(JfUtil.properties.getProperty("activityCode"));
		if(fff){
			/**序号处理*/
			String randNo=request.getParameter("randNo");//序号
			if(StringHelper.isEmpty(randNo)||randNo.length()!=7){
				request.setAttribute("msg", "序号输入错误,请重新输入!");
				forwardView(request, response, getClass());
				return;
			}
			if(JfUtil.properties.get("activity_Code").equals(randNo)){
				int count=manage.recordCount(userId,"SMRZ");//看是否存在实名认证记录
				if(count>0){
					request.setAttribute("msg", "该序号体验金只面向资深会员哦");
					forwardView(request, response, getClass());
					return;
				}
				int _count=manage.recordCount(userId,"LYH");//看是否存在记录
				if(_count>0){
					request.setAttribute("msg", "您已领过序号体验金");
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
				request.setAttribute("msg", "您已成功领取序号"+amount+"元体验金");
				/**发送站内信息*/
				manage.sendLetter(userId, "体验金", "您通过体验金序号获得"+amount+"元体验金，每个账户只有一次兑换机会");
			}
		}else{
			request.setAttribute("msg", "你没有权限领取体验金");
		}
		forwardView(request, response, getClass());
	}
}
