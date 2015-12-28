<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.account.user.service.SpreadManage"%>
<%@page import="com.dimeng.p2p.user.servlets.Index"%>
<%@include file="/WEB-INF/include/authenticatedSession.jsp" %>
<html>
<head>
<title>我要推广-<%configureProvider.format(out,SystemVariable.SITE_NAME); %></title>
<%@include file="/WEB-INF/include/meta.jsp" %>
<%@include file="/WEB-INF/include/style.jsp" %>
</head>
<%
	CURRENT_CATEGORY = "TGGL";
	CURRENT_SUB_CATEGORY = "WYTG";
%>

<body>
<%@include file="/WEB-INF/include/header.jsp" %>
<div class="contain clearfix">
<div class="user_top"></div>
   <div class="about">
     <%@include file="/WEB-INF/include/menu.jsp"%>
     <div class="container fr bor1">
         <div class="p15">
         <p class="title1 titleTab mt20"><b>邀请好友</b><span><a href="<%=controller.getViewURI(request, com.dimeng.p2p.user.servlets.spread.Wdtg.class) %>">我的好友</a></span></p>
          <div style="width:380px; margin:auto; line-height:45px;"><div class="d_succeed fl"></div><span class="f20 orange bold">成功邀请好友，可获50元投资红包！</span></div>
         <div class="mb50">
             <div class="fl w200">
                <div class="tc blue"><span class="f50">1</span><br><span class="f20 bold">推广码邀请</span></div>
             </div>
             <div class="fl mt22">
                <div>这是您的专属推广码<br/>请您邀请的好友在注册时输入：<br><span class="orange f30 bold">
                <%
                	SpreadManage manage= serviceSession.getService(SpreadManage.class);
                	String tgm=manage.getMyyqNo();
                	String siteDomain = configureProvider.format(SystemVariable.SITE_DOMAIN);
                %>
                <%StringHelper.filterHTML(out, tgm); %></span></div>
             </div>
             <div id="codes" style="padding-top:20px;padding-right:130px;" class="fr"></div>
             <div class="clear">
             </div>
         </div>
         <div class="mb20 pb20">
             <div class="fl w200 mt30">
                <div class="tc blue"><span class="f50">2</span><br><span class="f20 bold">链接邀请</span></div>
             </div>
             <div class="fl mt22">
               <div>
               <p class="mb10">这是您的专用邀请链接，请通过 QQ或邮箱 发送给好友：</p>
               <p class="mb10"><textarea name="content" id="content" cols="" rows="" class="yhgl_ser wh450 " style="width: 500px;" readonly>我在<%=configureProvider.getProperty(SystemVariable.SITE_NAME) %>投资已获得了很高的收益，你也快来试试吧！http://<%=siteDomain%>/pay/slaward.html?code=<%StringHelper.filterHTML(out, tgm); %></textarea></p>           
               <p><input name="input" type="button" onclick="copyUrl2()" style="cursor: pointer;" value="复制链接" class="btn01 fl mb10"/></p>
              </div>
             </div>
             <div class="clear"></div>
         </div>
         <%--
         <div class="ln30 pl20 mb40">
           <p class="blue f16">邀请好友活动规则：</p>
           1. 只有在注册时输入您的邀请码或通过您复制的上述链接完成注册，并且要完成首笔充值<br />
           （充值下限为<%=configureProvider.getProperty(SystemVariable.TG_YXCZJS) %>元），才能被确认为成功邀请。<br />
           2. 每成功邀请一位充值成功的客户，您就获得<%=configureProvider.getProperty(SystemVariable.TG_YXTGJL) %>元奖励，每人每月<%=configureProvider.getProperty(SystemVariable.TG_YXTGSX) %>人封顶。<br />
           3. 您成功邀请的好友单笔投资金额每增加<%=configureProvider.getProperty(SystemVariable.TG_TZJS) %>元，您即可多获得<%=configureProvider.getProperty(SystemVariable.TG_TZJL) %>元的连续奖励。<br />
           4. 若发现任何作弊或非法手段获得奖励的，将取消全部返利金额。<br />
         </div>
          --%>
       </div>            
     </div>
     <div class="clear"></div>
   </div>
</div>
<%@include file="/WEB-INF/include/footer.jsp" %>
<%@include file="/WEB-INF/include/script.jsp" %>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/qrcode.min.js"></script>
<script type="text/javascript"> 
	function copyUrl2() 
	{ 
		var Url2=document.getElementById("content"); 
		Url2.select(); //选择对象 
		if(/msie/.test(navigator.userAgent.toLowerCase())) {
			document.execCommand("Copy");
			alert("已复制好，可粘贴。"); 
		}else {
			alert("此功能不支持该浏览器,请手工复制文本框中内容");
		} 
	}
	new QRCode("codes", {text: "http://<%=siteDomain%>/pay/slaward.html?code=<%=tgm%>", width: 150, height: 150});
 </script>
</body>
</html>