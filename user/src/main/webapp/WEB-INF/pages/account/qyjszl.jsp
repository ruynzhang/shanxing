<%@page import="com.dimeng.p2p.S61.entities.T6162"%>
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
		QyBaseManage manage = serviceSession.getService(QyBaseManage.class);
		T6162 qy =  manage.getQyjs();		
		if(qy == null){
			qy =  new T6162();
		}
			CURRENT_CATEGORY = "ZHGL";
			CURRENT_SUB_CATEGORY = "QYJCXX";
	%>
	<div class="w994 pb5"><span class="f16"><a href="#">我的<%=configureProvider.getProperty(SystemVariable.SITE_NAME)%></a></span> > <a href="#">帐户管理</a>  >  企业介绍资料</div>
<div class="contain clearfix">
<div class="user_top"></div>
   <div class="about">
   <%@include file="/WEB-INF/include/menu.jsp"%>
     <div class="container fr">
         <div class="p30">
       	   <div class="user_lsjt mb20">企业介绍资料</div>
           <div class="fl jc_l">&nbsp;
           </div>
           <div class="jc_z fl" id="jcxx">
           		<ul>
                <li>
                	<div class="til"><span class="red">*</span>企业介绍：</div>
                    <div class="info"><%StringHelper.filterHTML(out, qy.F02); %>&nbsp;</div>
                    <div class="tir"><a href="<%=controller.getURI(request, QyBases.class) %>" class="btn01">基础信息</a></div>
                    <div class="clear"></div>
                </li>
                <li>
                	<div class="til"><span class="red">*</span>经营情况：</div>
                    <div class="info"><%StringHelper.filterHTML(out, qy.F03); %>&nbsp;<br />
                    </div>
                  	<div class="tir"><a href="<%=controller.getURI(request, Qyjszl.class) %>" class="btn01">介绍资料</a></div>
                    <div class="clear"></div>
                </li>
                <li>
                	<div class="til"><span class="red">*</span>涉诉情况：</div>
                    <div class="info"><%StringHelper.filterHTML(out, qy.F04); %>&nbsp;</div>
                    <div class="tir"><a href="<%=controller.getURI(request, Qycwzk.class) %>" class="btn01">财务状况</a></div>
                    <div class="clear"></div>
                </li>
                <li>
                	<div class="til"><span class="red">*</span>征信情况：</div>
                    <div class="info"><%StringHelper.filterHTML(out, qy.F05); %>&nbsp;</div>
                      	<div class="tir"><a href="<%=controller.getURI(request, Qylxxx.class) %>" class="btn01">联系信息</a></div>
                    <div class="clear"></div>
                </li>
                  <li>
                	<div class="til"><span class="red"></span>&nbsp;</div>
                    <div class="info">&nbsp;</div>
                      	<div class="tir"><a href="<%=controller.getURI(request, Qyccxx.class) %>" class="btn01">车产信息</a></div>
                    <div class="clear"></div>
                </li>
                  <li>
                	<div class="til"><span class="red"></span>&nbsp;</div>
                    <div class="info">&nbsp;</div>
                      	<div class="tir"><a href="<%=controller.getURI(request, Qyfcxx.class) %>" class="btn01">房产信息</a></div>
                    <div class="clear"></div>
                </li>
                </ul>
           </div>  
           
           <div class="clear"></div>
         </div>            
       	 </div>
         <div class="clear"></div>
   </div>
</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<%@include file="/WEB-INF/include/dialog.jsp"%>
</body>
</html>