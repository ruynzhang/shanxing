<%@page import="com.dimeng.p2p.service.TasteActivityManage"%>
<%@page import="com.dimeng.p2p.user.servlets.MgetGold"%>
<%@page import="com.dimeng.p2p.S61.enums.T6141_F04"%>
<%@page import="com.dimeng.p2p.account.user.service.entity.Safety"%>
<%@page import="com.dimeng.p2p.account.user.service.SafetyManage"%>
<%@page import="com.dimeng.p2p.user.servlets.Mauth"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<!DOCTYPE html>
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
if(flag){
	controller.sendRedirect(request, response, configureProvider.format(URLVariable.MSHARE));
	return;
}
TasteActivityManage manage=serviceSession.getService(TasteActivityManage.class);
int userId=serviceSession.getSession().getAccountId();
int count=manage.recordCount(userId,"ZC");
%>

<script type="text/javascript">
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
function onload(){
	var relname="<%=request.getParameter("name")%>";
	if(null!=relname && relname!="null"){
		document.getElementById("name").value=decodeURI(relname);
	}
}
function check(){
	var name=document.getElementById("name").value;
	document.getElementById("relname").value=encodeURI(name);
	document.getElementById("formId").submit();
}

</script>
</head>
<body onload="onload();">
<div id="sx_m_header">
    <div class="sx_m_logo"></div><div class="sx_m_btBox"></div>
</div>
<div id="sx_m_main">    
<form action="<%=controller.getURI(request, Mauth.class)%>" method="get" id="formId">	
    <div class="sx_m_block4" id="sx_reg">
   		<input type="hidden" name="PID" value="<%=request.getParameter("PID")%>"/>
    	<input type="hidden" name="score" value="<%=request.getParameter("score")%>"/>
    	<input type="hidden" id="relname" name="name" value="<%=request.getParameter("name")%>"/>
        <p class="sx_reg_word2">
        <%{String errorMessage = controller.getPrompt(request,response,PromptLevel.INFO);if (!StringHelper.isEmpty(errorMessage)) {%>
          您已获得200元体验金<br />
         <%}}%>
        认证后方能投标且赚收益哦<br />还送<%=count>0?"800":"1000"%>体验金<%if(count<=0){ out.print("<br />手动一小步，成功一大步");} %></p>
        <ul>
          <%{String errorMessage = controller.getPrompt(request,response,PromptLevel.ERROR);if (!StringHelper.isEmpty(errorMessage)) {%>
          <li class="reg_tip"><div class="sx_pinkColor"><%StringHelper.filterHTML(out, errorMessage);%></div></li>
          <%}}%>
          <li><input type="text" id="name" placeholder="真实姓名" maxlength="18" class="sx_input"/></li>
          <li>
        	  <input type="text" name="idCard" id="idcard" placeholder="身份证号" value="<%StringHelper.filterQuoter(out, request.getParameter("idCard"));%>" class="sx_input"/>
          </li>
          <li class="sx_login_liend"><input type="button" value="成功完成" class="sx_pinkBt" onclick="return check();"/></li>
      </ul>
      <p class="sx_reg_word" style="text-align:left;">网页由善行创投提供，承诺对用户信息高度保密，请放心体验</p>
    </div>
</form>
</div>
</body>
</html>
