<%@page import="com.dimeng.p2p.modules.financial.front.service.entity.YxxqEntity"%>
<%@page import="com.dimeng.p2p.S64.enums.T6410_F07"%>
<%@page import="com.dimeng.p2p.modules.financial.front.service.FinancialManage"%>
<%@page import="com.dimeng.p2p.variables.defines.URLVariable"%>
<div class="clear"></div>
<%
	{
		FinancialManage financialManage = serviceSession.getService(FinancialManage.class);
		YxxqEntity planInfo= financialManage.getNewPlan();
		if(planInfo!=null)
		{
%>
<div class="financial">
	<div class="title">
		<a href="<%configureProvider.format(out, URLVariable.FINANCING_YX);%>"> <%StringHelper.filterHTML(out, planInfo.F02); %>
		</a>
	</div>
	<div class="time" style="display: <%=(planInfo.F07 == T6410_F07.YFB && planInfo.F09.after(planInfo.currentTime)) ?"block":"none"%>;">
	</div>
	<div class="plan-progress-container" style="display: <%=planInfo.F07==T6410_F07.YSX?"block":"none"%>;">
		<a class="ui-progressbar-circle ui-progressbar-circle-ready">已满额</a>
	</div>
	<div class="plan-progress-container" style="display: <%=(planInfo.F07==T6410_F07.YFB && !planInfo.F09.after(planInfo.currentTime))?"block":"none"%>;">
		<span class="ui-progressbar-large ui-progressbar-large-<%=new BigDecimal(planInfo.proess*100).intValue() %>"><em>申请中</em></span>
	</div>
	<div class="plan-progress-container" style="display: <%=planInfo.F07==T6410_F07.YJZ?"block":"none"%>;">
		<a class="ui-progressbar-circle ui-progressbar-circle-ready">已截止</a>
	</div>
	<div class="condition">
		<table width="100%" border="0">
			<tr>
				<td><i></i>加入条件：<span class="f18 orange"><b><%=Formater.formatAmount(planInfo.F22)%></b></span>元</td>
				<td><i></i>计划总额：<span class="f18 orange"><b><%=Formater.formatAmount(planInfo.F23)%></b></span>元</td>
				<td>预期收益：<span class="f18 orange"><b><%=Formater.formatRate(planInfo.F05.doubleValue())%></b></span>
				</td>
			</tr>
		</table>
	</div>
</div>
<script type="text/javascript">
		var endTime =<%=planInfo.F09.getTime()-System.currentTimeMillis()%>;
		var clearTime = null;
		function time() {
			var leftsecond = parseInt(endTime / 1000);
			var day = Math.floor(leftsecond/ (60 * 60 * 24)) < 0 ? 0 : Math.floor(leftsecond / (60 * 60 * 24));
			var hour = Math.floor((leftsecond - day * 24 * 60 * 60) / 3600) < 0 ? 0: Math.floor((leftsecond - day * 24 * 60 * 60) / 3600);
			var minute = Math.floor((leftsecond - day* 24 * 60 * 60 - hour * 3600) / 60) < 0 ? 0: Math.floor((leftsecond - day* 24 * 60 * 60 - hour * 3600) / 60);
			var second = Math.floor(leftsecond - day* 24 * 60 * 60 - hour * 3600- minute * 60) < 0 ? 0 : Math.floor(leftsecond - day * 24 * 60* 60 - hour * 3600 - minute* 60);
			if(hour<10)
			{
				hour="0"+hour;	
			}
			if(minute<10)
			{
				minute="0"+minute;	
			}
			if(second<10)
			{
				second="0"+second;	
			}
			$(".time").html("还有<span class=\"f24\">"+hour+"小时"+minute+"分"+second+"秒</span>开始发售");
			if (leftsecond <= 0) {
				clearInterval(clearTime);
			}
		}
		<%if((planInfo.F07==T6410_F07.YFB && planInfo.F09.after(planInfo.currentTime))){%>
			clearTime = setInterval(function() {
			endTime = endTime - 1000;
			time();
		}, 1000);
		<%}else{%>
			clearInterval(clearTime);
		<%}%>
</script>
<%}}%>