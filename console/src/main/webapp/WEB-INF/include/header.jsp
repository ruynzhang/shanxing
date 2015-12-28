<%@page import="com.dimeng.p2p.variables.defines.URLVariable"%>
<%@page import="com.dimeng.p2p.variables.defines.SystemVariable"%>
<%@page import="java.util.UUID"%>
<%@page import="com.dimeng.p2p.console.servlets.common.UpdatePass"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.dimeng.p2p.console.servlets.Logout"%>
<%@page import="com.dimeng.p2p.console.config.ConsoleConst"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="com.dimeng.p2p.console.servlets.Login"%>
<%
	if (dimengSession == null || !dimengSession.isAuthenticated()) {
		controller.redirectLogin(request, response, controller.getURI(request, Login.class));
		return;
	}

%>
<div class="header_top">
	<div class="pl15 pr15">
		<div class="time fl"><%=new SimpleDateFormat("yyyy年MM月dd日 E",Locale.SIMPLIFIED_CHINESE).format(new Date(System.currentTimeMillis()))%></div>
		<div class="welcome fr">
			欢迎您：<%StringHelper.filterHTML(out, dimengSession.getAttribute(ConsoleConst.ACCOUNT_NAME));%>
			<a href="<%=controller.getURI(request, UpdatePass.class)%>"><span class="red">修改密码</span></a>
			[<a href="<%=controller.getURI(request, Logout.class)%>">安全退出</a>]
		</div>
	</div>
</div>
<div class="header_main">
	<div class="logo_bg">
		<a href="<%=controller.getURI(request, com.dimeng.p2p.console.servlets.common.Index.class)%>">
	     	<span class="fl mt10 pl10 pr20" style="border-right:1px solid #f8f8f8;"><img src="<%=fileStore.getURL(configureProvider.getProperty(SystemVariable.HTSYLOGO))%>" width="160" height="50"></span>			
		</a>
		<div class="logo_htgl fl">后台管理系统</div>
	</div>
	<ul class="mainnav clearfix">
		<li class="<%="SY".equals(CURRENT_CATEGORY)?"cur":""%>"><a href="<%=controller.getURI(request, com.dimeng.p2p.console.servlets.common.Index.class)%>">首页</a></li>
		<li class="<%="YHGL".equals(CURRENT_CATEGORY)?"cur":""%>"><a href="<%=controller.getURI(request, com.dimeng.p2p.console.servlets.account.Index.class)%>">用户管理</a></li>
		<li class="<%="YWGL".equals(CURRENT_CATEGORY)?"cur":""%>"><a href="<%=controller.getURI(request, com.dimeng.p2p.console.servlets.bid.Index.class)%>">业务管理</a></li>
		<li class="<%="XCGL".equals(CURRENT_CATEGORY)?"cur":""%>"><a href="<%=controller.getURI(request, com.dimeng.p2p.console.servlets.info.Index.class)%>">宣传管理</a></li>
		<li class="<%="XTGL".equals(CURRENT_CATEGORY)?"cur":""%>"><a href="<%=controller.getURI(request, com.dimeng.p2p.console.servlets.system.Index.class)%>">系统管理</a></li>
		<li class="<%="CWGL".equals(CURRENT_CATEGORY)?"cur":""%>"><a href="<%=controller.getURI(request, com.dimeng.p2p.console.servlets.finance.Index.class)%>">财务管理</a></li>
		<li class="<%="TJGL".equals(CURRENT_CATEGORY)?"cur":""%>"><a href="<%=controller.getURI(request, com.dimeng.p2p.console.servlets.statistics.Index.class)%>">统计管理</a></li>
		<li class="<%="TGGL".equals(CURRENT_CATEGORY)?"cur":""%>"><a href="<%=controller.getURI(request, com.dimeng.p2p.console.servlets.spread.Index.class)%>">推广管理</a></li>
		<li class="<%="JCXXGL".equals(CURRENT_CATEGORY)?"cur":""%>"><a href="<%=controller.getURI(request, com.dimeng.p2p.console.servlets.base.Index.class)%>">基础信息管理</a></li>
	</ul>
</div>