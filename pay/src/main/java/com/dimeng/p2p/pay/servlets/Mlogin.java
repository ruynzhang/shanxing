package com.dimeng.p2p.pay.servlets;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.http.session.Session;
import com.dimeng.framework.http.session.authentication.AuthenticationException;
import com.dimeng.framework.http.session.authentication.PasswordAuthentication;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S10.entities.ExchangeRecord;
import com.dimeng.p2p.S61.enums.T6141_F04;
import com.dimeng.p2p.account.user.service.SafetyManage;
import com.dimeng.p2p.account.user.service.entity.Safety;
import com.dimeng.p2p.common.KeepParam;
import com.dimeng.p2p.service.TasteActivityManage;
import com.dimeng.p2p.utlis.JfResource;
import com.dimeng.p2p.utlis.JfUtil;
import com.dimeng.p2p.variables.defines.URLVariable;
import com.dimeng.util.StringHelper;

public class Mlogin extends AbstractMobileServicer {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected boolean mustAuthenticated() {
		return false;
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
		final ConfigureProvider configureProvider = getResourceProvider()
				.getResource(ConfigureProvider.class);
		if (!JfUtil.isActivity()) {
			sendRedirect(request, response, configureProvider.format(URLVariable.M_REGISTER));
			return;
		}
		String postfix=KeepParam.keepParamByString(request,ignoreKeys);
		Session session = serviceSession.getSession();
		String PID=request.getParameter("PID");
		String score=request.getParameter("score");
		String code=request.getParameter("code");
		
