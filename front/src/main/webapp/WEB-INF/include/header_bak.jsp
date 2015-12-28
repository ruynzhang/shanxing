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
$(document).ready(function(){
	function onLoad(){
		var nav_1=$("#nav_1");
		var nav_2=$("#nav_2");
		var nav_3=$("#nav_3");
		var nav_4=$("#nav_4");
		var nav_5=$("#nav_5");
		var nav_6=$("#nav_6");
		var nav_7=$("#nav_7");
		var nav_8=$("#nav_8");
		var windows_href=window.location.href;
		for(var i=1;i<=8;i++){	
			 if(windows_href.indexOf("gywm")!=-1||windows_href.indexOf("zxdt")!=-1){
				nav_4.addClass("hover");
				return false;
			 }else if(windows_href.indexOf("safe")!=-1){
		        nav_2.addClass("hover");
				return false;
			 }else if(windows_href.indexOf("sbtz")!=-1){
				nav_1.addClass("hover");
				 return false;
			 }else if(windows_href.indexOf("credit")!=-1){
				nav_3.addClass("hover");
				return false;
		    }else if(windows_href.indexOf("kindness")!=-1){
				nav_5.addClass("hover");
				return false;
		    }else if(windows_href.indexOf("xszy")!=-1){
				nav_6.addClass("hover");
				return false;
		    }else if(windows_href.indexOf("guide")!=-1){
				nav_7.addClass("hover");
				return false;
		    }else if(windows_href.indexOf("discuz")!=-1){
				nav_8.addClass("hover");
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
       <div class="sx_share"><a href="http://qm.qq.com/cgi-bin/qm/qr?k=tNDaYLzeTm6TmqbLe_dD9eyO5iwd1qRs" class="sx_s3" target="_blank" rel="nofollow">QQ</a><a href="http://weibo.com/u/5329738108" class="sx_s2" target="_blank" rel="nofollow">微博</a><a href="#" class="sx_s1">微信</a><div class="sx_wechat_box"><span></span><p><img src="/images/wechat_shanxing.png" alt="" /></p></div><div class="sx_qq_box"><span></span><p>点击加入善行创投QQ群</p></div></div>
       <div class="clear"></div>
    </div>
</div>
<!--顶部条-->
<%--<div class="sx_adbox">
<a href="/active/tyjactive.html" target="_blank"></a>
<div class="sx_ad_close"></div>
</div>
<div class="sx_showPlay">
<a href="/active/tyjactive.html" id="sx_award_bt2" target="_blank"></a>
<a href="javascript:void();" id="sx_replay">重<br />播</a>
<a href="/active/tyjactive.html" id="sx_award_bt" target="_blank"></a>
</div> --%>
<!--logo导航栏-->
<!--------菜单栏-------->
<div class="bgblock_menu">
<div id="sx_menubox">
   <div class="sx_logo"><a href="<%configureProvider.format(out,URLVariable.INDEX);%>"><img src="<%=fileStore.getURL(configureProvider.getProperty(SystemVariable.QTLOGO))%>" title="<%configureProvider.format(out,SystemVariable.SITE_NAME);%>"></a></div>
   <div class="sx_menu">
       <a href="<%configureProvider.format(out,URLVariable.FINANCING_SBTZ);%>" id="nav_1">我要理财</a>
       <a href="<%configureProvider.format(out,URLVariable.CREDIT_DKYX);%>" id="nav_3">我要借款</a>
       <a href="<%=controller.getStaticPath(request)%>/guide/" id="nav_7">新手指引</a>
       <a href="<%=controller.getStaticPath(request)%>/safe/keep.html" id="nav_2">安全保障</a>
       <a href="<%configureProvider.format(out, URLVariable.GYWM_GSJJ);%>" id="nav_4">关于我们</a>
       <a href="<%=controller.getStaticPath(request)%>/sx/kindness.html" id="nav_5">善行公益</a>
       <a href="<%=controller.getStaticPath(request)%>/xszy/help.html" id="nav_6">帮助中心</a>
       <a target="_blank" href="http://www.shanlinhui.com/" id="nav_9">善林荟</a> 
   </div>
   <div class="clear"></div>
</div>
</div>
<!--logo导航栏-->