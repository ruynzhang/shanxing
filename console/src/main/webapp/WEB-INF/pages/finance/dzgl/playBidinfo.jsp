<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.finance.dzgl.PlayBidinfoExport"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.dzgl.PlayBidinfo"%>
<%@page import="com.dimeng.p2p.modules.bid.console.service.entity.PlayBidentity"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.dimeng.util.Formater"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<%
		PagingResult<PlayBidentity> result = (PagingResult<PlayBidentity>) request
				.getAttribute("result");
%>
<%
CURRENT_CATEGORY = "CWGL";
CURRENT_SUB_CATEGORY = "PLAYBIDINFO";
	%>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<form action="<%controller.getURI(request,PlayBidinfo.class);%>" method="post" name="form1" id="searchForm">
							<div class="box box1 mb15">
							    <div class="atil">
									<h3>标的支出表</h3>
								</div>
								<div class="con">
									<div class="admin_input admin_pb">
             							<div class="table top3">
             							    <p>
												<span>贷款名称：</span>
												<input type="text" name="randNum" value="<%StringHelper.filterHTML(out, request.getParameter("randNum")); %>" class="yhgl_input" />
											</p>
											<p>
												<span>投标人：</span>
												<input type="text" name="userName" value="<%StringHelper.filterHTML(out, request.getParameter("userName")); %>" class="yhgl_input" />
											</p>
											<p>
												<span>投标时间：</span>
												<input type="text" readonly="readonly" name="createTimeStart" id="datepicker1" class="yhgl_input date" />至
											    <input type="text" readonly="readonly" name="createTimeEnd" id="datepicker2" class="yhgl_input date" />
											</p>
											
											<P>
												<input name="search" type="submit" class="btn2" value="搜索" />
												<%if (dimengSession.isAccessableResource(PlayBidinfoExport.class)) {%>
													<a href="javascript:void(0)" onclick="showExport()" class="btn3 mr10"><span class="ico"></span>导出</a>
												<%}else{ %>
													<span class="btn3 btn5 mr10"><span class="ico"></span>导出</span>
												<%} %> 
											</P>
									<div class="clear"></div>
								</div>
								</div>
								</div>
							</div>
							<table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
								<tr class="hsbg">
									<td>序号</td>
									<td>资金账号</td>
									<td>用户名</td>
									<td>投标人</td>
									<td>放款时间</td>
									<td>还款时间</td>
									<td>贷款编号</td>
									<td>贷款名称</td>
									<td>年化收益</td>
									<td>投资奖励</td>
									<td>贷款期限</td>
									<td>投标金额</td>
									<td>项目规模</td>
									<td>利息支出</td>
									<td>佣金率</td>
									<td>佣金支出</td>
									<td>额外奖励</td>
									<td>额外支出</td>
									<td>支出合计</td>
								</tr>
								<%
								
								PlayBidentity[] items = result.getItems();
										if (items != null) {
											int i=1;
											for (PlayBidentity excode: items) {
												if (excode == null) {
													continue;
												}
								%>
								<tr class="dhsbg">
									<td><%=i++%></td>
									<td><%=excode.ass_account %></td>
								    <td><%=excode.account_name %></td>
								    <td><%=excode.user_name %></td>
								    <td><%=excode.cj_date==null?"":DateTimeParser.format(excode.cj_date,"yyyy-MM-dd")%></td>
								    <td><%=excode.hk_date==null?"":DateTimeParser.format(excode.hk_date,"yyyy-MM-dd")%></td>
								    <td><%=excode.bId %></td>
								    <td><%=excode.bdName %></td>
								    <td><%=excode.rate %></td>
								    <td><%=excode.reward %></td>
								    <td><%=excode.tz_qx %></td>
									<td><%=excode.amount==null?"":Formater.formatAmount(excode.amount)%></td>
									<td><%=excode.bdAmount==null?"":Formater.formatAmount(excode.bdAmount)%></td>
									<td><%=excode.lucre.compareTo(BigDecimal.ZERO)<=0?"":Formater.formatAmount(excode.lucre)%></td>
									<td><%=excode.commissioint %></td>
									<td><%=excode.comissionpay.compareTo(BigDecimal.ZERO)<=0?"":Formater.formatAmount(excode.comissionpay)%></td>
									<td><%=excode.extea_bonus.compareTo(BigDecimal.ZERO)<=0?"":(excode.extea_bonus.doubleValue()*100)+"%"%></td>
									<td><%=excode.extrousepx.compareTo(BigDecimal.ZERO)<=0?"":Formater.formatAmount(excode.extrousepx)%></td>
									<td><%=excode.paycount==null?"":Formater.formatAmount(excode.paycount.add(excode.extrousepx).add(excode.lucre))%></td>
								
								</tr>
								<%
									}
										}
								%>
							</table>
							<%
							    AbstractConsoleServlet.rendPagingResult(out, result);
							%>
							<div class="box2 clearfix"></div>
						</form>
					</div>
				</div>
			</div>
			<%@include file="/WEB-INF/include/left.jsp"%>
		</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<%@include file="/WEB-INF/include/datepicker.jsp"%>
	<script type="text/javascript">
	$("#nastatus option[value="+<%=request.getParameter("nastatus")%>+"]").attr("selected",true);
	function showExport()
	{
		document.getElementById("searchForm").action ="<%=controller.getURI(request, PlayBidinfoExport.class)%>";
		$("#searchForm").submit();
		document.getElementById("searchForm").action ="<%=controller.getURI(request, PlayBidinfo.class)%>";
	}
	$(function() {
		$("#datepicker1").datepicker({inline: true});
	    $('#datepicker1').datepicker('option', {dateFormat:'yy-mm-dd'});
	    $("#datepicker2").datepicker({inline: true});
	    $('#datepicker2').datepicker('option', {dateFormat:'yy-mm-dd'});
	    $("#datepicker1").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("createTimeStart"));%>");
	    $("#datepicker2").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("createTimeEnd"));%>");
	});
	</script>
</body>
</html>
