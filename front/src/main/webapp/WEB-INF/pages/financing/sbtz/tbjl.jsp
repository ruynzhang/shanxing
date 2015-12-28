<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.S62.enums.SURPRISE_STATUS"%>
<%@page import="com.dimeng.p2p.front.servlets.xszy.*"%>
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
	TransferManage service = serviceSession.getService(TransferManage.class);
	final HttpServletRequestWrapper requestWrapper = new  HttpServletRequestWrapper(request);
	final String way = requestWrapper.getParameter(WAY);
	String w = "";
    if (!StringHelper.isEmpty(way)) {
    	w = "?w="+way;
    }
	Zqzrtj total=service.getStatistics();
	boolean multiSelect = "1".equals(request.getParameter(MULTISELECT_KEY));
	BidManage bidManage = serviceSession.getService(BidManage.class);
	T6211[] t6211s= bidManage.getBidType();
	T5124[] t5124s= bidManage.getLevel();
	URLParameter parameter = new URLParameter(request,controller.getViewURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Zqzrlb.class),multiSelect,MULTISELECT_KEY,TYPE_KEY,TERM_KEY,LEVEL_KEY,WAY);
	parameter.set(WAY, way);
	BigDecimal zqMoney = new BigDecimal(0);
	BigDecimal zfMoney = new BigDecimal(0);
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
				<li class="hover">投资记录</li>
                <%if(creditInfo.surpriseStatus != null && creditInfo.surpriseStatus != SURPRISE_STATUS.WPZ){ %>
				<li><a href="<%=controller.getPagingItemURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Hjjl.class, id)%>">获奖记录</a></li>
				<%} %>
			</ul>
		</div>
		<%{
			T6250[] tenderRecords = investManage.getRecord(id);
		%>
		<div class="contain_main clearfix">
			<div class="plan_tab_con01 clearfix">
				<div class="fr">
				<%BigDecimal totleMoney=new BigDecimal(0);
				if (tenderRecords != null && tenderRecords.length>0) {
					for (T6250 tenderRecord : tenderRecords) {
						if (tenderRecord == null) {continue;};
						totleMoney=totleMoney.add(tenderRecord.F04);
						}}%>
					<span class="mr10">加入人次<em class="f18 orange"><%=tenderRecords == null?0:tenderRecords.length %></em>人
					</span> <span class="mr10">投标总额<em class="f18 orange"><%=Formater.formatAmount(totleMoney) %></em>元
					</span>
				</div>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tc">
					<tr class="leve_titbj">
						<td width="330">序号</td>
						<td width="156">投标人</td>
						<td width="362">投标金额</td>
						<td width="362">投标时间</td>
					</tr>
					<%if (tenderRecords != null) {int i=1;for (T6250 tenderRecord : tenderRecords) {if (tenderRecord == null) {continue;}
					
					%>
					<tr>
						<td width="330"><%=i++ %></td>
						<td width="156">
						<%StringHelper.filterHTML(out, userInfoManage.getUserName(tenderRecord.F03).substring(0,4)+"***");%>
						</td>
						<td width="362"><%=tenderRecord.F04 %>元</td>
						<td width="362"><%=DateTimeParser.format(tenderRecord.F06,"yyyy-MM-dd HH:mm") %></td>
					</tr>
					<%}}else{%>
					<tr><td colspan="4"></td></tr>
					<%} %>
				</table>
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