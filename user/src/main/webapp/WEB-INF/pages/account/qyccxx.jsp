<%@page import="com.dimeng.p2p.S61.entities.T6113"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="javax.swing.text.html.parser.Entity"%>
<%@page import="com.dimeng.p2p.S61.entities.T6163"%>
<%@page import="com.dimeng.p2p.account.user.service.QyBaseManage"%>
<%@page import="com.dimeng.p2p.user.servlets.account.*"%>
<%@include file="/WEB-INF/include/authenticatedSession.jsp" %>
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
		CURRENT_SUB_CATEGORY = "QYCCXX";
		PagingResult<T6113> result = ObjectHelper.convert(request.getAttribute("result"), PagingResult.class);
	%>
	<div class="w994 pb5"><span class="f16"><a href="#">我的<%=configureProvider.getProperty(SystemVariable.SITE_NAME)%></a></span> > <a href="#">帐户管理</a>  >  企业车产信息</div>
<div class="contain clearfix">
<div class="user_top"></div>
   <div class="about">
   <%@include file="/WEB-INF/include/menu.jsp"%>
     <div class="container fr">
         <div class="p30">
       	   <div class="user_lsjt mb20">企业车产信息</div>
       	   <form action="<%=controller.getURI(request, Qyccxx.class) %>" method="post">
           <div class="">
           <div class="fl" style="width:600px;">
	           <table width="100%" border="0" cellspacing="0" cellpadding="0" class="user_table fl" >
							<tbody>
								<tr class="user_lsbg">
									<td>汽车品牌</td>
									<td>车牌号码</td>
									<td>购车年份（年）</td>
									<td>购买价格（万元）</td>
									<td>评估价格（万元）</td>
								</tr>
							<%
								T6113[] qy = result.getItems();
								if(qy != null){ 
								for(T6113 entity :qy){
							%>
							<tr>
								<td><%StringHelper.filterHTML(out, entity.F03);%></td>
								<td><%StringHelper.filterHTML(out, entity.F04); %></td>
								<td><%=entity.F05 %>年</td>
								<td><%=entity.F06 %>万元</td>
								<td><%=entity.F07 %>万元</td>
							</tr>
							<%}} %>
				</tbody>
				</table>
		   </div>
		   <div class="fr">
		      <a href="<%=controller.getURI(request, QyBases.class) %>" class="btn01 mb15">基础资料</a>
		      <a href="<%=controller.getURI(request, Qyjszl.class) %>" class="btn01 mb15">介绍资料</a>
		      <a href="<%=controller.getURI(request, Qycwzk.class) %>" class="btn01 mb15">财务状况</a>
		      <a href="<%=controller.getURI(request, Qylxxx.class) %>" class="btn01 mb15">联系信息</a>
		      <a href="<%=controller.getURI(request, Qyccxx.class) %>" class="btn01 mb15">车产信息</a>		 
		      <a href="<%=controller.getURI(request, Qyfcxx.class) %>" class="btn01 mb15">房产信息</a>			      
		   </div>
         	<% Qyccxx.rendPagingResult(out, result); %>  
           <div class="clear"></div>
         </div>  
         </form>          
       	 </div>
       	 
         <div class="clear"></div>
   </div>
</div>
</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<%@include file="/WEB-INF/include/dialog.jsp"%>
</body>
</html>