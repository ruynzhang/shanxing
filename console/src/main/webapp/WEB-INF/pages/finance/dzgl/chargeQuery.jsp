<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.escrow.huichao.entity.ChargeItem"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet"%>
<%@page import="java.util.Map" %>
<%@page import="java.util.HashMap" %>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<%
		CURRENT_CATEGORY = "CWGL";
		CURRENT_SUB_CATEGORY = "CZDZ";
		
		PagingResult<ChargeItem> pagingResult = (PagingResult<ChargeItem>)request.getAttribute("pagingResult");
	%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<form action="<%controller.getURI(request, ChargeQuery.class);%>" method="post" name="form1" id="searchForm">
							<div class="box box1 mb15">
								<div class="con">
									<div class="admin_input admin_pb">
             							<div class="table top3">
											<P>
												<span>创建时间：</span>
												<input type="text" name="startDate" id="datepicker1" readonly="readonly" class="yhgl_input date" />至
												<input type="text" name="endDate" id="datepicker2" readonly="readonly" class="yhgl_input date" />
											</P>
											<P>
												<input name="search" type="submit" class="btn2" value="搜索" />
											</P>
											<p class="red"><%StringHelper.filterHTML(out, (String)request.getAttribute("errorMsg")); %></p>
									<div class="clear"></div>
								</div>
								</div>
								</div>
							</div>
							<table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
								<tr class="hsbg">
									<td>订单编号</td>
									<td>订单日期</td>
									<td>订单状态</td>
									<td>充值金额(元)</td>
									<td>充值手续费(元)</td>
								</tr>
								<%
								ChargeItem[] items = pagingResult.getItems();
									if(items != null){
										for(ChargeItem item : items){
								%>
								<tr>
									<td><%=item.OrdId  %></td>
									<td><%=item.OrdDate %></td>
									<td><%="00".equals(item.TransStat)?"成功":"失败" %></td>
									<td><%=item.TransAmt%></td>
									<td><%=item.FeeAmt%></td>
								</tr>
								<%}} %>
							</table>
							<%
								AbstractFinanceServlet.rendPagingResult(out, pagingResult);
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
	$(function() {
		$("#datepicker1").datepicker({
			inline: true,
			onSelect : function(selectedDate) {
                $("#datepicker2").datepicker("option", "minDate", selectedDate);  }
		});
	    $('#datepicker1').datepicker('option', {dateFormat:'yy-mm-dd'});
	    $("#datepicker2").datepicker({inline: true});
	    $('#datepicker2').datepicker('option', {dateFormat:'yy-mm-dd'});
	    $("#datepicker1").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("startDate"));%>");
	    $("#datepicker2").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("endDate"));%>");
	    $("#datepicker2").datepicker('option', 'minDate',$("#datepicker1").datepicker().val());
	});
	</script>
</body>
</html>