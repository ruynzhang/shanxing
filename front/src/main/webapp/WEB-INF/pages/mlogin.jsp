<!DOCTYPE html>
<%@page import="com.dimeng.p2p.front.servlets.IsLogin"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>善行创投</title>
<meta name="description" content="善行创投" />
<meta name="keywords" content="善行创投" />
<meta name="author" content="shanLin" />
<meta name="copyright" content="ShanLin all Right Reserved" />
<meta name="viewport" content="width=320; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;" />
<meta name="apple-touch-fullscreen" content="YES" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<link href="<%=controller.getStaticPath(request)%>/phone/css/mobile.css" rel="stylesheet" type="text/css" media="screen" />
<link rel="shortcut icon" href="favicon.ico"/>
<link rel="apple-touch-icon" href="icon.png"/>
<link rel="apple-touch-icon" sizes="72×72" href="touch-icon-ipad.png" />
<link rel="apple-touch-icon" sizes="114×114" href="touch-icon-iphone4.png" />
<script src="<%=controller.getStaticPath(request)%>/phone/js/jquery-1.11.0.min.js" type="text/javascript" ></script>
<script src="<%=controller.getStaticPath(request)%>/phone/js/common.js" type="text/javascript" ></script>
<%
response.setStatus(HttpServletResponse.SC_MOVED_PERMANENTLY);
String newLocn = "/m_register.html";
response.setHeader("Location",newLocn);
%>
<script>
function onBridgeReady(){
 WeixinJSBridge.call('hideOptionMenu');
}

if (typeof WeixinJSBridge == "undefined"){
    if( document.addEventListener ){
        document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);
    }else if (document.attachEvent){
        document.attachEvent('WeixinJSBridgeReady', onBridgeReady); 
        document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
    }
}else{
    onBridgeReady();
}
</script>
</head>
<body>
<div id="sx_m_header">
    <div class="sx_m_logo"></div><div class="sx_m_btBox"><a href="javascript:void()" class="toReg" onClick="location.href='<%=configureProvider.format(URLVariable.MREGISTER)%>?PID=<%=request.getParameter("PID")%>&score=<%=request.getParameter("score")%>'">注&nbsp;&nbsp;册</a></div>
</div>
<div id="sx_m_main">
<form action="<%=configureProvider.format(URLVariable.MLOGIN_SUBMIT)%>" method="get">	
    <div class="sx_m_block4 sx_m_block_login" id="sx_reg">
    	<input type="hidden" name="PID" value="<%=request.getParameter("PID")%>"/>
    	<input type="hidden" name="score" value="<%=request.getParameter("score")%>"/>
    	<input type="hidden" name="code" value="<%=request.getParameter("code")%>"/>
        <ul>
        <%{String errorMessage = controller.getPrompt(request,response,PromptLevel.ERROR);if (!StringHelper.isEmpty(errorMessage)) {%>
          <li class="reg_tip"><div class="sx_pinkColor"><%StringHelper.filterHTML(out, errorMessage);%></div></li>
          <%}}%>
          <li><input type="text" id="accountName" name="accountName" placeholder="用户名/手机号码" maxlength="18" onblur="check();" class="sx_input" value="<%StringHelper.filterQuoter(out, request.getParameter("accountName"));%>"/></li>
          <li><input  name="password" type="password" class="sx_input" maxlength="20"  placeholder="密码" /></li>
          <li class="sx_login_liend"><input type="submit" value="登&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;陆" class="sx_pinkBt"/></li>
      </ul>
      <p class="sx_reg_word">还没有帐号？<a href="<%=configureProvider.format(URLVariable.MREGISTER)%>?PID=<%=request.getParameter("PID")%>&score=<%=request.getParameter("score")%>" class="sx_blueColor">立即注册</a>&nbsp;|&nbsp;<a href="<%=controller.getStaticPath(request)%>/mpwd1.html?PID=<%=request.getParameter("PID")%>&score=<%=request.getParameter("score")%>" class=" sx_blueColor">忘记密码</a></p>
      <p class="reg_img"></br><img src="<%=controller.getStaticPath(request)%>/phone/images/footer.png" alt="" /></p>
    </div>
    </form>
</div>
</body>
</html>
