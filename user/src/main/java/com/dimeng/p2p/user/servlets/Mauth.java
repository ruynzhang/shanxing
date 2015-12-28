package com.dimeng.p2p.user.servlets;

import java.math.BigDecimal;
import java.net.URLDecoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S10.entities.ExchangeRecord;
import com.dimeng.p2p.account.user.service.SafetyManage;
import com.dimeng.p2p.common.enums.AttestationState;
import com.dimeng.p2p.modules.gzt.service.NciicManage;
import com.dimeng.p2p.service.TasteActivityManage;
import com.dimeng.p2p.utlis.JfResource;
import com.dimeng.p2p.utlis.JfUtil;
import com.dimeng.p2p.variables.defines.URLVariable;
import com.dimeng.util.StringHelper;

/**
 * 手机实名认证
 * @author yangjh
 * @time 2015年3月16日
 */
public class Mauth extends AbstractMobileServicer {
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
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, final ServiceSession serviceSession)
			throws Throwable {
		String idcard = request.getParameter("idCard");
		String name = request.getParameter("name");
		if(name!=null){
			name=URLDecoder.decode(name, "UTF-8"); 
		}
		String PID=request.getParameter("PID");
		String score=request.getParameter("score");
		SafetyManage safetyManage = serviceSession.getService(SafetyManage.class);
		if (!StringHelper.isEmpty(idcard) && !StringHelper.isEmpty(name)) {
			NciicManage nic = serviceSession.getService(NciicManage.class);
			boolean is = nic.check(idcard, name);
			if (is) {
				if (!safetyManage.isIdcard(idcard)) {
					safetyManage.updateName(name, idcard,
							AttestationState.YYZ.name());
					serviceSession.commit();
					/**************************活动开始 *********************/
					int userId=serviceSession.getSession().getAccountId();
					TasteActivityManage manage=serviceSession.getService(TasteActivityManage.class);
					//先看是否有送注册体验金,有记录送800,没有送1000
					int count=manage.recordCount(userId,"ZC");
					int amount=1000;//老用户送1000
					if(count>0){
						amount=800;//新用户送800
					}
					//插入体验金记录
					ExchangeRecord exRecord=new ExchangeRecord();
					exRecord.money=new BigDecimal(amount);
					exRecord.userId=userId;
					exRecord.source="SMRZ";
					manage.addRecord(exRecord);
					///更正用户体验金金额
					manage.updGold(userId,new BigDecimal(amount));
					/**发送站内信息*/
					sendMsg(serviceSession, userId, "实名认证成功,您已获得"+amount+"元体验金");
					/**积分处理*/
					JfResource jfResource = getResourceProvider().getResource(JfResource.class);
					jfResource.addCredits(manage.getUserName(userId), 2, "idcard="+idcard, true);
					/**更新体验金记录*/
					if(!JfUtil.isNull(PID)){
						int _pId=JfUtil.formatPID(PID);
						int _score=JfUtil.formatTyj(score);
						int _count=manage.recordCount(_pId,"YX");//推荐人记录总数
						if(_pId==userId){
							getController().prompt(request, response,PromptLevel.ERROR, "您已领过游戏体验金");
							sendRedirect(request, response, getConfigureProvider().format(URLVariable.MSHARE)+"?score="+_score);
							return;
						}
						if(_count==1){//只有一条记录说明自己玩过
							/**已经实名认证,则给推荐人添加一条记录*/
							exRecord=new ExchangeRecord();
							exRecord.userId=_pId;
							exRecord.money=new BigDecimal(_score);
							exRecord.source="YX";
							exRecord.inviteName=name;
							manage.addRecord(exRecord);
							manage.updGold(_pId,new BigDecimal(_score));
						}
						//更新记录信息,并加体验金
						BigDecimal result=manage.updRecord(userId);
						if(result.intValue()>0){
//							String phone=manage.getPhone(userId);
//							if(null!=phone){
//								/**发送手机短信*/
//								SmsSender smsSender = serviceSession.getService(SmsSender.class);
//								smsSender.send(1, "尊敬的善行用户，恭喜您获得"+result.intValue()+"元体验金，体验金投资体验标换真金，平均年化12% 点击 www.myshanxing.com ，了解更多体验金获取渠道。详询4000-166-277【善行创投】", phone);
//							}
							/**发送站内信息*/
							sendMsg(serviceSession, userId, "您已获取"+result.intValue()+"游戏体验金");
							getController().prompt(request, response,PromptLevel.ERROR, "成功领取"+result.intValue()+"元体验金");
							sendRedirect(request, response, getConfigureProvider().format(URLVariable.MSHARE)+"?score="+_score);
							return;
						}
						getController().prompt(request, response,PromptLevel.ERROR, "您已领过游戏体验金");
						sendRedirect(request, response, getConfigureProvider().format(URLVariable.MSHARE)+"?score="+_score);
						return;
					}
					getController().prompt(request, response,PromptLevel.ERROR, "您已获得"+amount+"元体验金。");
					sendRedirect(request, response, getConfigureProvider().format(URLVariable.MSHARE)+"?score="+JfUtil.formatTyj(score));
					return;
					/**************************活动结束 *********************/
				} else {
					getController().prompt(request, response,PromptLevel.ERROR, "该身份证已认证过！");
				}
			} else {
				getController().prompt(request, response, PromptLevel.ERROR,"实名认证失败");
			}
		}else{
			getController().prompt(request, response,PromptLevel.ERROR, "请填写您的认证信息！");
		}
		forwardView(request, response, getClass());
	}
}
