package com.dimeng.p2p.user.servlets;

import java.math.BigDecimal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.http.session.Session;
import com.dimeng.framework.http.session.SessionManager;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S10.entities.ExchangeRecord;
import com.dimeng.p2p.service.TasteActivityManage;
import com.dimeng.p2p.utlis.JfUtil;
import com.dimeng.p2p.variables.defines.URLVariable;

/**
 * 手机体验金分享
 * @author yangjh
 * @time 2015年3月16日
 */
public class Mshare extends AbstractMobileServicer	 {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected boolean mustAuthenticated() {
		return false;
	}
	
	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
					throws Throwable {
		final ConfigureProvider configureProvider = getResourceProvider()
				.getResource(ConfigureProvider.class);
		if (!JfUtil.isActivity()) {
			sendRedirect(request, response, configureProvider.format(URLVariable.M_REGISTER));
			return;
		}
		Session session = serviceSession.getSession();
		if (session == null) {
			session = getResourceProvider().getResource(SessionManager.class)
					.getSession(request, response, true);
		}
		/**************************活动开始 *********************/
		String PID=request.getParameter("PID");
		String score=request.getParameter("score");
		/**处理登录用户*/
		if (session != null && !session.isAuthenticated()) {
			sendRedirect(request, response, getConfigureProvider().format(URLVariable.MLOGIN)+"?PID="+PID+"&score="+score);
			return;
		}
		TasteActivityManage manage=serviceSession.getService(TasteActivityManage.class);
		int userId=serviceSession.getSession().getAccountId();
		/**是否已实名认证*/
		String name=manage.AuthName(userId);
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
		if(null==name){//未认证转去认证页面
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
			exRecord.inviteName=name;
			manage.addRecord(exRecord);
			manage.updGold(_pId,new BigDecimal(_score));
		}
		//更新记录信息,并加体验金
		manage.updRecord(userId);
		if(count==0){
//			String phone=manage.getPhone(userId);
//			if(null!=phone){
//				/**发送手机短信*/
//				SmsSender smsSender = serviceSession.getService(SmsSender.class);
//				smsSender.send(1, "尊敬的善行用户，恭喜您获得"+_score+"元体验金，体验金投资体验标换真金，平均年化12% 点击 www.myshanxing.com ，了解更多体验金获取渠道。详询4000-166-277【善行创投】", phone);
//			}
			/**发送站内信息*/
			sendMsg(serviceSession, userId, "您已获取"+_score+"游戏体验金");
			getController().prompt(request, response,PromptLevel.ERROR, "成功领取"+_score+"元体验金");
			sendRedirect(request, response, getConfigureProvider().format(URLVariable.MSHARE)+"?score="+_score);
			return;
		}
		if(_count==1){
			/**发送站内信息*/
			sendMsg(serviceSession, _pId, "您邀好友"+name+"帮您获取"+_score+"游戏体验金");
			getController().prompt(request, response,PromptLevel.ERROR, "您已帮好友赚取"+_score+"游戏体验金");
			sendRedirect(request, response, getConfigureProvider().format(URLVariable.MSHARE)+"?score="+_score);
			return;
		}
		getController().prompt(request, response,PromptLevel.ERROR, "您已领过游戏体验金");
		sendRedirect(request, response, getConfigureProvider().format(URLVariable.MSHARE)+"?score="+_score);
	}
	
	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		forwardView(request, response, getClass());
	}
	
	
}
