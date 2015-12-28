<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
        <%@page import="com.dimeng.p2p.front.servlets.Region"%>
        <%@page import="com.dimeng.p2p.S62.entities.T6211"%>
        <%@page import="com.dimeng.p2p.modules.bid.front.service.BidWillManage"%>
        <%@page import="com.dimeng.p2p.common.enums.IntentionType"%>
        <%@page import="com.dimeng.p2p.front.servlets.credit.Dkyx"%>
        <%@page  import="com.dimeng.p2p.account.front.service.UserManage"%>
        <%@page import="com.dimeng.p2p.S61.entities.Rewarduser"%>
        <%@page import="java.util.List"%>

<html lang="en">
<head>
    <title><%=configureProvider.getProperty(SystemVariable.SITE_TITLE)%></title>
    <%@include file="/WEB-INF/include/meta.jsp"%>
    <%@include file="/WEB-INF/include/style.jsp"%>
</head>
<style>
    .ad_bg{height:auto;margin:0 auto;}
    .ad_bg img{width:100%;}
    .btn_invest input{
        width: 600px;
        height: 67px;
        background: #e8382a;
        color: #fff;
        border: 0;
        font-size: 36px;
        cursor: pointer;
        position:absolute;
        left:35%;
        margin-top: -76%;
        z-index: 10000;
    }
</style>
<body>
    <%@include file="/WEB-INF/include/header.jsp"%>
   <div class="ad_bg"><img src="/images/activity.jpg" alt=""></div>
   <div class="btn_invest"><a href="/financing/sbtz/"><input type="button" value="立即投资"></a></div>
    <%@include file="/WEB-INF/include/footer.jsp"%>
    <%@include file="/WEB-INF/include/script.jsp"%>

</body>
</html>