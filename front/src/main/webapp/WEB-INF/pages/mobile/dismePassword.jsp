<%@page import="com.dimeng.p2p.front.servlets.password.IndexVerify"%>
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
<!---top--->
<div class="wx_top">
    <a class="wx_top_logo" href="index.html"></a>
</div>
<!--login-->
<div class="wx_login_box">
    <form action="/mobile/phoneModity.htm" id="form1" method="post">
        <%
		String phoneError = ObjectHelper.convert(request.getAttribute("PHONE_ERROR"), String.class);
		String pvCodeError = ObjectHelper.convert(request.getAttribute("PHONE_VERIFYCODE_ERROR"), String.class);
	%>
         <%if(!StringHelper.isEmpty(phoneError)){%>
             <div class="sx_pinkColor"><%StringHelper.filterHTML(out,phoneError);%></div>
          <%}%>
          <%if(!StringHelper.isEmpty(pvCodeError)){%>
             <div class="sx_pinkColor"><%StringHelper.filterHTML(out,pvCodeError);%></div>
          <%}%>
        <div class="input_box">
            <input type="text"  placeholder="请输入11位手机号码" maxlength="11" name="phone" class="wx_icon_user input_text">
        </div>
      <!--  <div id="passwordTip" class="wx_tip"></div>-->
        <div class="wx_login_check_code">
            <input type="tel"  placeholder="请输入验证码" id="code" name="verifyCode"   class="input_text" value="" >
            <span class="vcode"> <img id="codeNum" src="<%=controller.getURI(request, IndexVerify.class)%>?t=p" class="verifyImg" onclick='this.src="<%=controller.getURI(request, IndexVerify.class)%>?t=e&"+Math.random()' style="width:109px;height:40px;" title="换一张" alt="验证码"></span> </div>
        <!--登录超时提示-->


      <!--  <div id="error-box" class="wx_tip"></div>-->

        <a href="javascript:void(0);" onclick="resubmit();" id="wx_loginSubmit" tabindex="4" class="btn_wap wx_btn_orange"> 提交 </a>
    </form>
</div>

<script type="text/javascript">
function resubmit(){
	 document.getElementById("form1").submit();
}
</script>
<!----切换到电脑版----->
<div class="PCstyle"> <a href="http://www.myshanxing.com/"><span>切换到电脑版</span></a> <a href="http://www.myshanxing.com/android/myshanxing.apk"><span>下载善行创投app</span></a></div>
<!----end----->

</body>
</html>