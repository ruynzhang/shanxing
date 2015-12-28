<%@ page pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="Content-Type" content="text/html;">
	<meta http-equiv="Content-Script-Type" content="text/javascript">
	<meta http-equiv="Content-Style-Type" content="text/css">
	<meta charset="utf-8">
	<meta name="viewport" id="viewport" content="width = device-width, initial-scale = 1, minimum-scale = 1, maximum-scale = 1">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta http-equiv="Pragma" content="no-cache">
	<meta http-equiv="Cache-Control" content="no-cache">
	<meta equiv="Expires" content="0">
	<title>步步高升，秒秒抢金！</title>
	
	<!-- CSS和JS导入区 -->
	<!-- http://www.youmacode.com/fly/js/soundmanager2.js -->
	<script type="text/javascript" src="/js/fly/soundmanager2.js"></script>
	
<style>
body{oncontextmenu:return false;onselectstart:return false;-webkit-user-select:none;margin:0;background:#000;}
#advImg{pointer-events:none;}
#play68box{width:190px;font-size:12px;line-height:15px;right:-172px;top:35%;position:fixed;z-index:100;top: 25%;}
#tab{float:left;list-style:none outside none;padding:0;position:relative;z-index:99;margin-top:10px;margin-right:0;margin-bottom:0;margin-left:0;}
#tab li span{display:block;padding:0 5px;position:relative;}
#links{width:100px;padding:1px;float:left;background-color:#f6bb42;border-radius:8px;}
.show
  ,.hide{transition:margin-right .4s ease-in;-webkit-transition:margin-right .4s ease-in;}
.hide{margin-right:0;}
.show{margin-right:95px;}
#arrow
  ,.bt{cursor:pointer;}
.bt{width:95px;height:41px;margin:2px;text-align:center;font:bold 15px Arial,Helvetica,"Microsoft Yahei";background-color:#da4453;border-radius:6px;}
.bt a{line-height:40px;color:#fff;display:block;text-decoration:none;}
.bt:hover{transition:background .3s linear -o-transition:background .3s linear;-moz-transition:background .3s linear;-webkit-transition:background .3s linear;background-color:#37bc9b;}
#deco{width:90px;float:left;}
#share-wx{background:rgba(0,0,0,0.8);position:absolute;top:0;left:0;width:100%;height:100%;z-index:10000;display:none;}
#wx-qr{background:rgba(0,0,0,0.8);position:absolute;top:0;left:0;width:100%;height:100%;z-index:10000;display:none;}
</style>
	</head>

<!-- onorientationchange:在每次屏幕方向在横竖屏间切换后，就会触发这个window事件 -->
<body onorientationchange="orientationchange()" style="-webkit-transform-origin: 0px 0px 0px;overflow:hidden;">

 <% 
 		String pid = request.getParameter("PID")==null?"0":request.getParameter("PID");
 		int userId = 0;
	 try{
		 userId = serviceSession.getSession().getAccountId();
	 }catch(Exception e){
	 }
   System.out.println("userId:" + userId);
   // String userId = "1";
 %>
	<input type="hidden" id="userId" value="<%=userId%>" />
	<input type="hidden" id="pid" value="<%=pid%>" />

	<div id="flyDiv" style="position:relative;width:320px;height:416px;margin:0 auto;"></div>

	<div class="bottomDiv" id="bottomDiv" style="text-align:center; border:0px #fff solid;">
			<img id="advImg" src="/images/fly_005.jpg" width="320px;"/>
	</div>
</body>


<!-- 微信接口 -->
	<%@ include file="/WEB-INF/pages/fly/section/indexSection001.jsp"%>
	
<!-- JS导入之底部 -->
<script type="text/javascript" src="/js/fly/fly.js?v=1.1"></script>
<script type="text/javascript" src="/js/fly/fly.sare.js?v=1.1"></script>

<script>
document.getElementById("advImg").src="/images/fly_010.jpg";
document.getElementById("bottomDiv").addEventListener('touchstart',fnTouch, false);
document.getElementById("bottomDiv").addEventListener('touchmove',fnTouch, false);
document.getElementById("bottomDiv").addEventListener('touchend',fnTouch, false);
document.getElementById("advImg").addEventListener('touchstart',fnTouch, false);
document.getElementById("advImg").addEventListener('touchmove',fnTouch, false);
document.getElementById("advImg").addEventListener('touchend',fnTouch, false);
document.addEventListener('touchstart',fnTouch, false);
document.addEventListener('touchmove',fnTouch, false);
document.addEventListener('touchend',fnTouch, false);

 function fnTouch(event){
        var event = event || window.event;
        var ele = document.getElementById("advImg");
        switch(event.type){
            case "touchstart":
            	 event.preventDefault();// 取消事件的默认动作
                 break;
            case "touchend":
            	 event.preventDefault();// 取消事件的默认动作
                break;
            case "touchmove":
                event.preventDefault();// 取消事件的默认动作
                break;
        }
    }
 
if(isIOS()){
	if(navigator.userAgent.indexOf("AppleWebKit/6")!=-1){
		// document.getElementById("advImg").src="/images/fly_010.jpg";
	}
}

testTtt();

function testTtt(){
	// http://www.myshanxing.com/app/server/time.action
    var url = "http://www.myshanxing.com/proxy/app/home/banner.action?serverTime=1444379393633";
       
		// 开始提交(跨域)
		/*
		$.ajax({
			url : urlP2p,
			type : "post",
			jsonpCallback : "callbackBannerKy",
			dataType : "jsonp",
			success : function(data) {
				if (data.isSuccess) {
				}
			},
			error : function(e) {
			}
		  });
		*/

      $.post(url, {
       jsonData : null
      }, function(data) {
    	  console.info("回调"+data);
    	  if(data.sc==200){
    		  var body = data.body;
    		  var title = body.title;
    		  var url = body.url;
    		  var picturePath = body.picturePath;
    		  
    		  console.info("title:"+title);
    	  }
      });
}
</script>
</html>