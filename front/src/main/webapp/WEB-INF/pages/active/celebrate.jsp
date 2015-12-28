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
    <meta charset="utf-8">
       <title><%=configureProvider.getProperty(SystemVariable.SITE_TITLE)%></title>
        <%@include file="/WEB-INF/include/meta.jsp"%>
        <%@include file="/WEB-INF/include/style.jsp"%>
        <link rel="stylesheet" type="text/css" href="<%=controller.getStaticPath(request)%>/css/celebrate.css" />
</head>
<body>
        <%@include file="/WEB-INF/include/header.jsp"%>
        <div class="sx_contain_box">
            <div class="cb_head"></div>
            <div class="cb_container">

                <div class="ct_content">
                <div class="btn_invest1"><a href="/financing/sbtz/"><input type="button" value="立即投资" /></a></div>
                <div class="btn_invest2"><a href="/financing/sbtz/"><input type="button" value="立即投资" /></a></div>
                <div class="btn_invest3"><a href="/financing/sbtz/"><input type="button" value="立即投资" /></a></div>
                <div class="btn_invest4"><a href="/financing/sbtz/"><input type="button" value="立即投资" /></a></div>
                <div class="btn_invest5"><a href="/financing/sbtz/"><input type="button" value="立即投资" /></a></div>
                <div class="btn_invest6"><a href="/financing/sbtz/"><input type="button" value="立即投资" /></a></div>
                </div>

               <div class="bottom"></div>
            </div>
        </div>
        <%@include file="/WEB-INF/include/footer.jsp"%>
        <%@include file="/WEB-INF/include/script.jsp"%>
</body>
</html>