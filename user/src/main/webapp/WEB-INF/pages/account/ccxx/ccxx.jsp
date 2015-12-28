<%@page import="com.dimeng.p2p.user.servlets.account.ccxx.Ccxx"%>
<%@page import="com.dimeng.p2p.user.servlets.account.ccxx.UpdateCcxx"%>
<%@page import="com.dimeng.p2p.user.servlets.account.ccxx.ViewCcxx"%>
<%@page import="com.dimeng.p2p.user.servlets.account.ccxx.AddCcxx"%>
<%@page import="com.dimeng.p2p.user.servlets.account.fcxx.Fcxx"%>
<%@page import="com.dimeng.p2p.user.servlets.account.gzxx.Gzxx"%>
<%@page import="com.dimeng.p2p.user.servlets.account.xlxx.Xlxx"%>
<%@page import="com.dimeng.p2p.user.servlets.account.UserBases"%>
<%@page import="com.dimeng.p2p.S61.entities.T6113"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@include file="/WEB-INF/include/authenticatedSession.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=configureProvider.getProperty(SystemVariable.SITE_NAME)%></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<%
		CURRENT_CATEGORY = "ZHGL";
		CURRENT_SUB_CATEGORY = "GRJCXX";
		
		PagingResult<T6113> result =  ObjectHelper.convert(request.getAttribute("result"), PagingResult.class);
	%>
	<div class="w994 pb5">
		<span class="f16"><a href="#">我的<%
			configureProvider.format(out,SystemVariable.SITE_NAME);
		%></a></span> &gt; <a href="#">账户管理</a> &gt;个人基础信息
	</div>
	<div class="contain clearfix">
		<div class="user_top"></div>
		<div class="about">
			<%@include file="/WEB-INF/include/menu.jsp"%>
			<form action="<%=controller.getURI(request, Ccxx.class) %>" method="post">
			<div class="container fr">
				<div class="til clearfix Men_bt">
					<div class="Menubox">
						<ul>
							<li><a href="<%=controller.getURI(request, UserBases.class) %>">个人基本信息</a></li>
							<li><a href="<%=controller.getURI(request, Xlxx.class) %>">个人学历信息</a></li>
							<li><a href="<%=controller.getURI(request, Gzxx.class) %>">个人工作信息</a></li>
							<li><a href="<%=controller.getURI(request, Fcxx.class) %>">房产信息</a></li>
							<li  class="hover">车产信息</li>
						</ul>
					</div>
				</div>
				<br/>
				<a href="<%=controller.getURI(request, AddCcxx.class)%>" class="btn01"">新增</a>
				<br/>
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="user_table tc">
					<tr class="user_lsbg">
						<td>序号</td>
						<td>汽车品牌</td>
						<td>车牌号码</td>
						<td>购车年份</td>
						<td>购买价格(元)</td>
						<td>评估价值(元)</td>
						<td>操作</td>
					</tr>
					<%
					T6113[] t6113 = result.getItems();
					if(t6113 != null){ 
						int index = 1;
						for(T6113 t:t6113){
					%>
					<tr>
						<td><%=index++ %></td>
						<td><%StringHelper.filterHTML(out, t.F03); %></td>
						<td><%=t.F04%></td>
						<td><%=t.F05%>年</td>
						<td><%=t.F06%></td>
						<td><%= t.F07%></td>
						<td>
							<a href="<%=controller.getURI(request, ViewCcxx.class) %>?id=<%=t.F01 %>" class="blue">查看</a>
							<a href="<%=controller.getURI(request, UpdateCcxx.class) %>?id=<%=t.F01 %>" class="blue ml5">修改</a>
						<td>
					</tr>
					<%}} %>
				</table>
					<%Ccxx.rendPagingResult(out, result); %>
				<div class="clear"></div>
			</div>
			</form>
			<div class="clear"></div>
		
		</div>
	</div>
	<div class="clear"></div>

	<script type="text/javascript">
		
	</script>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
</body>
</html>