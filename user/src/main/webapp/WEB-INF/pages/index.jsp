<%@page import="com.dimeng.p2p.modules.bid.user.service.entity.AccountBalance"%>
<%@page import="com.dimeng.p2p.user.servlets.account.Upload"%>
<%@page import="com.dimeng.p2p.account.user.service.entity.UserBase"%>
<%@page import="com.dimeng.p2p.account.user.service.UserBaseManage"%>
<%@page import="com.dimeng.p2p.service.PtAccountManage"%>
<%@page import="com.dimeng.p2p.user.servlets.QueryJf"%>
<%@page import="com.dimeng.p2p.user.servlets.capital.Mytyjshpaper"%>
<%@page import="com.dimeng.p2p.user.servlets.capital.Mytyjklpaper"%>
<%@page import="com.dimeng.p2p.service.TasteActivityManage"%>
<%@page import="com.dimeng.p2p.utlis.JfUtil"%>
<%@page import="java.util.Map"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.entity.UnpayEarnings"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.entity.EarnFinancingTotal"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.LctjManage"%>
<%@page import="com.dimeng.p2p.S62.enums.T6231_F21"%>
<%@page import="com.dimeng.p2p.account.user.service.entity.Dbxxmx"%>
<%@page import="com.dimeng.p2p.user.servlets.AbstractUserServlet"%>
<%@page import="com.dimeng.p2p.account.user.service.FxbyjManage"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.BidManage"%>
<%@page import="com.dimeng.p2p.user.servlets.capital.ByjCharge"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F13"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F14"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F11"%>
<%@page import="com.dimeng.p2p.account.user.service.entity.Bdlb"%>
<%@page import="com.dimeng.p2p.account.user.service.entity.FinancialPlan"%>
<%@page import="com.dimeng.p2p.account.user.service.entity.LoanAccount"%>
<%@page import="com.dimeng.p2p.account.user.service.entity.LoanAccountInfo"%>
<%@page import="com.dimeng.p2p.account.user.service.entity.TenderAccount"%>
<%@page import="com.dimeng.p2p.account.user.service.entity.Notice"%>
<%@page import="com.dimeng.p2p.account.user.service.entity.UserBaseInfo"%>
<%@page import="com.dimeng.p2p.account.user.service.IndexManage"%>
<%@page import="com.dimeng.p2p.common.enums.PlanState"%>
<%@page import="com.dimeng.p2p.common.enums.CreditType"%>
<%@page import="com.dimeng.p2p.user.servlets.Index"%>
<%@page import="com.dimeng.p2p.user.servlets.financing.wdzq.Hszdzq"%>
<%@page import="com.dimeng.p2p.user.servlets.financing.yxlc.Yxlccyz"%>
<%@page import="com.dimeng.p2p.user.servlets.credit.Repaying"%>
<%@page import="com.dimeng.p2p.common.enums.CreditLevel"%>
<%@page import="com.dimeng.p2p.user.servlets.account.Safetymsg"%>
<%@page import="com.dimeng.p2p.user.servlets.capital.Withdraw"%>
<%@page import="com.dimeng.p2p.user.servlets.capital.Charge"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.dimeng.p2p.variables.defines.SystemVariable"%>
<%@include file="/WEB-INF/include/authenticatedSession.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>我的<%
	configureProvider.format(out,SystemVariable.SITE_NAME);
%></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>

<%
	CURRENT_CATEGORY = "WDWDW";
	CURRENT_SUB_CATEGORY = "WDWDW";
