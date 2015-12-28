<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.front.servlets.UpdatePassword"%>
<%@page import="com.dimeng.p2p.front.servlets.xszy.*"%>
<%@ taglib uri="http://www.opensymphony.com/oscache" prefix="oscache" %>
<html>
<head>
<title>
	<%
		configureProvider.format(out,SystemVariable.SITE_TITLE);
	%>
</title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=controller.getStaticPath(request)%>/css/index.css" />
<meta name="baidu-site-verification" content="sg4sAuDLhd" />

</head>
<body>
		<%@include file="/WEB-INF/include/header.jsp"%>
		<oscache:cache key="sl-p2p-front-index" time="60" scope="application">
		<%@include file="/WEB-INF/include/index/advertisement.jsp"%>
		<!--内容-->
		<div class="sx_mainbox">
           <div class="sx_main_leftbox">
             <%@include file="/WEB-INF/include/index/feture.jsp"%>
			 <%@include file="/WEB-INF/include/index/invest.jsp"%>
			 <%@include file="/WEB-INF/include/index/ranklist.jsp"%>
           </div>
           <div class="sx_main_rightbox">
             <%@include file="/WEB-INF/include/index/combine.jsp"%>
           </div>
		   <%--@include file="/WEB-INF/include/index/froum.jsp"--%>
		   <%@include file="/WEB-INF/include/index/info.jsp"%>
           
		<%-- <%@include file="/WEB-INF/include/index/choose.jsp"%>
		<%@include file="/WEB-INF/include/index/partener.jsp"%>
		<%@include file="/WEB-INF/include/index/friendlyLink.jsp"%> --%>
		</div>
		
		
		<%
			UserManage  manage = serviceSession.getService(UserManage.class);	
				
				if(dimengSession != null && dimengSession.isAuthenticated() && manage.isFirstLogin() ){
		%>
		<form action="<%=controller.getURI(request, UpdatePassword.class)%>" method="post" class="form1">
			<div class="popup_bg"></div>
			<div class="dialog w510" style="margin: -150px 0 0 -255px;">
				<div class="con">
					<div class="red">
						<%
							StringHelper.filterHTML(out, controller.getPrompt(request, response, PromptLevel.ERROR));
						%>
					</div>
					<div class="mb10 f16" style="margin-left:45px;">为保障账户安全，首次登录请修改您的密码！</div>
					<div class="cell clearfix">
						<div class="bt01">
							<span class="red">*</span>用户名：
						</div>
						<div class="info">
							<%
								StringHelper.filterHTML(out, manage.getAccountName());
							%>
						</div>
					</div>
					<div class="cell clearfix">
						<div class="bt01">
							<span class="red">*</span>密码：
						</div>
						<div class="info">
							<input name="passwordOne" type="password" class="text text3 password-a" maxlength="20" />
							<p class="gray9 intensity" tip>6~20个字符，区分大小写</p>
							<p errortip class="" style="display: none"></p>
						</div>
					</div>
					<div class="cell clearfix">
						<div class="bt01">
							<span class="red">*</span>确认密码：
						</div>
						<div class="info">
							<input name="passwordTwo" type="password" class="text text3 password-b" maxlength="20" />
							<p class="gray9" tip>请再次输入密码</p>
							<p errortip class="" style="display: none"></p>
						</div>
					</div>
					<div class="cell clearfix">
						<div class="bt01">&nbsp;</div>
						<div class="info">
							<input type="submit" class="btn btn01 sumbitForme" fromname="form1" value="确定">
						</div>
					</div>
				</div>
			</div>
		</form>
		<%
			}
		%>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/index.js"></script>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/jquery.SuperSlide.2.1.js"></script>
    <script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/news.js"></script>
    <script src="<%=controller.getStaticPath(request)%>/js/jquery.tabs.js"></script>
    <script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
	<%--<script type="text/javascript">

	$(".fullSlide").slide({titCell : ".hd ul",mainCell : ".bd ul",effect : "fold",autoPlay : true,autoPage : true,trigger : "click"});
	$(".txtScroll-top").slide({titCell : ".hd ul",mainCell : ".bd ul",autoPage : true,effect : "top",autoPlay : true,vis : 1});
	$(".picMarquee-left").slide({mainCell : ".bd ul",autoPlay : true,effect : "leftMarquee",vis : 6,interTime : 20});
	
	</script>--%>
    <script type="text/javascript">
	  jQuery(".fullSlide").hover(function() {
		  jQuery(this).find(".prev,.next").stop(true, true).fadeTo("show", 0.3)
	  },
	  function() {
		  jQuery(this).find(".prev,.next").fadeOut()
	  });
	  jQuery(".fullSlide").slide({
		  titCell: ".hd ul",
		  mainCell: ".bd ul",
		  effect: "fold",
		  autoPlay: true,
		  autoPage: true,
		  trigger: "click",
		  startFun: function(i) {
			  var curLi = jQuery(".fullSlide .bd li").eq(i);
			  if ( !! curLi.attr("_src")) {
				  curLi.css("background-image", curLi.attr("_src")).removeAttr("_src")
			  }
		  }
	  });
	  $(function(){
		$('.sx_3box').Tabs({
			event:'click'
		});
	});	
	  function autoScroll(obj){  
			$(obj).find("ul").animate({  
				marginTop : "-57px"  
			},500,function(){  
				$(this).css({marginTop : "0px"}).find("li:first").appendTo(this);  
			})  
		}  
		function autoScroll2(obj){  
			$(obj).find("ul").animate({  
				marginTop : "-94px"  
			},500,function(){  
				$(this).css({marginTop : "0px"}).find("li:first").appendTo(this);  
			})  
		}  
		$(function(){  
			setInterval('autoScroll(".maquee")',2500);
			setInterval('autoScroll2(".maquee2")',2500);
			  
		}) 
    function move0(){
	$(".sx_adbox").animate({
		height: "500px"
	},1500);
	 $(".sx_showPlay").css("display","none");
	}
	
	move0();
	function move() {
		$(".sx_adbox").animate({
		height: "0"
	   },1000);
	   $(".sx_showPlay").css("display","block");
	}
	$(".sx_ad_close").click(function(){
	   move();	
	})
	$("#sx_replay").click(function(){
	 move0();
	})
	setTimeout(move,5000);
</script>
</oscache:cache>
</body>
</html>