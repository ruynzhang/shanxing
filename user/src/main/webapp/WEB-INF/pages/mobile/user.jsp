<!DOCTYPE html>
<%@page import="java.util.Map"%>
<html lang="en">
<head>
    <title>善行创投-帐户设置</title>
    <%@include file="/WEB-INF/pages/mobile/meta.jsp" %>
    <%@include file="/WEB-INF/pages/mobile/style.jsp" %>
    <%@include file="/WEB-INF/pages/mobile/javascript.jsp" %>
</head>
<%
CURRENT_CATEGORY="WEALTH";
Map<String, Object> map=(Map<String, Object>)request.getAttribute("resultMap");
boolean txmm=(boolean)map.get("withdrawPsw");
%>
<body>
<!---top--->
<%@include file="/WEB-INF/pages/mobile/header.jsp"%>

<!----container-->
<div class="sj_user">
    <div class="sj_user_title"><a href="/user/mobile/myWealth.htm"><b>帐户设置</b></a></div>
    <div class="sj_user_info"><b>用户昵称</b><span><%=map.get("userName")%></span></div>
    <div class="sj_user_info"><a href="/user/mobile/identity.htm"> <b>身份认证</b><span><%=(boolean)map.get("idCard")?"已认证":"未认证"%><img src="/mobile/images/r_arrow.png" alt="" /></span></a></div>
    <div class="sj_user_info"><a href="/user/mobile/forgetPosswd.html"><b>登录密码</b><span>可修改<img src="/mobile/images/r_arrow.png" alt="" /></span></a></div>
    <div class="sj_user_info">
    	<%if(map.get("phone")!=null){%>
    		<b>绑定手机</b><span><%=map.get("phone")%></span>
    	<%}else{%>
    		<a href="/user/mobile/setPhone.html"><b>绑定手机</b><span>未认证<img src="/mobile/images/r_arrow.png" alt="" /></span></a>
    	<%}%>    
    </div>
    <div class="sj_user_info">
    	<%if(txmm){%>
    		<a href="/user/mobile/presentPosswd.html"><b>提现密码</b><span>可修改<img src="/mobile/images/r_arrow.png" alt="" /></span></a>
		<%}else{%>
			<a href="/user/mobile/setTxPosswd.html"><b>提现密码</b><span>尚未设置<img src="/mobile/images/r_arrow.png" alt="" /></span></a>
		<%}%>    
    </div>
    <a href="/user/mobile/loginout.html" class=" wx_btn_orange">退出</a>
</div>
</body>
</html>