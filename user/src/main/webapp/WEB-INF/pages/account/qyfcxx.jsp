<%@page import="com.dimeng.p2p.S61.entities.T6112"%>
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
			CURRENT_SUB_CATEGORY = "QYFCXX";
			PagingResult<T6112> result = ObjectHelper.convert(request.getAttribute("result"), PagingResult.class);
	%>
<div class="w994 pb5"><span class="f16"><a href="#">我的<%=configureProvider.getProperty(SystemVariable.SITE_NAME)%></a></span> > <a href="#">帐户管理</a>  >  企业房产信息</div>
<div class="contain clearfix">
<div class="user_top"></div>
   <div class="about">
   <%@include file="/WEB-INF/include/menu.jsp"%>
     <div class="container fr">
         <div class="p30">
       	   <div class="user_lsjt mb20">企业房产信息</div>
       	     <form action="<%=controller.getURI(request, Qyfcxx.class) %>" method="post">
           <div class="">
           <div class="fl" style="width:600px;">
	           <table width="100%" border="0" cellspacing="0" cellpadding="0" class="user_table fl" >
							<tbody><tr class="user_lsbg">
								<td>小区名称</td>
								<td>建筑面积</td>
								<td>购买价格</td>
								<td>地址</td>
								<td>房产证编号</td>
							</tr>
							<%
							T6112[] qy = result.getItems();
							if(qy != null){ 
								for(T6112 entity :qy){
							%>
							<tr>
								<td><%StringHelper.filterHTML(out,  entity.F03);%></td>
								<td><%=entity.F04 %>平方米</td>
								<td><%=entity.F06 %>万元</td>
								<td><%StringHelper.filterHTML(out,  entity.F09);%></td>
								<td><%StringHelper.filterHTML(out, entity.F10);%></td>
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
		   <% Qyfcxx.rendPagingResult(out, result); %>  
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