<%@page import="com.dimeng.p2p.user.servlets.capital.Mytyjklpaper"%>
<%@page import="com.dimeng.p2p.user.servlets.capital.AlerMytyjpaper"%>
<%@page import="com.dimeng.p2p.user.servlets.capital.OrderServlet"%>
<%@page import="com.dimeng.p2p.user.servlets.capital.Redpaper"%>
<%@page import="com.dimeng.p2p.user.servlets.capital.Mytyjpaper"%>
<%@page import="com.dimeng.p2p.S61.enums.T6110_F10"%>
<%@page import="com.dimeng.p2p.S61.enums.T6110_F06"%>
<%@page import="com.dimeng.p2p.S61.entities.T6110"%>
<%@page import="com.dimeng.p2p.account.user.service.UserInfoManage"%>
<div class="sidebar fl">
<div class="me_wdw wdw" style="display:none;"><a <%="WDWDW".equals(CURRENT_CATEGORY)?"class=\"hover\"":""%> href="<%=controller.getViewURI(request, com.dimeng.p2p.user.servlets.Index.class)%>">我的<%=configureProvider.getProperty(SystemVariable.SITE_NAME)%></a></div>
	<!--<div class="tit_bo a1"><i class="a_ui_tit"></i><span <%="ZJGL".equals(CURRENT_CATEGORY)?"class=\"hover\"":""%>>我的帐户</span></div>-->
	<ul class="barlist" style="display: block;">
        <li <%="WDWDW".equals(CURRENT_SUB_CATEGORY)?"class=\"on\"":""%>>
			<a href="<%=controller.getViewURI(request, com.dimeng.p2p.user.servlets.Index.class)%>"><i></i>我的帐户</a>
		</li>
        <li <%="WDZQ".equals(CURRENT_SUB_CATEGORY)?"class=\"on\"":"" %>>
			<a href="<%=controller.getViewURI(request, com.dimeng.p2p.user.servlets.financing.wdzq.Hszdzq.class) %>"><i></i>我的投资</a>
		</li>
        <li <%="ZDTBGJ".equals(CURRENT_SUB_CATEGORY)?"class=\"on\"":"" %>>
			<a href="<%=controller.getViewURI(request, com.dimeng.p2p.user.servlets.financing.zdtb.Index.class) %>"><i></i>自动投标</a>
		</li>
        <li <%="JKSQCX".equals(CURRENT_SUB_CATEGORY)?"class=\"on\"":"" %>>
			<a href="<%=controller.getViewURI(request, com.dimeng.p2p.user.servlets.credit.Apply.class) %>"><i></i>我的借款</a>
		</li>
        <li <%="ZQZR".equals(CURRENT_SUB_CATEGORY)?"class=\"on\"":"" %>>
			<a href="<%=controller.getViewURI(request, com.dimeng.p2p.user.servlets.financing.zqzr.Zqzrz.class) %>"><i></i>我的转让</a>
		</li>
        <li <%="JYJL".equals(CURRENT_SUB_CATEGORY)?"class=\"on\"":""%>>
			<a href="<%=controller.getViewURI(request, com.dimeng.p2p.user.servlets.capital.TradingRecord.class)%>"><i></i>资金明细</a>
		</li>
		<%--
        <li <%="CZ".equals(CURRENT_SUB_CATEGORY)?"class=\"on\"":""%>>
			<a href="<%=controller.getViewURI(request, com.dimeng.p2p.user.servlets.capital.Charge.class)%>"><i></i>充值</a>
		</li>
        <li <%="TXGL".equals(CURRENT_SUB_CATEGORY)?"class=\"on\"":""%>><a href="<%=controller.getViewURI(request, com.dimeng.p2p.user.servlets.capital.Withdraw.class)%>"><i></i>提现</a></li>
		 
		<li <%="XXJY".equals(CURRENT_SUB_CATEGORY)?"class=\"on\"":""%>>
			<a href="<%=controller.getURI(request, com.dimeng.p2p.user.servlets.capital.TradeRecord.class)%>"><i></i>线下交易</a>
		</li>--%>
        <li <%="SKMX".equals(CURRENT_SUB_CATEGORY)?"class=\"on\"":""%>><a href="/user/financing/wdzq/backMoney.htm"><i></i>收款明细</a></li>
		<li <%="ZNXX".equals(CURRENT_SUB_CATEGORY)?"class=\"on\"":"" %>>
			<a href="<%=controller.getViewURI(request, com.dimeng.p2p.user.servlets.letter.Index.class) %>"><i></i>消息列表</a>
		</li>
        <%--<li <%="WDTYJ".equals(CURRENT_SUB_CATEGORY)?"class=\"on\"":""%>><a href="<%=controller.getViewURI(request, AlerMytyjpaper.class)%>"><i></i>体验金</a></li>--%>

	</ul>
	<%	
		UserInfoManage uManage = serviceSession.getService(UserInfoManage.class);
		T6110 t6110 =uManage.getUserInfo(serviceSession.getSession().getAccountId());
		T6110_F06 userType = t6110.F06;
		if(userType == T6110_F06.ZRR){
	%>
	<!--<span class="tit_bo" id="m2"  ><i class="a_ui_icon"></i><span <%="LCGL".equals(CURRENT_CATEGORY)?"class=\"hover\"":"" %>>我的投资</span></span>-->
	<ul class="barlist" style="display: block;">
		
		<%-- <li <%="YXLCJH".equals(CURRENT_SUB_CATEGORY)?"class=\"on\"":"" %>>
			<a href="<%=controller.getViewURI(request, com.dimeng.p2p.user.servlets.financing.yxlc.Yxlcsqz.class) %>"><i></i>优选理财计划</a>
		</li> --%>
		<!--<li <%="LCTJ".equals(CURRENT_SUB_CATEGORY)?"class=\"on\"":"" %>>
			<a href="<%=controller.getViewURI(request, com.dimeng.p2p.user.servlets.financing.FinancingStatistics.class) %>"><i></i>理财统计</a>
		</li>-->
		
	</ul>
	<%} %>
	<%if(t6110.F10 == T6110_F10.F){%>
	<!--<span class="tit_bo" id="m3"><i class="a_ui_icon01"></i><span <%="JKGL".equals(CURRENT_CATEGORY)?"class=\"hover\"":"" %>>借款管理</span></span>-->
	<ul class="barlist" style="display: block;">
		
		<!--<li <%="JKTJ".equals(CURRENT_SUB_CATEGORY)?"class=\"on\"":"" %>>
			<a href="<%=controller.getViewURI(request, com.dimeng.p2p.user.servlets.credit.CreditStatistics.class) %>"><i></i>借款统计</a>
		</li>-->
	</ul>
	<%} %>
		<%if(t6110.F10 == T6110_F10.S){%>
	<span class="tit_bo" id="m3"><i class="a_ui_icon01"></i><span <%="FXBYJGL".equals(CURRENT_CATEGORY)?"class=\"hover\"":"" %>>风险备用金管理</span></span>
	<ul class="barlist" style="display: block;">
		<li <%="DBYWMX".equals(CURRENT_SUB_CATEGORY)?"class=\"on\"":"" %>>
			<a href="<%=controller.getViewURI(request, com.dimeng.p2p.user.servlets.fxbyj.Dbywmx.class) %>"><i></i>担保业务明细</a>
		</li>
		<li <%="DFZQ".equals(CURRENT_SUB_CATEGORY)?"class=\"on\"":"" %>>
			<a href="<%=controller.getViewURI(request, com.dimeng.p2p.user.servlets.fxbyj.Dfzq.class) %>"><i></i>垫付债权</a>
		</li>
	</ul>
	<%} %>
	<!--<span class="tit_bo" id="m4"><i class="a_ui_icon02"></i><span <%="ZHGL".equals(CURRENT_CATEGORY)?"class=\"hover\"":"" %>>信息认证</span></span>-->
	<ul class="barlist" style="display: block;">
         <li <%="AQXX".equals(CURRENT_SUB_CATEGORY)?"class=\"on\"":"" %>>
			<a href="<%=controller.getViewURI(request, com.dimeng.p2p.user.servlets.account.Safetymsg.class) %>"><i></i>个人信息</a>
		</li>
        <!--<li <%="YHKXX".equals(CURRENT_SUB_CATEGORY)?"class=\"on\"":"" %>>
			<a href="<%=controller.getViewURI(request, com.dimeng.p2p.user.servlets.account.Bankcardlist.class) %>"><i></i>银行卡</a>
		</li>-->
		<%if(t6110.F06 == T6110_F06.ZRR){ %>
		<!--<li <%="GRJCXX".equals(CURRENT_SUB_CATEGORY)?"class=\"on\"":"" %>>
			<a href="<%=controller.getViewURI(request, com.dimeng.p2p.user.servlets.account.UserBases.class)%>"><i></i>个人信息</a>
		</li>-->
		<!--<li <%="RZXX".equals(CURRENT_SUB_CATEGORY)?"class=\"on\"":"" %>>
			<a href="<%=controller.getViewURI(request, com.dimeng.p2p.user.servlets.account.Attestationmsg.class) %>"><i></i>信用额度</a>
		</li>-->
		<%}else{ %>
		<li <%="QYJCXX".equals(CURRENT_SUB_CATEGORY)?"class=\"on\"":"" %>>
			<a href="<%=controller.getViewURI(request, com.dimeng.p2p.user.servlets.account.QyBases.class)%>"><i></i>企业信息</a>
		</li>
		<%} %>
	</ul>
	<span class="tit_bo" id="m5" style="display: none;"><i class="a_ui_icon03"></i><span <%="XXGL".equals(CURRENT_CATEGORY)?"class=\"hover\"":"" %>>消息管理</span></span>
	<ul class="barlist" style="display: none;">
		<li <%="ZNXX".equals(CURRENT_SUB_CATEGORY)?"class=\"on\"":"" %>>
			<a href="<%=controller.getViewURI(request, com.dimeng.p2p.user.servlets.letter.Index.class) %>"><i></i>站内消息</a>
		</li>
	</ul>
	<%if(t6110.F06 == T6110_F06.ZRR){ %>
	<!--<span class="tit_bo" id="m6"><i class="a_ui_icon05"></i><span <%="TGGL".equals(CURRENT_CATEGORY)?"class=\"hover\"":"" %>>好友管理</span></span>-->
	<ul class="barlist" style="display: block;">
		<li <%="WYTG".equals(CURRENT_SUB_CATEGORY) || "WDTG".equals(CURRENT_SUB_CATEGORY)?"class=\"on\"":"" %>>
			<a href="<%=controller.getViewURI(request, com.dimeng.p2p.user.servlets.spread.Wytg.class) %>"><i></i>好友邀请</a>
		</li>
		<!--<li <%="WDTG".equals(CURRENT_SUB_CATEGORY)?"class=\"on\"":"" %>>
			<a href="<%=controller.getViewURI(request, com.dimeng.p2p.user.servlets.spread.Wdtg.class) %>"><i></i>我的好友</a>
		</li>-->
	<li <%="WDHB".equals(CURRENT_SUB_CATEGORY)?"class=\"on\"":""%>><a href="/user/capital/wdhb.html"><i></i>我的红包</a></li>
	<li <%="WDTYJ".equals(CURRENT_SUB_CATEGORY)?"class=\"on\"":""%>><a href="<%=controller.getViewURI(request, AlerMytyjpaper.class)%>"><i></i>我的体验金</a></li>
	
	</ul>
	<%} %>
</div>