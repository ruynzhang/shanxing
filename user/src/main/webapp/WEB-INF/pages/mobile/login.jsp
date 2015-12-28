<%@page import="com.dimeng.p2p.user.servlets.LoginVerify"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <title>善行创投</title>
    <%@include file="/WEB-INF/pages/mobile/meta.jsp" %>
    <%@include file="/WEB-INF/pages/mobile/style.jsp" %>
</head>
<body>
<%
if (dimengSession != null && dimengSession.isAuthenticated()) {
	controller.sendRedirect(request, response, configureProvider.format(URLVariable.MWEB_LIST));
	return;
}
%>
<!---top--->
<div class="wx_top">
    <a class="wx_top_logo" href="/mobile/index.html"></a>
</div>
<!--login-->
<div class="wx_login_box">
    <form action="<%=configureProvider.format(URLVariable.MWEB_LOGIN)%>" id="form1" method="post">
         <%{String errorMessage = controller.getPrompt(request,response,PromptLevel.ERROR);if (!StringHelper.isEmpty(errorMessage)) {%>
             <div class="sx_pinkColor"><%StringHelper.filterHTML(out, errorMessage);%></div>
          <%}}%>
         <input type="hidden" name="_z" value="<%StringHelper.filterHTML(out, request.getParameter("_z"));%>" />
        <div class="input_box">
            <span class="user_icon"></span><input type="text"  placeholder="用户名/手机号码" name="accountName" value="<%StringHelper.filterQuoter(out, request.getParameter("accountName"));%>" class="wx_icon_user input_text">
        </div>
        <div class="input_box">
            <span class="passwd_icon"></span><input type="password"  placeholder="请输入密码"   name="password" class="wx_icon_pw input_text" >
        </div>
      <!--  <div id="passwordTip" class="wx_tip"></div>-->
        <div class="wx_login_check_code">
            <span class="code_icon"></span><input type="tel"  placeholder="请输入验证码" id="code" name="verifyCode"   class="input_text" value="" >
            <span class="vcode"> <img id="codeNum" src="<%=controller.getURI(request, LoginVerify.class)%>" class="verifyImg" onclick='this.src="<%=controller.getURI(request, LoginVerify.class)%>?"+Math.random()' style="width:109px;height:43px;" title="换一张" alt="验证码"></span> </div>
        <!--登录超时提示-->


      <!--  <div id="error-box" class="wx_tip"></div>-->

        <a href="javascript:void(0);" onclick="resubmit();" id="wx_loginSubmit" tabindex="4" class="btn_wap wx_btn_orange"> 立即登录 </a>
        <div class="xn_login_blow">
            <a class="fpwd" href="/mobile/dismePassword.html"> 找回密码？ </a>
            <span class="xn_noAccount">还没有账户？ <a class="wx_reg_now" href="/mobile/register.html"> 立即注册 </a> </span>
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