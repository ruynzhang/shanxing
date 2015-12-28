<!DOCTYPE html>
<%@page import="com.dimeng.p2p.utlis.JfUtil"%>
<%@page import="com.dimeng.p2p.service.TasteActivityManage"%>
<%@page import="com.dimeng.p2p.user.servlets.MgetGold"%>
<%@page import="com.dimeng.p2p.user.servlets.Mauth"%>
<%@page import="com.dimeng.p2p.S61.enums.T6141_F04"%>
<%@page import="com.dimeng.p2p.account.user.service.entity.Safety"%>
<%@page import="com.dimeng.p2p.account.user.service.SafetyManage"%>
<%@page import="com.dimeng.p2p.user.servlets.Mshare"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>善行创投</title>
<meta name="description" content="善行创投" />
<meta name="keywords" content="善行创投" />
<meta name="author" content="shanLin" />
<meta name="copyright" content="ShanLin all Right Reserved" />
<meta name="viewport" content="width=320; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;" />
<meta name="apple-touch-fullscreen" content="YES" />
<meta name="apple-mobile-web-app-capable" content="yes"/>
<link href="<%=controller.getStaticPath(request)%>/phone/css/mobile.css" rel="stylesheet" type="text/css" media="screen"/>
<link rel="shortcut icon" href="favicon.ico"/>
<link rel="apple-touch-icon" href="icon.png"/>
<link rel="apple-touch-icon" sizes="72×72" href="touch-icon-ipad.png" />
<link rel="apple-touch-icon" sizes="114×114" href="touch-icon-iphone4.png" />
<script src="<%=controller.getStaticPath(request)%>/phone/js/jquery-1.11.0.min.js" type="text/javascript" ></script>
<script src="<%=controller.getStaticPath(request)%>/phone/js/common.js" type="text/javascript" ></script>
<%
SafetyManage userManage = serviceSession.getService(SafetyManage.class);
Safety data = userManage.get();
boolean flag=!StringHelper.isEmpty(data.isIdCard) && data.isIdCard.equals(T6141_F04.TG.name());
if(!flag){
	controller.sendRedirect(request, response, controller.getURI(request, Mauth.class));
	return;
}
int userId=serviceSession.getSession().getAccountId();
TasteActivityManage manage=serviceSession.getService(TasteActivityManage.class);
String infoMessage = controller.getPrompt(request,response,PromptLevel.INFO);
%>
</head>
<body>
<div id="sx_m_header">
    <div class="sx_m_logo"></div>
</div>
<div id="sx_m_main">    
<form action="<%=controller.getURI(request, MgetGold.class)%>" method="get">	
    <div class="sx_m_block4" id="sx_reg">
        <p class="sx_reg_word2"><%if (!StringHelper.isEmpty(infoMessage)){ %>您已获得<%StringHelper.filterHTML(out, infoMessage);%>元体验金。<br /><%}%>输入序号领取更多体验金</p>
        <ul>
         <%{String errorMessage = controller.getPrompt(request,response,PromptLevel.ERROR);if (!StringHelper.isEmpty(errorMessage)) {%>
          <li class="reg_tip"><div class="sx_pinkColor"><%StringHelper.filterHTML(out, errorMessage);%></div></li>
          <%}}%>
          <li><input type="text" id="randNo" name="randNo" placeholder="序号号码" value="<%StringHelper.filterQuoter(out, request.getParameter("randNo"));%>" maxlength="10"  class="sx_input"/></li>
          <li class="sx_login_liend"><input type="submit" value="领取体验金" class="sx_pinkBt"/></li>
      </ul>
      <p class="reg_img"><img src="<%=controller.getStaticPath(request)%>/phone/images/getcode.jpg" alt="" /></p>
      <p class="reg_pinklink">请到官方平台使用体验金<br/>www.myshanxing.com</p>
	  <p class="sx_reg_word1">体验金有限期：<%=JfUtil.properties.get("tyj_time")%></p>
    </div>
    </form>
</div>
</body>
</html>
