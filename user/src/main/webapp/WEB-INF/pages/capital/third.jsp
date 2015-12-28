<%@page import="com.dimeng.p2p.S61.entities.T6110"%>
<%@page import="com.dimeng.p2p.S61.entities.T6101"%>
<%@page import="com.dimeng.p2p.account.user.service.UserInfoManage"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.dimeng.p2p.user.servlets.capital.Unpay"%>
<%@page import="com.dimeng.p2p.user.servlets.capital.TradingRecord"%>
<%@page import="com.dimeng.p2p.user.servlets.account.Safetymsg"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.dimeng.p2p.user.servlets.capital.Third"%>
<%@include file="/WEB-INF/include/authenticatedSession.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>开通第三方托管帐户
</title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<%
	
		UserInfoManage manage = serviceSession.getService(UserInfoManage.class);
		T6101 balance = manage.search();
		
		T6110 userInfo=	manage.getUserInfo(serviceSession.getSession().getAccountId());
		UserManage userManage = serviceSession.getService(UserManage.class);
		String usrCustId = userManage.getUsrCustId();
		boolean tg = BooleanParser.parse(configureProvider.getProperty(SystemVariable.SFZJTG));
		
		CURRENT_CATEGORY = "ZJGL";
		CURRENT_SUB_CATEGORY = "THR";
	%>
	<div class="w994 pb5">
		<span class="f16">
		<a href="<%=controller.getViewURI(request, com.dimeng.p2p.user.servlets.Index.class)%>">我的<%
			configureProvider.format(out,SystemVariable.SITE_NAME);
		%></a>
		</span> &gt; <a href="javascript:void(0)">资金管理</a>&gt; 开通第三方托管帐户
	</div>
	<div class="contain clearfix">
		<div class="user_top"></div>
		<div class="about">
			<%@include file="/WEB-INF/include/menu.jsp"%>
			<div class="container fr">
				<div class="p15">
				<div class="f16 mt30 pt50 pb50 tc ml30 mr30" style="background:#f3f3f3;">
				            	 为了您的资金安全保障，请开通第三方托管账户！
		          </div>
                  <div class="f16"><a target="_blank" href="<%=configureProvider.format(URLVariable.ESCROW_URL_USERREGISTER) %>" class="red">开通汇潮托管帐户</a></div>
                  <%} %>
					<div class="ln30 pl20 mb40">
						<p class="blue f16">什么是汇潮托管帐户：</p>
						借方进行网上充值后，资金将进入借方在汇潮开设的托管账户，根据实际投标情况，借方将资金划拨到贷方托管账户，贷方最后将款项提现至自己的银行账户。<br>
					</div>
				</div>
			</div>
			<div class="clear"></div>
		</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
</body>
</html>