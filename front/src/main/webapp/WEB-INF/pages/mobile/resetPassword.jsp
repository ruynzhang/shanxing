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
    <a class="wx_top_logo" href="index.html"></a>
</div>
<!--login-->
<div class="wx_login_box">
    <form action="/mobile/resetPassword.htm" id="form1" method="post">
        <%{String errorMessage = controller.getPrompt(request,response,PromptLevel.ERROR);if (!StringHelper.isEmpty(errorMessage)) {%>
          <div class="input_box" style="color:red"><%StringHelper.filterHTML(out, errorMessage);%></div>
        <%}}%>
        <div class="input_box">
            <input type="text"  placeholder="请输入手机的6位验证码" value="<%StringHelper.filterQuoter(out, request.getParameter("code"));%>"  name="code" class="input_text" >
        </div>
        <div class="input_box">
            <input type="password"  placeholder="密码(请输入6-20个字符，区分大小写)"  name="password" class=" input_text" >
        </div>

        <div class="input_box">
            <input type="password" name="repassword"  placeholder="请再次输入密码"   class="icon_mb input_text" >
        </div>

        <a href="javascript:void(0);"  onclick="resubmit();" id="wx_loginSubmit" tabindex="4" class="btn_wap wx_btn_orange"> 下一步</a>
        <div class="xn_login_blow">
            <span class="xn_noAccount">若您无法使用上述方法找回,请联系客服<%=configureProvider.getProperty(SystemVariable.SITE_CUSTOMERSERVICE_TEL)  %> </span>
        </div>
    </form>
</div>
<script type="text/javascript">
function resubmit(){
	 document.getElementById("form1").submit();
}
</script>

<!----切换到电脑版----->
<%@include file="/WEB-INF/pages/mobile/download.jsp" %>
<!----end----->
</body>
</html>