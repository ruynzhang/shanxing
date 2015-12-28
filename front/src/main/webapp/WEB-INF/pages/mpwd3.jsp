<!DOCTYPE HTML>
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
    <div class="sx_m_block4 sx_m_block_login" id="sx_reg">
        <ul>
          <li><p class="sx_reg_word2">密码修改成功</p></li>

          <li class="sx_login_liend"><input type="button" value="用户登陆" class="sx_pinkBt" onclick="location.href='<%=configureProvider.format(URLVariable.MLOGIN_SUBMIT)%>?PID=<%=request.getParameter("PID")%>&score=<%=request.getParameter("score")%>&accountName=<%=request.getParameter("phone")%>&password=<%=request.getParameter("password")%>'"/></li>
      </ul>
    </div>
</div>
</body>
</html>
