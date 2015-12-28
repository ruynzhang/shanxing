<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>线下债权转让详情-<%=configureProvider.getProperty(SystemVariable.SITE_TITLE)%></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="contain clearfix">
		<%@include file="/WEB-INF/include/xxzq/header.jsp"%>
		
		<div class="plan_tab clearfix">
			<ul>
				<li><a href="<%=controller.getPagingItemURI(request, com.dimeng.p2p.front.servlets.financing.xxzq.Bdxq.class, id)%>">标的详情</a></li>
				<%if(creditInfo.F11 == T6230_F11.S){ %>
				<li><a href="<%=controller.getPagingItemURI(request, com.dimeng.p2p.front.servlets.financing.xxzq.Dbxx.class, id)%>">风控信息</a></li>
				<%} %>
				<%
					if(creditInfo.F13 == T6230_F13.S){
				%>
				<li><a href="<%=controller.getPagingItemURI(request, com.dimeng.p2p.front.servlets.financing.xxzq.Dyxx.class, id)%>">抵押物信息</a></li>
				<%
					}
				%>
				<li><a href="<%=controller.getPagingItemURI(request, com.dimeng.p2p.front.servlets.financing.xxzq.Xgwj.class, id)%>">相关文件</a></li>
				<li><a href="<%=controller.getPagingItemURI(request, com.dimeng.p2p.front.servlets.financing.xxzq.Hkjl.class, id)%>">还款计划</a></li>
				<li class="hover">投资记录</li>
				<li style="border-left: 1px solid #d1dfea; padding: 0;"></li>
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