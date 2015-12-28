<%@page import="com.dimeng.p2p.utlis.MerCached"%>
<%@page import="com.dimeng.p2p.S61.enums.T6110_F07"%>
<%@page import="com.dimeng.p2p.S61.enums.T6110_F10"%>
<%@page import="com.dimeng.p2p.S61.enums.T6110_F06"%>
<%@page import="com.dimeng.p2p.S61.entities.T6110"%>
<%@page import="com.dimeng.p2p.account.user.service.UserInfoManage"%>
<%@page import="com.dimeng.p2p.account.user.service.UserManage"%>
<%@page import="com.dimeng.p2p.account.user.service.LetterManage"%>
<%@page import="com.dimeng.util.filter.HTMLFilter"%>
<%@page import="java.util.UUID"%>
<%@page import="com.dimeng.p2p.user.servlets.Logout"%>
<%@page import="com.dimeng.p2p.variables.defines.URLVariable"%>
<%@page import="com.dimeng.p2p.variables.defines.SystemVariable"%>
<%@page import="com.dimeng.p2p.bbs.client.Client"%>
<%@page import="com.dimeng.p2p.bbs.client.ClientClub"%>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/zzsc1016.js"></script>

<!--顶部条-->
<div class="bgBlock1">
    <div id="sx_topbox">
       <span class="sx_phone"><i></i>客服电话:&nbsp;<%configureProvider.format(out,SystemVariable.SITE_CUSTOMERSERVICE_TEL);%></span>
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
<!--顶部条-->
<%-- 
<div class="top clearfix">
	<div class="top_bar">
		<div class="lft">
			<ul>
				<li class="tit1"><%configureProvider.format(out,SystemVariable.SITE_CUSTOMERSERVICE_TEL);%></li>
				<li class="tit2"><a href="<%configureProvider.format(out,URLVariable.CUSTOMERS);%>">在线客服</a></li>
			</ul>
		</div>
		<div class="rig">
			<a href="<%configureProvider.format(out,URLVariable.INDEX);%>">首页</a>
			<%if (dimengSession == null || !dimengSession.isAuthenticated()) {%>
			<%}else{
			
				int count = serviceSession.getService(LetterManage.class).getUnReadCount();
			%>
			<a href="<%configureProvider.format(out,URLVariable.USER_LETTER);%>" class="message">站内信<%if(count>0){%><span class="red">(<%=count %>)</span><%}%></a>
			<%}%>
			<a href="<%configureProvider.format(out,URLVariable.USER_INDEX);%>">我的<%configureProvider.format(out,SystemVariable.SITE_NAME);%></a>
			<a href="<%configureProvider.format(out,URLVariable.HELP_CENTER);%>">投资攻略</a>
		</div>
	</div>
</div>
--%>

<!--logo导航栏-->
<div class="bgblock_menu">
<div id="sx_menubox">
   <div class="sx_logo"><a href="<%configureProvider.format(out,URLVariable.INDEX);%>"><img src="<%=fileStore.getURL(configureProvider.getProperty(SystemVariable.QTLOGO))%>" title="<%configureProvider.format(out,SystemVariable.SITE_NAME);%>"></a></div>
   <div class="sx_menu">
       <a href="<%configureProvider.format(out,URLVariable.INDEX);%>" id="nav_1">首页</a>
       <a href="<%configureProvider.format(out,URLVariable.FINANCING_SBTZ);%>" id="nav_2">我要投资</a>
       <a href="<%configureProvider.format(out,URLVariable.CREDIT_DKYX);%>" id="nav_3">我要借款</a>
       <a href="/guide.html" id="nav_4">理财攻略</a>
       <a href="/safe/risk.html" id="nav_5">风险控制</a>
   </div>
   <div class="clear"></div>
