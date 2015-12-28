<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.finance.yhzjgl.YhjyjlList"%>
<%@page import="com.dimeng.util.Formater"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.yhzjgl.ExportYhjyjl"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<%@page import="com.dimeng.p2p.common.enums.TradingType"%>
<%@page import="com.dimeng.p2p.modules.finance.console.service.entity.YhjyjlRecord"%>
<%@page import="com.dimeng.p2p.modules.finance.console.service.entity.Yhjyjl"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="java.text.DecimalFormat"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
<%@include file="/WEB-INF/include/datepicker.jsp"%>
</head>
<%
		Yhjyjl yhjyjl = ObjectHelper.convert(
				request.getAttribute("yhjyjl"), Yhjyjl.class);
		PagingResult<YhjyjlRecord> result = (PagingResult<YhjyjlRecord>) request.getAttribute("result");
		int id=IntegerParser.parse(request.getAttribute("id"));
%>
<%
	CURRENT_CATEGORY = "CWGL";
		CURRENT_SUB_CATEGORY = "YHZJGL";
%>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
				<form action="<%=controller.getURI(request, YhjyjlList.class) %>" method="post" name="form1" id="searchForm">
					<input type="hidden" name="id" value="<%=id %>">
					<div class="home_main">
						<div class="box box1 mb15">
							<div class="atil">
								<h3>用户交易记录</h3>
							</div>
							<div class="con">
								<div class="clear"></div>
								<ul class="yhxq_li">
									<li>用户名：<span class="blue"> <%
										 	StringHelper.filterHTML(out, yhjyjl.loginName);
										 %>
									</span>
									</li>
								</ul>
								<ul class="yhxq_li">
									<li>姓名 ：<span class="blue"> <%
									 	StringHelper.filterHTML(out, yhjyjl.userName);
									 %>
									</span>
									</li>
								</ul>
								<ul class="yhxq_li">
									<li>总收入：<span class="blue">
									<%if(yhjyjl.totalIncome==null)
										 	{
												out.write("0.00");
											}else{
										%>
									<%=Formater.formatAmount(yhjyjl.totalIncome)%>
									<%} %>
									</span>元
									</li>
								</ul>
								<ul class="yhxq_li">
									<li>总支出 ：<span class="blue">
										<%if(yhjyjl.totalIncome==null)
										 	{
												out.write("0.00");
											}else{
										%>
										<%=Formater.formatAmount(yhjyjl.totalReplay)%>
										<%} %>
									</span>元
									</li>
								</ul>
								<div class="clear"></div>
							</div>
						</div>
						<div class="box box1 mb15">
							<div class="con">
								<div class="admin_input admin_pb">
           							<div class="table top3">	
										<p>
											<span>类型明细：</span>
											<select name="type" class="yhgl_sel">
												<option>所有</option>
												<%
													for(TradingType type:TradingType.values()) {
												%>
												<option value="<%=type.name()%>" <%if(type.name().equals(request.getParameter("type"))) {%> selected="selected" <%} %>><%=type.getName() %></option>
												<%} %>
											</select>
										</p>
										<p>
											<span>时间：</span>
											<input type="text" name="startPayTime" id="datepicker1" readonly="readonly" value="<%StringHelper.filterHTML(out, request.getParameter("startPayTime")); %>" class="yhgl_input date" />至
											<input type="text" name="endPayTime" id="datepicker2" readonly="readonly" class="yhgl_input date" value="<%StringHelper.filterHTML(out, request.getParameter("endPayTime")); %>"/>
										</p>
										<div class="clear"></div>   
                    					<div class="mt10">   
					                    	<input name="search" type="submit" class="btn2 mr10" value="搜索" />
					                    	<%
											if (dimengSession.isAccessableResource(ExportYhjyjl.class)) {
											%>
											<a href="javascript:void(0)" onclick="showExport()" class="btn3 mr10"><span class="ico"></span>导出</a>
											<%}else{ %>
											<span class="btn3 btn5 mr10"><span class="ico"></span>导出</span>
											<%} %> 
                  	 					</div>               
								<div class="clear"></div>
							</div>
							</div>
							</div>
						</div>
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
							<tr class="hsbg">
								<td>序号</td>
								<td>时间</td>
								<td>类型明细</td>
								<td>收入</td>
								<td>支出</td>
								<td>结余</td>
								<td>备注</td>
							</tr>
							<%
								YhjyjlRecord[] records=result.getItems();
								if(records!=null)
								{
									int i=1;
									for(YhjyjlRecord record:records)
									{
										if(record==null)
										{
											continue;
										}
							%>
							<tr class="dhsbg">
								<td><%=i++ %></td>
								<td><%=DateTimeParser.format(record.playTime,"yyyy-MM-dd HH:mm") %></td>
								<td><%if(record.type!=null){%><%=record.type.getName() %><%} %></td>
								<td><%=Formater.formatAmount(record.income) %></td>
								<td><%=Formater.formatAmount(record.replay) %></td>
								<td><%=Formater.formatAmount(record.remain) %></td>
								<td><%StringHelper.filterHTML(out, record.remark); %></td>
							</tr>
							<%}}else{ %>
							<tr><td colspan="7"></td></tr>
							<%} %>
						</table>
						<%AbstractConsoleServlet.rendPagingResult(out, result); %>
						<div class="box2 clearfix"></div>
					</div>
					</form>
				</div>
			</div>
			<%@include file="/WEB-INF/include/left.jsp" %>
		</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<%@include file="/WEB-INF/include/datepicker.jsp"%>
	<script type="text/javascript">
		function showExport()
		{
			document.getElementById("searchForm").action ="<%=controller.getURI(request, ExportYhjyjl.class)%>";
			$("#searchForm").submit();
			document.getElementById("searchForm").action ="<%=controller.getURI(request, YhjyjlList.class)%>";
		}
		$(function() {
			$("#datepicker1").datepicker({inline: true});
		    $('#datepicker1').datepicker('option', {dateFormat:'yy-mm-dd'});
		    $("#datepicker2").datepicker({inline: true});
		    $('#datepicker2').datepicker('option', {dateFormat:'yy-mm-dd'});
		    $("#datepicker1").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("startPayTime"));%>");
		    $("#datepicker2").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("endPayTime"));%>");
		});
	</script>
</body>
</html>