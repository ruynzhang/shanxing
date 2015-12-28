<!DOCTYPE html>
<%@page import="com.dimeng.p2p.utlis.JfUtil"%>
<%@page import="com.dimeng.p2p.service.TasteActivityManage"%>
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
TasteActivityManage manage=serviceSession.getService(TasteActivityManage.class);
BigDecimal gold=manage.getGold();
int userId=serviceSession.getSession().getAccountId();
String bestScore=request.getParameter("score");
if(null==bestScore){
	bestScore="0";
}
int score=JfUtil.formatTyj(bestScore);
String str = controller.getPrompt(request,response,PromptLevel.ERROR);
String p=request.getParameter("p");
%>
</head>
<script  type="text/javascript">
function onBridgeReady(){
	 WeixinJSBridge.call('showOptionMenu');
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
var sareUrlQzPath = "http://www.myshanxing.com";// 分享前置路径
var lqLinkQzPath = "http://www.myshanxing.com";// 领取体验金的前置路径(http://192.168.3.123:8080)
var lineLink = sareUrlQzPath + "/fly/index.html?PID="+<%=userId%>+"&score="+<%=score%>;// 分享链接
var imgUrl = sareUrlQzPath + "/images/fly_p_007.png";// 分享图片地址
var descContent = "哇塞！我在善行创投抢到了"+<%=score%>+"的横财，快给我助力赢更多，你也赶紧来测试自己的横财运！";// 分享描述(过后设置)
if(<%=score%>==0){
	descContent = "哇塞！我在善行创投抢到了很多横财，快给我助力赢更多，你也赶紧来测试自己的横财运！";
}
var shareTitle = "钱太少，不满足？赶紧搬救兵吧！?";// 分享标题
</script>
<body>
<div id="sx_m_header">
    <div class="sx_m_logo"></div>
</div>
<div id="sx_m_main">    
    <div class="sx_m_block4" id="sx_reg">
        <p class="sx_reg_word3">
        <%if(!StringHelper.isEmpty(str)) {%>
    		<b class="sx_pinkColor"><%StringHelper.filterHTML(out, str);%></b>
        <%}%>
        <%if(StringHelper.isEmpty(p)){ %>
      	  <br/>分享朋友圈还可以呼叫朋友发力再帮玩60秒，玩后第一个注册并实名认证朋友的体验金与您双算！      
        <%}%>
        </p>
        <p class="sx_reg_word2">目前共有<b class="sx_pinkColor"><%=gold.intValue()%></b>元体验金</p>
        <ul>
          <%if(!StringHelper.isEmpty(p) && p.equals("1")){ %>
      	 	 <li><a class="sx_pinkBt sx_greenBt" href="http://www.myshanxing.com/" >进入官网</a></li>
       	 <%}else{%>
	         <li class="sx_login_liend" id="sx_reg_share"><a class="sx_pinkBt sx_greenBt" href="javascript:shareFriend();" >分享好友共赢共赚</a></li>
          <%}%>
      </ul>
      <%-- <p class="reg_img"><img src="<%=controller.getStaticPath(request)%>/phone/images/getcode.jpg" alt="" /></p>--%>
       <%if(StringHelper.isEmpty(p)){ %>
     	 <p class="reg_pinklink"><a href="http://www.myshanxing.com/" class="reg_pinklink">进入官网</a></p>
      <%}%>
    </div>
</div>
<div class="overlay"></div>
<div class="sx_m_showShare sharebox">
<div class="sx_m_block6" id="sx_reg" style="background:none;">
        <p><img src="<%=controller.getStaticPath(request)%>/phone/images/webapp_share.png" alt="" style="width:100%;"/></p>
        <p class="sx_reg_word3">
        <%{String errorMessage = controller.getPrompt(request,response,PromptLevel.ERROR);if (!StringHelper.isEmpty(errorMessage)) {%>
        	<b class="sx_pinkColor"><%StringHelper.filterHTML(out, errorMessage);%></b>
         <%}}%>
        </p>
        <p class="sx_reg_word2 getBt">共有<b class="sx_pinkColor"><%=gold%></b>元体验金</p>
      <p class="reg_img"><img src="<%=controller.getStaticPath(request)%>/phone/images/getcode.jpg" alt="" /></p>
      <p class="sx_reg_word4">投资直通车：</p>
      <p class="reg_pinklink"><a href="http://www.myshanxing.com/" class="reg_pinklink">进入官网</a></p>
    </div>
</div>
<%@ include file="/WEB-INF/pages/fly/indexSection001.jsp"%>
<script type="text/javascript">
$(function() {
	initReady();
});
function initReady(){
	if(typeof(window.slJSBridge) == 'object')
		window.slJSBridge.share(shareTitle,lineLink,imgUrl,descContent,['weiXin']);
}
</script>
</body>
</html>
