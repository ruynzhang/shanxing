<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.S62.enums.SURPRISE_STATUS"%>
<%@page import="com.dimeng.p2p.account.front.service.entity.UserInfo"%>
<%@page import="com.dimeng.p2p.modules.base.front.service.DistrictManage"%>
<%@page import="com.dimeng.p2p.front.servlets.Region"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.entity.Bdysx"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.entity.Bdylx"%>
<%@page import="com.dimeng.p2p.S61.enums.T6110_F06"%>
<%@page import="com.dimeng.p2p.S61.entities.T6110"%>
<%@page import="com.dimeng.p2p.S61.enums.T6120_F05"%>
<%@page import="com.dimeng.p2p.account.front.service.entity.UserRZInfo"%>
<%@page import="com.dimeng.p2p.front.servlets.gywm.Hzjg"%>
<%@page import="com.dimeng.p2p.common.enums.CreditLevel"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.dimeng.p2p.common.enums.Sex"%>
<%@page import="com.dimeng.p2p.common.enums.AttestationState"%>
<%@page import="com.dimeng.p2p.common.enums.IsHovestatus"%>
<%@page import="com.dimeng.p2p.common.enums.CreditStatus"%>
<html>
<head>
<title>体验标的详情-<%=configureProvider.getProperty(SystemVariable.SITE_TITLE)%></title>
<%
	String cityid="";
%>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
            <!--banner-->
<div class="zq_banner">
<div class="banner4"></div>
</div>
<!--banner-->
<div class="sx_memo"><p class="blue_ls">注册实名认证后只有到第三方开通,利息方能到账</p></div>
	<div class="contain clearfix">
		<%@include file="/WEB-INF/include/sbtz/headertyj.jsp"%>
		
		<div class="plan_tab clearfix">
			<ul>
				<li class="hover">体验标活动介绍</li>
				<li><a href="<%=controller.getPagingItemURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.BdTyjDetail.class, id)%>">体验标详情</a></li>
				<li><a href="<%=controller.getPagingItemURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.BdTyjmorg.class, id)%>">抵押物信息</a></li>
				<li><a href="<%=controller.getPagingItemURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.BdTyjfile.class, id)%>">相关文件</a></li>
				<li><a href="<%=controller.getPagingItemURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.BdTyjhk.class, id)%>">还款计划</a></li>
				<li><a href="<%=controller.getPagingItemURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.BdTyjrecord.class, id)%>">体验记录</a></li>
			</ul>
		</div>
		
		 <div class="contain_main clearfix ">
		
		<div class="pub_title pt10"><span class="fl">项目信息</span></div>
	    <div class="plan_tab_con clearfix" style="float:left;">
	        <ul class="plan_tabli clearfix">
	        <p><span style="color:red;">名称：</span>善行创投体验标</p>
            <p><span style="color:red;">活动时间：</span>5月21日-6月21日</p>
	        <p><span style="color:red;">活动介绍：</span>活动期间，用户能通过多种活动形式获取不同金额的体验金，获得的体验金，虽不是真实货币，却可以用于平台的体验标进行理财体验，且所得</p>
            <p style="padding-left:70px">收益可以以真实货币形式直接提现到账。目的在于让用户充分熟悉投标流程并享受投资回报。
     </p>
	             
	         <p><span style="color:red;">获取条件：</span>1.新用户注册获取200元体验金，实名认证再获取800元体验金</p>
             <p style="padding-left:70px">2.活动前已注册的老用户可以收到由善行创投发送的体验金口令激活短信，用户按短信提示操作即可领取1000元体验金（体验金活动前注册的为老用户）。</p>
             <p style="padding-left:70px">3.新、老用户可以在善林荟活动专区通过不定时发布的体验金口令贴获取体验金兑换口令，抢到的口令能兑换不等额的体验金。</p>
             <p style="padding-left:70px">4.新、老用户通过扫描游戏二维码或关注微信公众平台（myshanxing），参与趣味互动小游戏赢取不等额的体验金。</p>
	       
	         
	         <p ><span style="color:red">使用规则：</span></p>
	         <p><img src="<%=controller.getStaticPath(request)%>/images/tyjinfo.png"/></p>
	         <p style="padding-left:70px">1.该体验金仅限用于活动有效期内体验专区体验标的的投资，无法对真实标的进行投资，体验标也不接受现金投资。</p>
	         <p style="padding-left:70px">2.该体验金不显示在用户平台账户的可用资金中，只显示在体验金项目资金中，不可提现且只能使用一次。</p>
	         <p style="padding-left:70px">3.体验金投资操作流程和正常投资一样，且体验标无利息管理费，无积分发放。</p>
	         <p style="padding-left:70px">4.投体验标的用户必须经过注册和实名认证（身份认证、邮箱绑定和提现密码设置）后才能体验。</p>
	         <p style="padding-left:70px">5.成功投体验标获得站内信通知和提示框提醒</p>
	         <p style="padding-left:70px">6.在体验期内，用户获得新的体验金的情况下可以追加资金进入理财体验活动</p>
	         <p style="padding-left:70px">7.体验金虚拟投资产生收益后收益以真实货币形式直接到账平台账户，不算入在体验金额度，放款通过时系统自动收回体验本金。</p>
	         <p style="padding-left:70px">8.收益方式和体验期限以发行的当期理财体验产品描述为准</p>
	         <p style="padding-left:70px">9.体验金自获取即日到活动结束内有效，到期后未进行投资系统将自动回收体验金。</p>
	         <p style="padding-left:70px">10.本期理财体验活动设有可参与的总额度，一旦达到该总额度，体验金活动提前结束。</p>
	         <p style="padding-left:70px">11.对于恶意刷奖者，善行创投有权终止其所得奖励。</p><br />
	         <p style="float:right;"><span style="color:red">*本规则最终解析权归善行创投所有</span></p>
	        </ul>
            
	    </div>
		</div>
		
	</div>
	<div id="info"></div>
	<%@include file="/WEB-INF/include/footer.jsp" %>
	<%@include file="/WEB-INF/include/script.jsp"%>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/financing/sbtz.js"></script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/dialog.js"></script>
	<%
		String message = controller.getPrompt(request, response , PromptLevel.INFO);
			if (!StringHelper.isEmpty(message)) {
	%>
	<script type="text/javascript">
		$("#info").html(showDialogInfo("<%=message%>","succeed"));	
		$("div.popup_bg").show();
	</script>
	<%
		}
	%>
	
	<%
		String errorMessage = controller.getPrompt(request, response , PromptLevel.ERROR);
			if (!StringHelper.isEmpty(errorMessage)) {
				
	%>
	<script type="text/javascript">
		$("#info").html(showDialogInfo("<%=errorMessage%>","error"));	
		$("div.popup_bg").show();
	</script>
	<%
		}
	%>
	
	<%
		String warnMessage = controller.getPrompt(request, response , PromptLevel.WARRING);
			if (!StringHelper.isEmpty(warnMessage)) {
	%>
	<script type="text/javascript">
		$("#info").html(showDialogInfo("<%=warnMessage%>","perfect"));	
		$("div.popup_bg").show();
	</script>
	<%
		}
	%>
</body>
</html>