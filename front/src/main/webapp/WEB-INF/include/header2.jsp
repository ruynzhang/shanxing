<%@page import="com.dimeng.p2p.S61.enums.T6110_F07"%>
<%@page import="com.dimeng.p2p.S61.enums.T6110_F10"%>
<%@page import="com.dimeng.p2p.S61.enums.T6110_F06"%>
<%@page import="com.dimeng.p2p.S61.entities.T6110"%>
<%@page import="com.dimeng.p2p.account.front.service.UserInfoManage"%>
<%@page import="com.dimeng.p2p.account.front.service.UserManage"%>
<%@page import="com.dimeng.util.filter.HTMLFilter"%>
<%@page import="java.util.UUID"%>
<%@page import="com.dimeng.p2p.front.servlets.Logout"%>
<div class="top clearfix">
	<div class="top_bar">
		<div class="lft">
			<ul>
				<li class="tit1"><%configureProvider.format(out,SystemVariable.SITE_CUSTOMERSERVICE_TEL);%></li>
				<li class="tit2"><a href="<%configureProvider.format(out,URLVariable.CUSTOMERS);%>">在线客服</a></li>
			</ul>
		</div>
		<div class="rig">
			<a href="<%configureProvider.format(out,URLVariable.INDEX);%>">首页</a>
			<%if (dimengSession == null || !dimengSession.isAuthenticated()) {%>
			<%}else{
				UserInfoManage userInfoManage=serviceSession.getService(UserInfoManage.class);
        		T6110 t6110=userInfoManage.getUserInfo(serviceSession.getSession().getAccountId());
				if(t6110.F07==T6110_F07.HMD||t6110.F07==T6110_F07.SD)
					{
						controller.redirectLogin(request, response, controller.getURI(request, Logout.class));
						return;
					}
				int count = serviceSession.getService(UserManage.class).getUnReadLetter();
			%>
			<a href="<%configureProvider.format(out,URLVariable.USER_LETTER);%>" class="message">站内信<%if(count>0){%><span class="red">(<%=count %>)</span><%}%></a>
			<%}%>
			<a href="<%configureProvider.format(out,URLVariable.USER_INDEX);%>">我的<%configureProvider.format(out,SystemVariable.SITE_NAME);%></a>
			<a href="<%configureProvider.format(out,URLVariable.HELP_CENTER);%>">投资攻略</a>
		</div>
	</div>
</div>
<div class="header">
	<div class="logo fl">
		<a href="<%configureProvider.format(out,URLVariable.INDEX);%>"><img src="<%=fileStore.getURL(configureProvider.getProperty(SystemVariable.QTLOGO))%>" title="<%configureProvider.format(out,SystemVariable.SITE_NAME);%>" /></a>
	</div>
	<ul class="menu">
		<li><a href="<%configureProvider.format(out,URLVariable.FINANCING_CENTER);%>" class="tablink">我要理财</a>
			<ul>
				<%-- <li><a href="<%configureProvider.format(out,URLVariable.FINANCING_YX);%>">优选理财计划</a></li> --%>
				<li><a href="<%configureProvider.format(out,URLVariable.FINANCING_SBTZ);%>">理财投资列表</a></li>
				<%-- <li><a href="<%configureProvider.format(out,URLVariable.FINANCING_ZQZR);%>">债权转让列表</a></li> --%>
				<li><a href="<%configureProvider.format(out,URLVariable.FINANCING_HKHMD);%>">还款黑名单</a></li>
			</ul></li>
		<li><a class="hide" href="<%configureProvider.format(out,URLVariable.CREDIT_CENTER);%>">我要借款</a>
			<ul>
				<li><a href="<%configureProvider.format(out,URLVariable.CREDIT_XJD);%>">薪金贷</a></li>
				 <%-- <li><a href="<%configureProvider.format(out,URLVariable.CREDIT_SYD);%>">生意贷</a></li>  --%>
				<li><a href="<%configureProvider.format(out,URLVariable.CREDIT_DKYX);%>">个人借款意向</a></li>
				<li><a href="<%configureProvider.format(out,URLVariable.CREDIT_QYDKYX);%>">企业借款意向</a></li> 
                <%--<li><a href="<%configureProvider.format(out,URLVariable.CREDIT_GRXYRZ);%>">个人信用融资</a></li>
				<li><a href="<%configureProvider.format(out,URLVariable.CREDIT_GRDBRZ);%>">个人担保融资</a></li>
				<li><a href="<%configureProvider.format(out,URLVariable.CREDIT_QYXYRZ);%>">企业信用融资</a></li>
				<li><a href="<%configureProvider.format(out,URLVariable.CREDIT_QYDBRZ);%>">企业担保融资</a></li> --%>
			</ul></li>
	</ul>
	<%if (dimengSession == null || !dimengSession.isAuthenticated()) {%>
	<div class="index_login fr">
		<a href="<%configureProvider.format(out,URLVariable.REGISTER);%>">注册</a><a href="<%configureProvider.format(out,URLVariable.LOGIN);%>">登录</a>
	</div>
	<%} else {
		UserInfoManage uManage = serviceSession.getService(UserInfoManage.class);
		T6110 t6110 =uManage.getUserInfo(serviceSession.getSession().getAccountId());
		T6110_F06 userType = t6110.F06;
	%>
	<div class="index_login index_info fr">
		<div class="name fl">
			<div class="name fl">
			<a href="<%=configureProvider.format(URLVariable.USER_INDEX) %>" title="<%StringHelper.filterHTML(out, serviceSession.getService(UserManage.class).getAccountName());%>">
			<span class="tips fl" title="<%=serviceSession.getService(UserManage.class).getAccountName()%>">您好，<%StringHelper.truncation(new HTMLFilter(out), serviceSession.getService(UserManage.class).getAccountName(), 8);%></span>
			<i class="fr"></i>
			</a>
		</div>
		</div>
		<ul class="navbar">
			<li><a href="<%configureProvider.format(out,URLVariable.USER_CHARGE);%>">充值</a></li>
			<li class="line"><a href="<%configureProvider.format(out,URLVariable.USER_WITHDRAW);%>">提现</a>
			</li>
			<li><a href="<%configureProvider.format(out,URLVariable.USER_CAPITAL);%>">资金管理</a>
			</li>
			<%
				if(userType==T6110_F06.ZRR)
				{
			%>
			<li><a href="<%configureProvider.format(out,URLVariable.USER_FINANCING);%>">理财管理</a>
			</li>
			<%} %>
			<%
				if(t6110.F10==T6110_F10.F)
				{
			%>
			<li class="line"><a href="<%configureProvider.format(out,URLVariable.USER_CREDIT);%>">借款管理</a></li>
			<%} %>
			<li><a href="<%=controller.getURI(request, Logout.class)%>">安全退出</a></li>
		</ul>
	</div>
	<%}%>
</div>
<div class="clear"></div>