		PasswordAuthentication authentication = new PasswordAuthentication();
		String accountname = JfUtil.trimStr(request.getParameter("accountName"));
		authentication.setAccountName(accountname.trim());
		authentication.setPassword(request.getParameter("password"));
		authentication.setVerifyCodeType("abc");
		authentication.setVerifyCode(session
				.getVerifyCode(authentication.getVerifyCodeType()));
		try {
			session.checkIn(request, response, authentication);
			TasteActivityManage manage=serviceSession.getService(TasteActivityManage.class);
			int userId=session.getAccountId();
			String userName=manage.getUserName(userId);
			/**积分处理*/
			JfResource jfResource = getResourceProvider().getResource(JfResource.class);
			jfResource.addCreditsByLogin(userName);
			/**保留体验金记录*/
			if(!JfUtil.isNull(PID)){
				/**是否已实名认证*/
				SafetyManage userManage = serviceSession.getService(SafetyManage.class);
				Safety data = userManage.get();
				boolean flag=!StringHelper.isEmpty(data.isIdCard) && data.isIdCard.equals(T6141_F04.TG.name());
				int _pId=JfUtil.formatPID(PID);
				int _score=JfUtil.formatTyj(score);
				int _count=manage.recordCount(_pId,"YX");//推荐人记录总数
				int count=manage.recordCount(userId,"YX");//当前用户体验金记录总数
				if(count==0){
					//插入体验金记录
					ExchangeRecord exRecord=new ExchangeRecord();
					exRecord.userId=userId;
					exRecord.money=new BigDecimal(_score);
					exRecord.source="YX";
					exRecord.isAuth=false;
					manage.addRecord(exRecord);
				}
				if(!flag){//未认证转去认证页面
					sendRedirect(request, response, getConfigureProvider().format(URLVariable.MAUTH)+"?PID="+PID+"&score="+_score);
					return;
				}
				if(_pId==userId){
					getController().prompt(request, response,PromptLevel.ERROR, "您已领过游戏体验金");
					sendRedirect(request, response, getConfigureProvider().format(URLVariable.MSHARE)+"?score="+_score);
					return;
				}
				if(_count==1){//只有一条记录说明自己玩过
					/**已经实名认证,则给推荐人添加一条记录*/
					ExchangeRecord exRecord=new ExchangeRecord();
					exRecord.userId=_pId;
					exRecord.money=new BigDecimal(_score);
					exRecord.source="YX";
					exRecord.inviteName=data.name;
					manage.addRecord(exRecord);
					manage.updGold(_pId,new BigDecimal(_score));
				}
				//更新记录信息,并加体验金
				manage.updRecord(userId);
				if(count==0){
//					String phone=manage.getPhone(userId);
//					if(null!=phone){
//						/**发送手机短信*/
//						SmsSender smsSender = serviceSession.getService(SmsSender.class);
//						smsSender.send(1, "尊敬的善行用户，恭喜您获得"+_score+"元体验金，体验金投资体验标换真金，平均年化12% 点击 www.myshanxing.com ，了解更多体验金获取渠道。详询4000-166-277【善行创投】", phone);
//					}
					/**发送站内信息*/
					sendMsg(serviceSession, userId, "您已获取"+_score+"游戏体验金");
					getController().prompt(request, response,PromptLevel.ERROR, "成功领取"+_score+"元体验金");
					sendRedirect(request, response, getConfigureProvider().format(URLVariable.MSHARE)+"?score="+_score);
					return;
				}
				if(_count==1){
					/**发送站内信息*/
					sendMsg(serviceSession, _pId, "您邀好友"+data.name+"帮您获取"+_score+"游戏体验金");
					getController().prompt(request, response,PromptLevel.ERROR, "您已帮好友赚取"+_score+"游戏体验金");
					sendRedirect(request, response, getConfigureProvider().format(URLVariable.MSHARE)+"?score="+_score);
					return;
				}
				getController().prompt(request, response,PromptLevel.ERROR, "您已领过游戏体验金");
				sendRedirect(request, response, getConfigureProvider().format(URLVariable.MSHARE)+"?score="+_score);
				return;
			}
			String authName=manage.AuthName(userId);
			if(JfUtil.isNull(authName)){//未实名认证,转向实名认证页面
				sendRedirect(request, response, getConfigureProvider().format(URLVariable.MAUTH));
				return;
			}
			if(!JfUtil.isNull(code) && code.equals(JfUtil.properties.getProperty("activity_Code"))){
				int count=manage.recordCount(userId,"SMRZ");//看是否存在实名认证记录
				if(count>0){
					getController().prompt(request, response,PromptLevel.ERROR, "很抱歉，您已领取过注册实名认证1000元体验金，不可重复领取。");
					sendRedirect(request, response, getConfigureProvider().format(URLVariable.MSHARE)+"?p=1");
					return;
				}
				int _count=manage.recordCount(userId,"LYH");//看是否存在记录
				if(_count>0){
					getController().prompt(request, response,PromptLevel.ERROR, "很抱歉，您通过该口令已领取过体验金。");
					sendRedirect(request, response, getConfigureProvider().format(URLVariable.MSHARE)+"?p=1");
					return;
				}
				/**添加资深会员记录处理*/
				String amount="1000";
				//插入体验金记录
				ExchangeRecord exRecord=new ExchangeRecord();
				exRecord.userId=userId;
				exRecord.money=new BigDecimal(amount);
				exRecord.source="LYH";
				manage.addRecord(exRecord);
				///更正用户体验金金额
				manage.updGold(userId,new BigDecimal(amount));
				getController().prompt(request, response,PromptLevel.ERROR, "恭喜您！成功领取1000元体验金。");
				/**发送站内信息*/
				sendMsg(serviceSession, userId, "恭喜您！成功领取1000元体验金。体验金可用于体验标投资，所得收益可直接用于提现");
				sendRedirect(request, response, getConfigureProvider().format(URLVariable.MSHARE)+"?p=1");
				return;
			}
			getController().prompt(request, response,PromptLevel.ERROR, "很抱歉，该口令有误。");
			sendRedirect(request, response, getConfigureProvider().format(URLVariable.MSHARE)+"?p=1");
//			sendRedirect(request, response, configureProvider.format(URLVariable.MGETGOLD));
		} catch (AuthenticationException e) {
			logger.error("Mlogin catch err:"+e);
			getResourceProvider().log(e.getMessage());
			prompt(request, response, PromptLevel.ERROR,e.getMessage());
			sendRedirect(request, response, configureProvider.format(URLVariable.MLOGIN)+postfix);
		}
	}
	private static List<String> ignoreKeys = new ArrayList<String>();
		
	static {
		ignoreKeys.add("password");
	}
}