%>
<%
	IndexManage manage = serviceSession.getService(IndexManage.class); 
	UserBaseInfo userBaseInfo = manage.getUserBaseInfo();
	if(userBaseInfo==null){
		response.sendError(HttpServletResponse.SC_NOT_FOUND);
		return;
	}
	int userId=serviceSession.getSession().getAccountId();
	com.dimeng.p2p.service.UserManage commuserManage = serviceSession.getService(com.dimeng.p2p.service.UserManage.class);
	boolean flag=commuserManage.isPassPhone(userId);
	if(!flag){
		controller.sendRedirect(request, response, "/authphone.html");
		return;
	}
	Notice notice = manage.getNotice();
	BigDecimal loanAmount = manage.getLoanAmount();
	TenderAccount tenderAccount = manage.getTenderAccount();
	//LoanAccount[] loanAccount = manage.getLoanAccount();
	LoanAccountInfo[] loanAccountInfos = manage.getLoanAccountInfo();
	FinancialPlan financialPlan = manage.getFinancialPlan();
	Bdlb[] bids = manage.getBids();
	UserInfoManage uManage1 = serviceSession.getService(UserInfoManage.class);
	T6110 user1=  uManage1.getUserInfo(serviceSession.getSession().getAccountId());
	//boolean safeAuth=userBaseInfo.realName&&userBaseInfo.withdrawPsw&&userBaseInfo.email;
	boolean safeAuth=userBaseInfo.realName;
	boolean isBindBank=manage.isBindBank();
	boolean isTrusteeship=manage.isTrusteeship();
	LctjManage lctjManage = serviceSession.getService(LctjManage.class);
	EarnFinancingTotal earnFinancingTotal =  lctjManage.getEarnFinancingTotal();
	UnpayEarnings unpayEarnings = lctjManage.getUnpayEarnings();
	BigDecimal wh_bj = lctjManage.getDsCorpus();
	TasteActivityManage manage2=serviceSession.getService(TasteActivityManage.class);
	BigDecimal gold=manage2.getGold();
	
	//判断是否开通第三方和资金托管
	UserManage userManage = serviceSession.getService(UserManage.class);
	String usrCustId = userManage.getUsrCustId();
	boolean tg = BooleanParser.parse(configureProvider.getProperty(SystemVariable.SFZJTG));
	
	//是否实名认证
	int smrz= userManage.getTyjsmrz();
	
	//上传个人头像
	UserBaseManage userManage2 = serviceSession.getService(UserBaseManage.class);
	UserBase data = userManage2.getUserBase();
