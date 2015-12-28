<%@page import="com.dimeng.util.filter.HTMLFilter"%>
<%@page import="com.dimeng.p2p.account.front.service.UserManage"%>
<div class="wx_top">
    <a class="wx_top_logo" href="/index.html"></a>
    <div class="wx_top_btn">
    <%String accountName = null;
	   if (dimengSession == null || !dimengSession.isAuthenticated()) {%>
       		<a href="/mobile/register.html">免费注册</a>
        	<a href="/user/mobile/login.html">登录</a>
        <%} else { accountName = serviceSession.getService(UserManage.class).getAccountName();%>
       		<a  title="<%=accountName%>" href="/user/mobile/myWealth.htm">您好：<%StringHelper.truncation(new HTMLFilter(out), accountName, 12);%></a>
			<%-- <a href="/user/mobile/myWealth.htm">我的财富</a>
			<a href="/user/mobile/loginout.html">安全退出</a>--%>
		<%}%>
    </div>
</div>