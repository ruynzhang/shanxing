<%@page import="com.dimeng.p2p.utlis.MerCached"%>
<%@page import="com.dimeng.p2p.front.servlets.xszy.Zxkf"%>
<%@page import="com.dimeng.p2p.S61.enums.T6110_F07"%>
<%@page import="com.dimeng.p2p.account.front.service.LetterManage"%>
<%@page import="com.dimeng.p2p.S61.enums.T6110_F10"%>
<%@page import="com.dimeng.p2p.S61.enums.T6110_F06"%>
<%@page import="com.dimeng.p2p.S61.entities.T6110"%>
<%@page import="com.dimeng.p2p.account.front.service.UserInfoManage"%>
<%@page import="com.dimeng.p2p.account.front.service.UserManage"%>
<%@page import="com.dimeng.util.filter.HTMLFilter"%>
<%@page import="java.util.UUID"%>
<%@page import="com.dimeng.p2p.front.servlets.Logout"%>
<%@page import="com.dimeng.p2p.bbs.client.Client"%>
<%@page import="com.dimeng.p2p.bbs.client.ClientClub"%>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/jquery-1.11.0.min.js"></script>
<script type="text/javascript">
$(function(){
	var tophtml="<div id=\"izl_rmenu\" class=\"izl-rmenu\"><a target=\"_blank\" href=\"http://wpa.b.qq.com/cgi/wpa.php?ln=1&key=XzkzODAzMDYwOV8yOTI2MDFfNDAwMDE2NjI3N18yXw\" class=\"btn btn-qq\"></a><div class=\"btn btn-phone_app\"><img class=\"app_pic\" src=\"/images/phone_shanxing.png\" ></div><div class=\"btn btn-wx\"><img class=\"pic\" src=\"/images/wechat_shanxing.png\" onclick=\"window.location.href=\'\'\"/></div><div class=\"btn btn-phone\"><div class=\"phone\">4000-166-277</div></div><div class=\"btn btn-top\"></div></div>";
	$("#top").html(tophtml);
	$("#izl_rmenu").each(function(){
		$(this).find(".btn-phone_app").mouseenter(function(){
			$(this).find(".app_pic").fadeIn("fast");
		});
		$(this).find(".btn-phone_app").mouseleave(function(){
			$(this).find(".app_pic").fadeOut("fast");
		});
		$(this).find(".btn-wx").mouseenter(function(){
			$(this).find(".pic").fadeIn("fast");
		});
		$(this).find(".btn-wx").mouseleave(function(){
			$(this).find(".pic").fadeOut("fast");
		});
		$(this).find(".btn-phone").mouseenter(function(){
			$(this).find(".phone").fadeIn("fast");
		});
		$(this).find(".btn-phone").mouseleave(function(){
			$(this).find(".phone").fadeOut("fast");
		});
		$(this).find(".btn-top").click(function(){
			$("html, body").animate({
				"scroll-top":0
			},"fast");
		});
	});
	var lastRmenuStatus=false;
	$(window).scroll(function(){//bug
		var _top=$(window).scrollTop();
		if(_top>200){
			$("#izl_rmenu").data("expanded",true);
		}else{
			$("#izl_rmenu").data("expanded",false);
		}
		if($("#izl_rmenu").data("expanded")!=lastRmenuStatus){
			lastRmenuStatus=$("#izl_rmenu").data("expanded");
			if(lastRmenuStatus){
				$("#izl_rmenu .btn-top").slideDown();
			}else{
				$("#izl_rmenu .btn-top").slideUp();
			}
		}
	});
});
$(document).ready(function(){ 
	function onLoad(){
		var nav_1=$("#nav_1");
		var nav_2=$("#nav_2");
		var nav_3=$("#nav_3");
		var nav_4=$("#nav_4");
		var nav_5=$("#nav_5");
	
		var windows_href=window.location.href;
		for(var i=1;i<8;i++){	
			 if(windows_href.indexOf("sbtz")!=-1){
				nav_2.addClass("hover");
				 return false;
			 }else if(windows_href.indexOf("dkyx")!=-1){
				nav_3.addClass("hover");
				return false;
		    }else if(windows_href.indexOf("guide")!=-1){
				nav_4.addClass("hover");
				return false;
		    }else if(windows_href.indexOf("safe")!=-1){
				nav_5.addClass("hover");
				return false;
		    }else if(windows_href.indexOf("gywm")!=-1 || windows_href.indexOf("sx")!=-1 || windows_href.indexOf("xszy")!=-1){
				return false;
		    }else{
		    	nav_1.addClass("hover");
		    	return false;
		    }	
	    }
	}
	onLoad(); 
})
</script>
<!--顶部条-->
<div class="bgBlock1">
    <div id="sx_topbox">
       <span class="sx_phone"><i></i>客服电话:&nbsp;4000-166-277</span>
       <div class="sx_regbox">
	   <%String accountName = null;
	   if (dimengSession == null || !dimengSession.isAuthenticated()) {%>
                <a href="<%configureProvider.format(out,URLVariable.LOGIN);%>">登录</a>
                <a href="<%configureProvider.format(out,URLVariable.REGISTER);%>">注册</a>
            <%} else { accountName = serviceSession.getService(UserManage.class).getAccountName();%>
					<a  title="<%=accountName%>">您好：<%StringHelper.truncation(new HTMLFilter(out), accountName, 12);%></a>
					  <a href="<%=configureProvider.format(URLVariable.USER_INDEX) %>">我的账户</a>
                 <%
					UserInfoManage userInfoManage=serviceSession.getService(UserInfoManage.class);
        			T6110 t6110=userInfoManage.getUserInfo(serviceSession.getSession().getAccountId());
					if(t6110.F07==T6110_F07.HMD||t6110.F07==T6110_F07.SD)
					{
						controller.redirectLogin(request, response, controller.getURI(request, Logout.class));
						return;
					}
                	int count = 0;
                  	if (dimengSession != null && dimengSession.isAuthenticated()) {
						count = serviceSession.getService(LetterManage.class).getUnReadCount();
                  	}
				%>
                <a href="<%configureProvider.format(out, URLVariable.USER_LETTER);%>">站内信(<span class="red"><%=count %></span>)</a>
					<a href="http://test.myshanxing.com/loginoutDiscuz.html">安全退出</a>
				<%}%></div>
			<div class="sx_share">
			<div class="share">
				<div class="sx_qq_s3" target="_blank" rel="nofollow">
					<span class="sx_box sx_s3"></span>
					<div class="sx_qq_box">
						<span></span>
						<p>新手投资交流群,实名认证</p>
						<p><a target="_blank" href="http://shang.qq.com/wpa/qunwpa?idkey=c647db3a06f80172936918518a1e7237a3f341e949d73b9cd9fca3fb3bb67817" rel="nofollow">
						<img border="0" src="/images/qqgroup.png" alt="新手投资交流群" title="新手投资交流群"></a><em>223270771</em></p>
						<p class="line"></p>
						<p>VIP投资交流群,实际参与过投资</p>
						<p><a target="_blank" href="http://shang.qq.com/wpa/qunwpa?idkey=ec5ba75276c67db55694a6e1ea66c2450cc643c3b767f950f36222af2ccfaa97" rel="nofollow">
						<img border="0" src="/images/qqgroup.png" alt="VIP投资交流群" title="VIP投资交流群"></a><em>281018458</em></p>
					</div>
				</div>
			<span ><a href="http://weibo.com/u/5329738108"  target="_blank" rel="nofollow" class="sx_box sx_s2"></a></span>
			<span class="sx_s1 sx_box"><i class="sx_wechat_box"><span></span><img src="/images/wechat_shanxing.png" alt="" /></i></span>
			<span  class="sx_s0" style="height:24px;margin-top: -4px;">手机APP<i class="sx_phone_box"><span></span><img src="/images/phone_app.png" alt="" /></i></span>
			</div>
			</div>
	<div class="clear"></div>
    </div>
</div>
<!--logo导航栏-->
<!--------菜单栏-------->
<div>
<div id="sx_menubox">
   <div class="sx_logo"><a href="<%configureProvider.format(out,URLVariable.INDEX);%>"><img src="<%=fileStore.getURL(configureProvider.getProperty(SystemVariable.QTLOGO))%>" title="<%configureProvider.format(out,SystemVariable.SITE_NAME);%>"></a></div>
</div>
</div>
<!--logo导航栏-->
<div class="clear"></div>
	<script type="text/javascript">
	$(function(){
	$(".sx_s1").hover(function(){
	$(".sx_wechat_box").fadeIn();
	},function(){
	$(".sx_wechat_box").fadeOut();
	});
	$(".sx_s0").hover(function(){
	$(".sx_phone_box").css("display","block");
	},function(){
	$(".sx_phone_box").css("display","none");
	});
	$(".sx_qq_s3").hover(function(){$(".sx_qq_box").stop(true,false).toggle();});
	});
	</script>