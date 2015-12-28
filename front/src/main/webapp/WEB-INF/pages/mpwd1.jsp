<!DOCTYPE HTML>
<%@page import="com.dimeng.p2p.front.servlets.Mpwd1"%>
<%@page import="com.dimeng.p2p.front.servlets.password.IndexVerify"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>善行创投</title>
<meta name="description" content="善行创投" />
<meta name="keywords" content="善行创投" />
<meta name="author" content="shanLin" />
<meta name="copyright" content="ShanLin all Right Reserved" />
<meta name="viewport" content="width=320; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;" />
<meta name="apple-touch-fullscreen" content="YES" />
<meta name="apple-mobile-web-app-capable" content="yes">
<link href="<%=controller.getStaticPath(request)%>/phone/css/mobile.css" rel="stylesheet" type="text/css" media="screen">
<link rel="shortcut icon" href="favicon.ico"/>
<link rel="apple-touch-icon" href="icon.png"/>
<link rel="apple-touch-icon" sizes="72×72" href="touch-icon-ipad.png" />
<link rel="apple-touch-icon" sizes="114×114" href="touch-icon-iphone4.png" />
<script src="<%=controller.getStaticPath(request)%>/phone/js/jquery-1.11.0.min.js" type="text/javascript" ></script>
<script src="<%=controller.getStaticPath(request)%>/phone/js/common.js" type="text/javascript" ></script>
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
    <div class="sx_m_logo"></div><div class="sx_m_btBox"><a href="<%=configureProvider.format(URLVariable.MLOGIN)%>?PID=<%=request.getParameter("PID")%>&score=<%=request.getParameter("score")%>">登&nbsp;&nbsp;录</a></div>
</div>
<div id="sx_m_main">
    <div class="m_pwd_step">
       <ul>
         <li><div class="pwd_s ns">1</div><p>1.验证手机号码</p></li>
         <li><div class="pwd_s">2</div><p>2.重设密码</p></li>
         <li><div class="pwd_s">3</div><p>3.成功</p></li>
       </ul>
       <div class="pwd_line1" style="width:16%;"></div>
       <div class="pwd_line2"></div>
    </div>
    <form action="<%=controller.getURI(request, Mpwd1.class)%>" method="get">
    <div class="sx_m_block4 sx_m_block_login" id="sx_reg">
       	 <input type="hidden" name="PID" value="<%=request.getParameter("PID")%>"/>
   		 <input type="hidden" name="score" value="<%=request.getParameter("score")%>"/>
        <ul>
          <%{String errorMessage = controller.getPrompt(request,response,PromptLevel.ERROR);if (!StringHelper.isEmpty(errorMessage)) {%>
          <li class="reg_tip"><div class="sx_pinkColor"><%StringHelper.filterHTML(out, errorMessage);%></div></li>
          <%}}%>
          <li><input type="text" id="phone" name="phone" placeholder="输入手机号码" maxlength="11" value="<%StringHelper.filterQuoter(out, request.getParameter("phone"));%>"  class="sx_input"></li>
           <li>
           		<input type="text" name="verifyCode" type="text" maxlength="6" placeholder="输入验证码" class="sx_input2">
           		<div class="sx_cof_img">
           			<img src="<%=controller.getURI(request, IndexVerify.class)%>?t=p"
										onclick='this.src="<%=controller.getURI(request, IndexVerify.class)%>?t=p&"+Math.random()' class="sx_input3" />
           		</div>
           </li>
          <li class="sx_login_liend"><input type="submit" value="下一步" class="sx_pinkBt"/></li>
      </ul>
    </div>
    </form>
</div>
</body>
</html>
