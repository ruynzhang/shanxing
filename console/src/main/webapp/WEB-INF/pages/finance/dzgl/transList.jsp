<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.finance.dzgl.TransStat"%>
<%@page import="com.dimeng.p2p.S65.entities.T6501"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.dzgl.TransList"%>
<%@page import="com.dimeng.p2p.OrderType"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<%
		CURRENT_CATEGORY = "CWGL";
		CURRENT_SUB_CATEGORY = "JYZTCX";
		
		PagingResult<T6501> pagingResult = (PagingResult<T6501>)request.getAttribute("pagingResult");
		
		int type = IntegerParser.parse(request.getParameter("type"));
	%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<form action="<%controller.getURI(request, TransList.class);%>" method="post" name="form1" id="searchForm">
							<div class="box box1 mb15">
								<div class="con">
									<div class="admin_input admin_pb">
             							<div class="table top3">
											<P>
												<span>订单id：</span>
												<input type="text" class="yhgl_input" name="orderId" value="<%StringHelper.filterQuoter(out, request.getParameter("orderId")); %>" />
											</P>
											<P>
												<span>类型：</span>
												<select name="type">
													<option value="">--请选择--</option>
													<option <%=type==OrderType.BID_CONFIRM.orderType()?"selected=\"selected\"":"" %> value="<%=OrderType.BID_CONFIRM.orderType() %>">散标放款</option>
													<option <%=type==OrderType.BID_REPAYMENT.orderType()?"selected=\"selected\"":"" %> value="<%=OrderType.BID_REPAYMENT.orderType() %>">散标还款</option>
												</select>
											</P>
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
									<td>订单ID</td>
									<td>订单类型</td>
									<td>订单时间</td>
									<td>操作</td>
								</tr>
								<%if(pagingResult != null) {
									T6501[] items = pagingResult.getItems();
									if(items != null){
										for(T6501 item : items){
								%>
								<tr>
									<td><%=item.F01 %></td>
									<td><%=OrderType.getTypeName(item.F02) %></td>
									<td><%=DateParser.format(item.F04) %></td>
									<td><a target="_blank" href="<%=controller.getURI(request, TransStat.class) %>?id=<%=item.F01 %>">交易状态查询</a> </td>
								</tr>
								<%}}} %>
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
		$("#datepicker1").datepicker({inline: true});
	    $('#datepicker1').datepicker('option', {dateFormat:'yy-mm-dd'});
	    $("#datepicker2").datepicker({inline: true});
	    $('#datepicker2').datepicker('option', {dateFormat:'yy-mm-dd'});
	    $("#datepicker1").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("startDate"));%>");
	    $("#datepicker2").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("endDate"));%>");
	});
	</script>
</body>
</html>