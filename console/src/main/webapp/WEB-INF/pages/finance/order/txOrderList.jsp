<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.finance.order.ExportOrder"%>
<%@page import="com.dimeng.p2p.OrderType"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.order.OrderExceptionList"%>
<%@page import="com.dimeng.p2p.escrow.huichao.entity.Order"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.order.OrderList"%>
<%@page import="com.dimeng.p2p.S61.enums.T6110_F06"%>
<%@page import="com.dimeng.p2p.S61.enums.T6131_F07"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.UserRecharge"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.Czgl"%>
<%@page import="com.dimeng.util.Formater"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.order.TxOrderDZServlet"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<%
		PagingResult<Order> result = (PagingResult<Order>) request
				.getAttribute("result");
%>
<%
		CURRENT_CATEGORY = "CWGL";
			CURRENT_SUB_CATEGORY = "DDGL";
	%>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<form action="<%controller.getURI(request, TxOrderList.class);%>" method="post" name="form1" id="searchForm">
							<div class="box box1 mb15">
								<div class="con">
									<div class="admin_input admin_pb">
             							<div class="table top3">
             								<p>
             									<span>订单号:</span>
             									<input type="text" name="orderId" class="yhgl_input"/>
             								</p>
											<P>
												<span>创建时间：</span>
												<input type="text" name="createStart" id="datepicker1" readonly="readonly" class="yhgl_input date" />至
												<input type="text" name="endStart" id="datepicker2" readonly="readonly" class="yhgl_input date" />
											</P>
											<P>
												<input name="search" type="submit" class="btn2" value="搜索" />
												<%
													if (dimengSession.isAccessableResource(ExportOrder.class))
													{
												%>
												<a href="javascript:void(0)" onclick="showExport()" class="btn3 mr10"><span class="ico"></span>导出</a>
												<%
													}else{
												%>
												<span class="btn3 btn5 mr10"><span class="ico"></span>导出</span>
												<%
													}
												%> 
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
									<td>用户名</td>
									<td>类型</td>
									<td>金额(元)</td>
									<td>状态</td>
									<td>创建时间</td>
									<td>提交时间</td>
									<td>完成时间</td>
									<td>订单来源</td>
									<td>操作</td>
								</tr>
								<%
									Order[] items = result.getItems();
										if (items != null) {
											int i=1;
											for (Order order : items) {
												if (order == null) {
													continue;
												}
								%>
								<tr class="dhsbg">
									<td><%=i++%></td>
									<td><%=order.F01 %></td>
									<td><%StringHelper.filterHTML(out, order.userName); %></td>
									<td><%=OrderType.getTypeName(order.F02)==null?"":OrderType.getTypeName(order.F02) %>
									</td>
									<td><%=Formater.formatAmount(order.amount) %></td>
									<td>
										<%=order.F03.getChineseName()%>
									</td>
									<td><%=DateTimeParser.format(order.F04)%></td>
									<td><%=DateTimeParser.format(order.F05)%></td>
									<td><%=DateTimeParser.format(order.F06)%>
									</td>
									<td><%=order.F07.getChineseName()%></td>
									<td><a href="<%=controller.getURI(request, TxOrderDZServlet.class)%>?orderId=<%=order.F01%>" target="blank">去对账</a></td>	
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
		$("#datepicker1").datepicker({inline: true});
	    $('#datepicker1').datepicker('option', {dateFormat:'yy-mm-dd'});
	    $("#datepicker2").datepicker({inline: true});
	    $('#datepicker2').datepicker('option', {dateFormat:'yy-mm-dd'});
	    $("#datepicker1").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("createStart"));%>");
	    $("#datepicker2").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("endStart"));%>");
	});
	function showExport()
	{
		document.getElementById("searchForm").action ="<%=controller.getURI(request, ExportOrder.class)%>";
		$("#searchForm").submit();
		document.getElementById("searchForm").action ="<%=controller.getURI(request, OrderList.class)%>";
	}
	</script>
</body>
</html>
