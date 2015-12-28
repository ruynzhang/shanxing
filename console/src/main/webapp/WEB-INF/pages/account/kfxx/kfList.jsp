<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.account.kfxx.HfjlList"%>
<%@page import="com.dimeng.p2p.console.servlets.account.kfxx.AddHfjl"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.Grxx"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%
	CURRENT_CATEGORY="YHGL";
	CURRENT_SUB_CATEGORY="KFXX";
	PagingResult<Grxx> list = ObjectHelper.convert(request.getAttribute("list"), PagingResult.class);
	Grxx[] userArray = list.getItems();
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
<div class="main clearfix">
    <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<form id="form1" action="<%=controller.getURI(request,KfList.class)%>" method="post">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>用户信息</h3>
                    </div>
                    <div class="con">
                    	  <div class="admin_input admin_pb">
                                <p>用户名称：<input type="text" name="userName" value="<%StringHelper.filterHTML(out, request.getParameter("userName"));%>" class="yhgl_input mr5" /></p>
                                <p>真实姓名：<input type="text" name="name" value="<%StringHelper.filterHTML(out, request.getParameter("name"));%>" class="yhgl_input mr5" /></p>
                              <div class="clear"></div>
                              <div class="mt10">
                              	<input name="" type="submit" class="btn2 mr10" value="搜索" />
                   				<div class="clear"></div>
                              </div>
                    	</div>    
                    </div>
                </div>
              	<div>
                <table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
                        <tr class="hsbg">
                          <td>序号</td>
                          <td>用户名称</td>
                          <td>真实姓名</td>
                          <td>手机</td>
                          <td>邮箱</td>
                          <td>最后一次登录时间</td>
                          <td>状态</td>
                          <td>操作</td>
                        </tr>
                        <%
                        	if (userArray != null) {
                        		int index = 1;
                        		for (Grxx user:userArray)
                        		{if (user == null) {continue;}
                        %>
                        <tr class="dhsbg">
                          <td><%=index++ %></td>
                          <td><%StringHelper.filterHTML(out, user.userName);%></td>
                          <td><%StringHelper.filterHTML(out, user.name);%></td>
                          <td><%StringHelper.filterHTML(out, user.phone); %></td>
                          <td><%StringHelper.filterHTML(out, user.email);%></td>
                          <td><%=DateTimeParser.format(user.loginTime)%></td>
                          <td><%=user.status.getChineseName() %></td>
                          <td>
                          	<%if (dimengSession.isAccessableResource(AddHfjl.class)) {%>
                          	<span class="blue"><a href="<%=controller.getURI(request,AddHfjl.class)%>?userId=<%=user.id%>" class="mr10">新增回访记录</a></span>
                          	<%}else{ %>
                          	<span class="disabled">新增回访记录</span>
                          	<%} %>
                          	<%if (dimengSession.isAccessableResource(HfjlList.class)) {%>
                          	<span class="blue"><a href="<%=controller.getURI(request,HfjlList.class)%>?userId=<%=user.id%>" class="mr10">查看</a></span>
                          	<%}else{ %>
                          	<span class="disabled">查看</span>
                          	<%} %>
                          </td>
                        </tr>
                        <%
                        	}}
                        %>
                      </table>
                </div>
                <%GrList.rendPagingResult(out, list); %>
                </form>       
            </div>
        </div>   
    </div>
    <%@include file="/WEB-INF/include/left.jsp"%>
</div>
</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
</body>
</html>