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
<form action="<%=configureProvider.format(URLVariable.MWEB_LIST) %>" method="get" id="form1">
<!---top--->
<div class="wx_top">
    <a class="wx_top_logo" href="index.html"></a>
</div>
<!--login-->
<div class="wx_login_box">
        <p class=""><%=request.getParameter("accountName") == null? "" : request.getParameter("accountName")%>，恭喜您注册成功</p>
        <a href="javascript:void(0);"  onclick="resubmit();"  class="btn_wap wx_btn_orange"> 进入我的帐户</a>

</div>

<script type="text/javascript">
function resubmit(){
	 document.getElementById("form1").submit();
}
</script>


<!----切换到电脑版----->
<%@include file="/WEB-INF/pages/mobile/download.jsp" %>
<!----end----->
</form>
</body>
</html>