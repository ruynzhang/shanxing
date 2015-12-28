<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.S62.enums.SURPRISE_NAME"%>
<%@page import="com.dimeng.p2p.S62.entities.SurpriseConfig"%>
<%@page import="com.dimeng.p2p.front.servlets.xszy.*"%>
<%@page import="java.util.List"%>
<%@page import="com.dimeng.p2p.S62.entities.SurpriseLucre"%>
<%@page import="com.dimeng.p2p.S61.enums.T6110_F06"%>
<%@page import="com.dimeng.p2p.S61.entities.T6110"%>
<%@page import="com.dimeng.p2p.account.front.service.UserInfoManage"%>
<%@page import="com.dimeng.p2p.front.servlets.financing.sbtz.Xxzqlb"%>
<%@page import="com.dimeng.p2p.front.servlets.financing.AbstractFinancingServlet"%>
<%@page import="com.dimeng.p2p.front.servlets.financing.sbtz.Bdxq"%>
<%@page import="com.dimeng.p2p.front.servlets.financing.sbtz.Tbjl"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F13"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F14"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F11"%>
<%@page import="com.dimeng.p2p.common.enums.CreditTerm"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.query.TransferQueryAccount"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.entity.Zqzqlb"%>
<%@page import="com.dimeng.util.http.URLParameter"%>
<%@page import="com.dimeng.p2p.S51.entities.T5124"%>
<%@page import="com.dimeng.p2p.S62.entities.T6211"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.BidManage"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.entity.Zqzrtj"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.TransferManage"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.dimeng.p2p.S62.entities.T6231"%>
<%@page import="com.dimeng.p2p.S62.enums.T6231_F21"%>
<html>
<head>
<title>散标详情-<%=configureProvider.getProperty(SystemVariable.SITE_TITLE)%></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<%!static final String TYPE_KEY="p"; static final String TERM_KEY="m";static final String LEVEL_KEY="l";static final String MULTISELECT_KEY="s";static final String WAY="w";%>
<%
	final HttpServletRequestWrapper requestWrapper = new  HttpServletRequestWrapper(request);
	final String way = requestWrapper.getParameter(WAY);
	String w = "";
    if (!StringHelper.isEmpty(way)) {
    	w = "?w="+way;
    }
	boolean multiSelect = "1".equals(request.getParameter(MULTISELECT_KEY));
	BidManage bidManage = serviceSession.getService(BidManage.class);
	T6211[] t6211s= bidManage.getBidType();
	T5124[] t5124s= bidManage.getLevel();
	URLParameter parameter = new URLParameter(request,controller.getViewURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Index.class),multiSelect,MULTISELECT_KEY,TYPE_KEY,TERM_KEY,LEVEL_KEY,WAY);
	parameter.set(WAY, way);
%>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
    <!--banner-->
<div class="zq_banner">
<div class="banner4"></div>
</div>
<!--banner-->

	<div class="contain clearfix">
		<%@include file="/WEB-INF/include/sbtz/header.jsp"%>
		
		<div class="plan_tab clearfix">
			<ul>
				<li><a href="<%=controller.getPagingItemURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Bdxq.class, id)%>">标的详情</a></li>
				<%if(creditInfo.F11 == T6230_F11.S){ %>
				<li><a href="<%=controller.getPagingItemURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Dbxx.class, id)%>">风控信息</a></li>
				<%} %>
				<%
					if(creditInfo.F13 == T6230_F13.S){
				%>
				<li><a href="<%=controller.getPagingItemURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Dyxx.class, id)%>">抵押物信息</a></li>
				<%
					}
				%>
				<%if(isXgwj){%>
				<li><a href="<%=controller.getPagingItemURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Xgwj.class, id)%>">相关文件</a></li>
				<%} %>
				<li><a href="<%=controller.getPagingItemURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Hkjl.class, id)%>">还款计划</a></li>
				<li><a href="<%=controller.getPagingItemURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Tbjl.class, id)%>">投资记录</a></li>
				<li class="hover">获奖记录</li>
			</ul>
		</div>
		<%{%>
		<div class="contain_main clearfix">
			<div class="plan_tab_con01 clearfix">
				<div class="sx_awardbox">
                 <p class="sx_award_desc">您若邀请好友来注册投资且收益，系统将按照您好友收益的8%由善行创投奖励给您！！！</p>
                 <h2 class="sx_award_title">什么是惊喜奖</h2>
                 <p>惊喜奖是标的满标放款后按照您预期收益的奖励百分比直接转账到您账户，投资金额越大，返现越多</p>
                 <P>例：您投了50000元，年化收益为12%，预期一年收益则为6000元，你中了秒杀奖，2%收益返现为120元直接打到您账户，可作提现</P><br />
                 <ul class="sx_award_list">
                 	<%for(SurpriseConfig surpriseConfig : bidManage.getSurpriseConfigByBid(id)){%>
                 	<li>
                    	<div class="aw_n1"><%=surpriseConfig.name.getChineseName()%></div>
                    	<%String jxjDesc = ""; switch(surpriseConfig.name){
                    	case SBJ:jxjDesc = "面向对象：第一个投标会员";break;
                    	case XRJ:jxjDesc = "面向对象：尚未投过标的会员现在来投标";break;
                    	case THJ:jxjDesc = "面向对象：投标金额为两万以上的会员";break;
                    	case MXJ:jxjDesc = "面向对象：本标一次性投完标的会员";break;
                    	case SGJ:jxjDesc = "面向对象：本标最后投标的会员";break;} %>
                    	<div class="aw_n2"><%=jxjDesc%></div><div class="aw_n3">额外奖励：本标的预期收益的<b class="orange"><%=Formater.formatRate(surpriseConfig.rate)%></b>返现</div>
                    	<p class="clear"></p>
                    </li>
                 	<%}%>
                 </ul>
                 <p><b>惊喜奖规则如下：</b><br />
              1. 惊喜奖将会在本标回款后以站内信的形式告知大家，同时按照您预期收益的奖励百分比直接转账到您账户<br />
              2. 每人每项的获奖次数在本标只限一次<br />
              3. 每人每标不超过两项，若同时满足两项以上的，以最高收益的两项优先<br />
              4. 若是同等年利率，按照以下排序给予奖励<br/>
                 &nbsp;&nbsp;&nbsp;&nbsp;(1) 首投奖&nbsp;&nbsp;(2)新人奖&nbsp;&nbsp;(3)收官奖&nbsp;&nbsp;(4) 土豪奖&nbsp;&nbsp;(5) 秒杀奖<br />
              5. 秒杀奖秒杀其他奖项，其他奖项一律无效<br />
              6. 流标所有奖项归零，新人奖重置在您投资的下一个标的<br />
                 <br />
              本活动规则的最终解析权归善行创投所有，如有变更请看平台公告
              </p>
                 <div class="sx_get_superise">
                    <%List<SurpriseLucre> lucreList = bidManage.getSurpriseWinners(id);
                    for(SurpriseLucre lucre : lucreList){%>
                    <p><%=lucre.accountName.substring(0, 6)+"**"%>获得<%=lucre.config.name.getChineseName()%></p>
                    <%} %>
                 </div>
                 </div>
			</div>
		</div>
		<%}%>

	</div>
	<div id="info"></div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/financing/sbtz.js"></script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/dialog.js"></script>

<%
		String message = controller.getPrompt(request, response , PromptLevel.INFO);
			if (!StringHelper.isEmpty(message)) {
	%>
	<script type="text/javascript">
		$("#info").html(showSuccInfo("<%=message%>","succeed",$("#sbSucc").val()));	
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