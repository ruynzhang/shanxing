<%@page import="com.dimeng.p2p.S50.enums.T5012_F03"%>
<%@page import="com.dimeng.p2p.S50.entities.T5012"%>
<%@page import="com.dimeng.p2p.modules.base.front.service.CustomerServiceManage"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>在线客服</title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
        <!--banner-->
<div class="zq_banner">
<div class="banner2"></div>
</div>
<!--banner-->
	<div class="contain clearfix">
		<div class="lead">
			<%
				CURRENT_SUB_CATEGORY = "ZXKF";
			%>
			<%@include file="/WEB-INF/include/xszy/left.jsp"%>
			 <div class="fr clearfix container">
				 <div class="pub_title clearfix">在线客服</div>
				 <ul class="clearfix service"> 
				 	<%
				 		CustomerServiceManage customerServiceManage = serviceSession.getService(CustomerServiceManage.class);
				 		T5012[] customerServices =  customerServiceManage.getAll(T5012_F03.QQ);
				 		if(customerServices!=null&&customerServices.length>0){for(T5012 customerService:customerServices){
				 			String image = fileStore.getURL(customerService.F07);
				 	%>
			       <li><img src="<%if(StringHelper.isEmpty(image)){%><%=controller.getStaticPath(request)%>/images/lead_pic17.jpg<%}else{%><%=image %><%}%>" width="115" height="110" /><p><a href="http://wpa.qq.com/msgrd?v=3&uin=<%StringHelper.filterHTML(out,customerService.F06);%>&site=qq&menu=yes" target="_blank"><%StringHelper.filterHTML(out, customerService.F05); %></a></p></li>
			       <%}}%>
			     </ul>    
		   </div>
		</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
</body>
</html>