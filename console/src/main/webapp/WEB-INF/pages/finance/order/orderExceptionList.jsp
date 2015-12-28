<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.OrderType"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.OrderException"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.order.Detail"%>
<%@page import="com.dimeng.p2p.S65.entities.T6550"%>
<%@page import="com.dimeng.p2p.S61.enums.T6110_F06"%>
<%@page import="com.dimeng.p2p.S61.enums.T6131_F07"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.UserRecharge"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.Czgl"%>
<%@page import="com.dimeng.util.Formater"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<%
		PagingResult<OrderException> result = (PagingResult<OrderException>) request
				.getAttribute("result");
%>
<%
		CURRENT_CATEGORY = "CWGL";
		CURRENT_SUB_CATEGORY = "DDYCRZ";
	%>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<form action="<%controller.getURI(request, OrderExceptionList.class);%>" method="post" name="form1">
							<div class="box box1 mb15">
								<div class="con">
									<div class="admin_input admin_pb">
             							<div class="table top3">
             								<p>
												<span>订单号：</span>
												<input type="text" name="orderId" value="<%StringHelper.filterHTML(out, request.getParameter("orderId")); %>" class="yhgl_input" />
											</p>
											<P>
												<span>发生时间：</span>
												<input type="text" name="timeStart" id="datepicker1" readonly="readonly" class="yhgl_input date" />至
												<input type="text" name="timeEnd" id="datepicker2" readonly="readonly" class="yhgl_input date" />
											</P>
											<P>
												<input name="search" type="submit" class="btn2" value="搜索" />
											</P>
									<div class="clear"></div>
								</div>
								</div>
								</div>
							</div>
							<table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
								<tr class="hsbg">
									<td>序号</td>
									<td>订单ID</td>
									<td>订单类型</td>
									<td>发生时间</td>
									<td>操作</td>
								</tr>
								<%
								OrderException[] items = result.getItems();
										if (items != null) {
											int i=1;
											for (OrderException t6550 : items) {
												if (t6550 == null) {
													continue;
												}
								%>
								<tr class="dhsbg">
									<td><%=i++%></td>
									<td><%=t6550.F02 %></td>
									<td><%=OrderType.getTypeName(t6550.typeId) %></td>
									<td><%=DateTimeParser.format(t6550.F04)%></td>
									<td><a href="<%=controller.getURI(request, Detail.class)%>?id=<%=t6550.F01%>" target="_blank">查看</a></td>
								</tr>
								<%
									}
										}
								%>
							</table>
							<%
								AbstractFinanceServlet.rendPagingResult(out, result);
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
		$("#datepicker1").datepicker({inline: true,
			onSelect : function(selectedDate) {
	            $("#datepicker2").datepicker("option", "minDate", selectedDate); 
	        }
		});
		$("#datepicker1").datepicker({inline: true});
	    $('#datepicker1').datepicker('option', {dateFormat:'yy-mm-dd'});
	    $("#datepicker2").datepicker({inline: true});
	    $('#datepicker2').datepicker('option', {dateFormat:'yy-mm-dd'});
	    $("#datepicker1").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("timeStart"));%>");
	    $("#datepicker2").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("timeEnd"));%>");
	    $("#datepicker2").datepicker('option', 'minDate',$("#datepicker1").datepicker().val());
	});
	</script>
</body>
</html>
