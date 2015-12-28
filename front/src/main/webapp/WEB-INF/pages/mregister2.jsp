<%@page import="com.dimeng.p2p.front.servlets.GetPhoneVerifyCode"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<!DOCTYPE html>
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
<meta name="apple-mobile-web-app-capable" content="yes"/>
<link href="<%=controller.getStaticPath(request)%>/phone/css/mobile.css" rel="stylesheet" type="text/css" media="screen"/>
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
<script type="text/javascript">
var getVerifyCodeURL='<%=controller.getURI(request, GetPhoneVerifyCode.class)%>';
var wait = 180;
/** 获取手机验证码*/
function getVerifyCode(evn){
	var ipt = $(":input[name='mobilephone']");
	var phoneVal = ipt.val();
	$.ajax({
		type:"post",
		dataType:"json",
		url:getVerifyCodeURL,
		data:{"mobilephone":phoneVal},
		success:function (data){
			alert("请一分钟后再获取验证码");
		},
	});
	sendclick(evn);
}

function sendclick(evn){
	var $evn = $(evn);
	if (wait == 0) {
		evn.removeAttribute("disabled");
		$evn.removeClass("sx_grey");
		evn.value="获取验证码";
		wait = 180;
	} else {
		if(!$evn.hasClass("sx_grey")){
			$evn.addClass("sx_grey");
		}
		evn.setAttribute("disabled", true);
		evn.value="(" + wait + ")秒重新获取";
		wait--;
		setTimeout(function() {
			sendclick(evn);
		},
		1000);
	}
}
</script>
</head>
<%String mobilephone = serviceSession.getSession().getAttribute("register_step1_mobilephone"); %>
<body>
<div id="sx_m_header">
    <div class="sx_m_logo"></div><div class="sx_m_btBox"></div>
</div>
<div id="sx_m_main">    
<form action="<%=configureProvider.format(URLVariable.MREGISTER_STEP_2_SUBMIT) %>" method="get">	
    <div class="sx_m_block4" id="sx_reg">
    	<input type="hidden" name="PID" value="<%=request.getParameter("PID")%>"/>
    	<input type="hidden" name="score" value="<%=request.getParameter("score")%>"/>
        <p class="sx_reg_word2">手动一小步，成功一大步！</p>
        <input type="hidden" name="mobilephone" value="<%=mobilephone == null ? "" : mobilephone%>"/>
        <ul>
          <%{String errorMessage = controller.getPrompt(request,response,PromptLevel.ERROR);if (!StringHelper.isEmpty(errorMessage)) {%>
          <li class="reg_tip"><div class="sx_pinkColor"><%StringHelper.filterHTML(out, errorMessage);%></div></li>
          <%}}%>
         <li class="reg_tip"><div>您的手机号码是：<b><%=mobilephone == null ? "" : mobilephone%></b><br />点击获取验证码</div></li>
          <li>
          	<input name="phoneVerifyCode" type="text"  maxlength="6" placeholder="输入验证码" value="<%StringHelper.filterQuoter(out, request.getParameter("phoneVerifyCode"));%>"  class="sx_input2"/>
          	<div class="sx_cof_img"> <input name="sendPhoneVerifyCode" type="button" value="获取验证码" onclick="getVerifyCode(this)" class="sx_input3"/> </div>
          </li>
          <li class="sx_login_liend"><input type="submit" value="成功完成" class="sx_pinkBt" /></li>
      </ul>
    </div>
</form>
</div>
</body>
</html>