%>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<%--<div class="user_adbox"><a href="/active/tyjactive.html" target="_blank"></a></div> --%>
	<div class="contain clearfix">
		<div class="user_top"></div>
		<div class="about">
			<%@include file="/WEB-INF/include/menu.jsp"%>
            <div class="fr container">
                <!-- 新加 -->
        <div class="mainDiv bor1">
			
			<div class="tj-link mb20" style="float:right">
						 <span class="tuijian">推荐给好友：</span>
                         <a href="http://service.weibo.com/share/share.php?title=%A1%BE%C0%B4%C9%C6%D0%D0+%BB%F1%CA%D5%D2%E6%A1%BF%B9%FA%C4%DA%C1%EC%CF%C8%BB%A5%C1%AA%CD%F8%BD%F0%C8%DA%C0%ED%B2%C6%C6%BD%CC%A8%A3%AC100%D4%AA%C6%F0%CD%B6%A3%AC%C4%EA%BB%AF%CA%D5%D2%E6%C2%CA8%25-15%25%A1%A37%B5%C0%B6%C0%B4%B4%C9%F3%BA%CB%CC%E5%CF%B5%A3%AC100%25%B1%BE%CF%A2%B1%A3%D5%CF%A1%A3%C0%ED%B2%C6%B2%FA%C6%B7%B7%E1%B8%BB%A3%AC%D7%DC%D3%D0%D2%BB%BF%EE%CA%CA%BA%CF%C4%E3%A3%AC%C0%ED%B2%C6%D1%A1%D4%F1+@%C9%C6%D0%D0%B4%B4%CD%B6---%C4%E3%CC%F9%D0%C4%B5%C4%BC%D2%CD%A5%C0%ED%B2%C6%CA%A6%A3%AC%BD%AB%B4%F8%B8%F8%C4%E3%C7%B0%CB%F9%CE%B4%D3%D0%B5%C4%CD%B6%D7%CA%CC%E5%D1%E9%A3%A1&pic=http://www.myshanxing.com/images/logo.jpg&url=http://www.myshanxing.com" class="bds_tsina" title="分享到新浪微博" target="_blank"></a>
                         <a href="http://share.v.t.qq.com/index.php?c=share&a=index&pic=http://www.myshanxing.com/images/logo.jpg&title=%A1%BE%C0%B4%C9%C6%D0%D0+%BB%F1%CA%D5%D2%E6%A1%BF%B9%FA%C4%DA%C1%EC%CF%C8%BB%A5%C1%AA%CD%F8%BD%F0%C8%DA%C0%ED%B2%C6%C6%BD%CC%A8%A3%AC100%D4%AA%C6%F0%CD%B6%A3%AC%C4%EA%BB%AF%CA%D5%D2%E6%C2%CA8%25-15%25%A1%A37%B5%C0%B6%C0%B4%B4%C9%F3%BA%CB%CC%E5%CF%B5%A3%AC100%25%B1%BE%CF%A2%B1%A3%D5%CF%A1%A3%C0%ED%B2%C6%B2%FA%C6%B7%B7%E1%B8%BB%A3%AC%D7%DC%D3%D0%D2%BB%BF%EE%CA%CA%BA%CF%C4%E3%A3%AC%C0%ED%B2%C6%D1%A1%D4%F1+@%C9%C6%D0%D0%B4%B4%CD%B6---%C4%E3%CC%F9%D0%C4%B5%C4%BC%D2%CD%A5%C0%ED%B2%C6%CA%A6%A3%AC%BD%AB%B4%F8%B8%F8%C4%E3%C7%B0%CB%F9%CE%B4%D3%D0%B5%C4%CD%B6%D7%CA%CC%E5%D1%E9%A3%A1&url=http://www.myshanxing.com" class="bds_tqq" title="分享到腾讯微博" target="_blank"></a>
                         <a href="http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?title=%C9%C6%D0%D0%B4%B4%CD%B6&showcount=1&style=203&width=98&height=22&pics=http://www.myshanxing.com/images/logo.jpg&summary=%A1%BE%C0%B4%C9%C6%D0%D0+%BB%F1%CA%D5%D2%E6%A1%BF%C9%C6%D0%D0%B4%B4%CD%B6%C8%AB%B9%FA%B7%FE%CE%F1%C8%C8%CF%DF%A3%BA4000-166-277%A3%AC%CD%B6%D7%CA%BD%BB%C1%F7%2B%BB%E1%D4%B1%B7%FE%CE%F1%C8%BA%A3%BA223270771%A3%AC100%D4%AA%C6%F0%CD%B6%A3%AC%C4%EA%BB%AF%CA%D5%D2%E6%C2%CA8%25-15%25%A1%A37%B5%C0%B6%C0%B4%B4%C9%F3%BA%CB%CC%E5%CF%B5%A3%AC100%25%B1%BE%CF%A2%B1%A3%D5%CF%A1%A3&url=http://www.myshanxing.com" class="bds_qzone" title="分享到QQ空间" target="_blank"></a>
                         <a href="http://s.jiathis.com/?webid=kaixin001&title=%C9%C6%D0%D0%B4%B4%CD%B6&pic=http://www.myshanxing.com/images/logo.jpg&summary=%A1%BE%C0%B4%C9%C6%D0%D0+%BB%F1%CA%D5%D2%E6%A1%BF%C9%C6%D0%D0%B4%B4%CD%B6%C8%AB%B9%FA%B7%FE%CE%F1%C8%C8%CF%DF%A3%BA4000-166-277%A3%AC%CD%B6%D7%CA%BD%BB%C1%F7%2B%BB%E1%D4%B1%B7%FE%CE%F1%C8%BA%A3%BA223270771%A3%AC100%D4%AA%C6%F0%CD%B6%A3%AC%C4%EA%BB%AF%CA%D5%D2%E6%C2%CA8%25-15%25%A1%A37%B5%C0%B6%C0%B4%B4%C9%F3%BA%CB%CC%E5%CF%B5%A3%AC100%25%B1%BE%CF%A2%B1%A3%D5%CF%A1%A3&url=http://www.myshanxing.com" class="popup_kaixin001" title="分享到开心网" target="_blank"></a>
            </div>
            <div class="clear"></div>
			<div class="userL">
				<div class="userPic">
				<%if(StringHelper.isEmpty(data.icon)) {%>
					<img src="images/info.jpg">
				<%}else{%>
				<img src="<%=fileStore.getURL(data.icon)%>" width="120" height="120" />
				<%}%>
				
				
				<p class="upload"><a href="javascript:void(0);" onclick="addCard();">上传头像</a></p>
				
				</div>
				<p class="shenf"><span></span><br><%=accountName%></p>
				<p class="tips">
				<% if(smrz==0){%>
                    <a href="javascript:void();" class="name-no" title="未实名认证"></a>
                <% }else{%>
                    <a href="javascript:void();" class="name-yes" title="已实名认证"></a>
                <%} %>
                    <a href="javascript:void();" class="mobile-yes" title="已手机认证"></a>
				</p>
			</div>
			<div class="userR">
				<div class="userRDiv" id="money1">
					<div class="item">
						<b>安全等级</b>
						<%int unSafeCount = uManage1.getUnSafeCount();%>
						<p class="star0<%=(5-unSafeCount)%>">
						</p>
					</div>
                    <%if(tg && !StringHelper.isEmpty(usrCustId)){ %>
                    <div class="item">
						<b>账户余额</b><p><strong class="font8">
					￥<%=Formater.formatAmount(userBaseInfo.balance)%>元
            			</strong>
						</p>
					</div>
					<%}%>
				</div>
				<%if(tg && StringHelper.isEmpty(usrCustId)){ %><p class="userRDiv" id="moneyP">
				<div class="fr expressBtbox">
				<a href="account/safetymsg2.html" class="express_green">一键安全认证<%if(unSafeCount > 0){%><span><%=unSafeCount%></span><%} %></a>
                </div>
				<%}else{ %>
                <div class="fr expressBtbox">
                <a href="<%=controller.getViewURI(request, Charge.class)%>" class="express_blue">充值</a> 
                <a href="/user/capital/withdraw.html" class="express_orange">提现</a> 
                <a href="account/safetymsg2.html" class="express_green">一键安全认证<%if(unSafeCount > 0){%><span><%=unSafeCount%></span><%} %></a>
                </div>
			    <%} %>
			</div>
		</div>
        
        <div class="mainDiv bor1" id="funds">
			<p class="title1"><b>我的投资一览</b></p>
            <div class="item" id="profit">
            	<div class="fundsT"><b class="c1"></b><p><strong class="font8">
            		
					￥<%=Formater.formatAmount(earnFinancingTotal.total) %>元
            	</strong><span>（已赚收益）</span></div>
            
				<div class="fudsTable">
					<b class="font9">资产总额
						<i class="icon-tip zc-tip">
							<span class="jzc-showbox">资产总额=账户余额+冻结资金+待收总额</span>
						</i>
						<span class="fr pr20">
							<%=Formater.formatAmount(userBaseInfo.balance.add(userBaseInfo.freezeFunds).add(wh_bj).add(unpayEarnings.total))%>元
						</span>
					</b>
					<table class="tableOdd">
					  <tbody><tr>
						<td width="40%" align="left" class="pl60">账户余额</td>
						<td align="right" class="pr20"><%=Formater.formatAmount(userBaseInfo.balance)%>元</td>
						<!-- 0.00,,,0.00 -->
					  </tr>
					  <tr class="tdColor">
						<td width="40%" align="left" class="pl60">冻结资金</td>
						<td align="right" class="pr20"><%=Formater.formatAmount(userBaseInfo.freezeFunds)%>元</td>
					  </tr>
					  <tr>
						<td width="40%" align="left" class="pl60">待收总额<i class="icon-tip zc-tip"><span class="jzc-showbox">待收总额=待收本金+待收利息</span></i></td>
						<td align="right" class="pr20"><%=Formater.formatAmount(wh_bj.add(unpayEarnings.total)) %>元</td>
					  </tr>
					  <tr class="tdColor">
						<td width="40%" class="pl100">--待收本金</td>
						<td align="right" class="pr20"><%=Formater.formatAmount(wh_bj) %>元</td>
					  </tr>
					  <tr>
						<td width="40%" class="pl100">--待收利息</td>
						<td align="right" class="pr20"><%=Formater.formatAmount(unpayEarnings.total)%>元</td>
					  </tr>
					</tbody></table>
				</div>
            </div>
			<div class="item fr" id="investment">
				<div class="fundsT"><b class="c2"></b><p><strong class="font2">
				￥<%=Formater.formatAmount(unpayEarnings.total) %>元
				</strong><span>（待收收益）</span></p></div>	
				<div class="fudsTable">
					<b class="font9">负债总额
						<i class="icon-tip zc-tip">
							<span class="jzc-showbox">负债总额=待还总额</span>
						</i>
						<span class="fr pr20">
							<%=Formater.formatAmount(manage.getUnpayTotal())%>元
						</span>
					</b>
					<table class="tableOdd">
					  <tbody><tr>
						<td width="40%" align="left" class="pl60">待还总额</td>
						<td align="right" class="pr20"><%=Formater.formatAmount(manage.getUnpayTotal())%>元</td>
					  </tr>
					</tbody></table>
				</div>
            </div>     
            <div class="jzc clear">
	            <p>净资产
	            	<i class="icon-tip zc-tip">
	            		<span class="jzc-showbox">净资产=资产总额-负债总额</span>
	            	</i>
	            	  <%
								BigDecimal tzzc = tenderAccount.yxzc.add(tenderAccount.sbzc);
								BigDecimal zhjzc = tzzc.subtract(loanAmount).add(userBaseInfo.balance);
							%>
							
	            		<span class="fr pr20"><%=Formater.formatAmount(userBaseInfo.balance.add(userBaseInfo.freezeFunds).add(wh_bj).add(unpayEarnings.total).subtract(manage.getUnpayTotal()))%>元</span>
	            </p>
            </div>
		</div>
            </div>	
            <div class="clear"></div>
		</div>
        
        
	</div>
	

	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<%@include file="/WEB-INF/include/dialog.jsp"%>
	<script type="text/javascript">
	function addCard() {
		global_art = art.dialog.open("<%=controller.getViewURI(request, Upload.class)%>",{
			id : 'uploadImg',
			title : '上传图像',
			opacity : 0.1,
			width : 580,
			height : 440,
			lock : true,
			close : function() {
				window.location.reload();
			}

		}, false);
	}
	</script>	
	
	
</body>
</html>