</div>
</div>
<!--logo导航栏-->
<%-- 
<div class="header">
	<div class="logo fl">
		<a href="<%configureProvider.format(out,URLVariable.INDEX);%>"><img src="<%=controller.getStaticPath(request)%>/images/logo.png" title="<%configureProvider.format(out,SystemVariable.SITE_NAME);%>" /></a>
	</div>
	<ul class="menu">
		<li><a href="<%configureProvider.format(out,URLVariable.FINANCING_CENTER);%>" class="tablink">我要理财</a>
			<ul>
				 <li><a href="<%configureProvider.format(out,URLVariable.FINANCING_YX);%>">优选理财计划</a></li> 
				<li><a href="<%configureProvider.format(out,URLVariable.FINANCING_SBTZ);%>">理财投资列表</a></li>
				 <li><a href="<%configureProvider.format(out,URLVariable.FINANCING_ZQZR);%>">债权转让列表</a></li> 
				<li><a href="<%configureProvider.format(out,URLVariable.FINANCING_HKHMD);%>">还款黑名单</a></li>
			</ul></li>
		<li><a class="hide" href="<%configureProvider.format(out,URLVariable.CREDIT_CENTER);%>">我要借款</a>
			<ul>
				<li><a href="<%configureProvider.format(out,URLVariable.CREDIT_XJD);%>">薪金贷</a></li>
				<li><a href="<%configureProvider.format(out,URLVariable.CREDIT_DKYX);%>">个人借款意向</a></li>
				<li><a href="<%configureProvider.format(out,URLVariable.CREDIT_QYDKYX);%>">企业借款意向</a></li>
 				<li><a href="<%configureProvider.format(out,URLVariable.CREDIT_GRXYRZ);%>">个人信用融资</a></li>
				<li><a href="<%configureProvider.format(out,URLVariable.CREDIT_GRDBRZ);%>">个人担保融资</a></li>
				<li><a href="<%configureProvider.format(out,URLVariable.CREDIT_QYXYRZ);%>">企业信用融资</a></li>
				<li><a href="<%configureProvider.format(out,URLVariable.CREDIT_QYDBRZ);%>">企业担保融资</a></li> 
			</ul></li>
	</ul>
	<%if (dimengSession == null || !dimengSession.isAuthenticated()) {%>
	<div class="index_login fr">
		<a href="<%configureProvider.format(out,URLVariable.REGISTER);%>">注册</a><a href="<%configureProvider.format(out,URLVariable.LOGIN);%>">登录</a>
	</div>
	<%} else {
		UserInfoManage uManage = serviceSession.getService(UserInfoManage.class);
		T6110 t6110 =uManage.getUserInfo(serviceSession.getSession().getAccountId());
		T6110_F06 userType = t6110.F06;
	%>
	<div class="index_login index_info fr">
		<div class="name fl">
			<a href="<%=controller.getViewURI(request, com.dimeng.p2p.user.servlets.Index.class) %>" title="<%StringHelper.filterHTML(out, serviceSession.getService(UserManage.class).getAccountName());%>">
			<span class="tips fl" title="<%=serviceSession.getService(UserManage.class).getAccountName()%>">您好，<%StringHelper.truncation(new HTMLFilter(out), serviceSession.getService(UserManage.class).getAccountName(), 8);%></span>
			<i class="fr"></i>
			</a>
		</div>
		<ul class="navbar">
			<li><a href="<%configureProvider.format(out,URLVariable.USER_CHARGE);%>">充值</a></li>
			<li class="line"><a href="<%configureProvider.format(out,URLVariable.USER_WITHDRAW);%>">提现</a>
			</li>
			<li><a href="<%configureProvider.format(out,URLVariable.USER_CAPITAL);%>">资金管理</a>
			</li>
			<%
				if(userType==T6110_F06.ZRR)
				{
			%>
			<li><a href="<%configureProvider.format(out,URLVariable.USER_FINANCING);%>">理财管理</a>
			</li>
			<%} %>
			<%
				if(t6110.F10==T6110_F10.F)
				{
			%>
			<li class="line"><a href="<%configureProvider.format(out,URLVariable.USER_CREDIT);%>">借款管理</a></li>
			<%} %>
			<li><a href="<%=controller.getURI(request, Logout.class)%>">安全退出</a></li>
		</ul>
	</div>
	<%}%>
</div>
--%>
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