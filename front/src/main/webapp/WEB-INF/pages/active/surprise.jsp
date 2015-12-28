<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.front.servlets.Region"%>
<%@page import="com.dimeng.p2p.S62.entities.T6211"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.BidWillManage"%>
<%@page import="com.dimeng.p2p.common.enums.IntentionType"%>
<%@page import="com.dimeng.p2p.front.servlets.credit.Dkyx"%>
<%@page  import="com.dimeng.p2p.account.front.service.UserManage"%>
<%@page import="com.dimeng.p2p.S61.entities.Rewarduser"%>
<%@page import="java.util.List"%>
<%-- <%@include file="/WEB-INF/include/authenticatedSession.jsp" %> --%>
<html>
<head>
<title><%=configureProvider.getProperty(SystemVariable.SITE_TITLE)%></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=controller.getStaticPath(request)%>/css/inside.css" />
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/jquery-1.11.0.min.js"></script>
</head>
<body>
	<%@include file="/WEB-INF/include/header3.jsp"%>
    <div class="sx_activebox2" style="background:#2f0101;">
    <div class="sx_act_head2" style="height:600px; background-image:url(/images/award_01.jpg);"></div>
    <div class="sx_act_item" style="height:641px;"><img src="/images/award_02.jpg" alt="" /></div>
    <div class="sx_act_item"><img src="/images/award_03.jpg" alt="" /></div><br /><br />
</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
</body>
