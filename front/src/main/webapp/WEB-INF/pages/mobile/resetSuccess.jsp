<%@page import="com.dimeng.p2p.front.servlets.RegisterVerify"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <title>善行创投</title>
    <%@include file="/WEB-INF/pages/mobile/meta.jsp" %>
    <%@include file="/WEB-INF/pages/mobile/style.jsp" %>
    <script src="<%=controller.getStaticPath(request)%>/phone/js/jquery-1.11.0.min.js" type="text/javascript" ></script>
    <script src="<%=controller.getStaticPath(request)%>/phone/js/common.js" type="text/javascript" ></script>
</head>
<body>
<!---top--->
<div class="wx_top">
    <a class="wx_top_logo" href="/mobile/index.html"></a>
</div>
<!--login-->
<div class="wx_login_box">
        <div class="input_box">恭喜您，已经成功重置您的密码！</div>
        <a href="/user/mobile/login.html" id="wx_loginSubmit" tabindex="4" class="btn_wap wx_btn_orange">立即登录</a>
        <div class="xn_login_blow">
            <span class="xn_noAccount">若您无法使用上述方法找回,请联系客服<%=configureProvider.getProperty(SystemVariable.SITE_CUSTOMERSERVICE_TEL)  %> </span>
        </div>
</div>

<!----切换到电脑版----->
<%@include file="/WEB-INF/pages/mobile/download.jsp" %>
<!----end----->
</body>
</html>