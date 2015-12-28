<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.UserTotle"%>
<%@page import="com.dimeng.p2p.common.enums.EnsureMode"%>
<%@page import="com.dimeng.p2p.S61.enums.T6101_F03"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.zjgl.ZJjyList"%>
<%@page import="com.dimeng.util.Formater"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.zjgl.ExportZJJygl"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<%@page import="com.dimeng.p2p.S51.entities.T5122"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.FundsJYView"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.dimeng.p2p.S61.enums.T6110_F06"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
<%@include file="/WEB-INF/include/datepicker.jsp"%>
</head>
<%
	T5122[] tradeTypes  = ObjectHelper.convertArray(request.getAttribute("tradeTypes"), T5122.class);
	PagingResult<FundsJYView> result = ObjectHelper.convert(request.getAttribute("result"), PagingResult.class);
	
	UserTotle userTotle=ObjectHelper.convert(request.getAttribute("userTotle"), UserTotle.class);
	int id=IntegerParser.parse(request.getAttribute("id"));
	T6101_F03 t6101_F03=ObjectHelper.convert(request.getAttribute("t6101_F03"), T6101_F03.class);
%>
<%
	CURRENT_CATEGORY = "CWGL";
		CURRENT_SUB_CATEGORY = "ZJGL";
%>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<form action="<%=controller.getURI(request, ZJjyList.class)%>" method="post" name="form1" id="searchForm">
						<input type="hidden" name="id" value="<%=id%>">
						<div class="home_main">
							<div class="box box1 mb15">
								<div class="atil">
									<h3>资金交易记录</h3>
								</div>
								<div class="con">
									<div class="clear"></div>
								<ul class="yhxq_li">
									<li>用户ID ：<span class="blue"><%=id%></span>
									</li>
								</ul>
								<ul class="yhxq_li">
									<li>用户名 ：<span class="blue"><%StringHelper.filterHTML(out, userTotle.loginName);%></span>
									</li>
								</ul>
								<%if(userTotle.userType == T6110_F06.ZRR){ %>
								<ul class="yhxq_li">
									<li>投资总计 ：<span class="blue"><%=Formater.formatAmount(userTotle.tzTotle)%></span>元
									</li>
								</ul>
								<%} %>
								<ul class="yhxq_li">
									<li>收益总计 ：<span class="blue"><%=Formater.formatAmount(userTotle.syTotle)%></span>元
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
												<span>类型明细：</span> <select name="type" class="yhgl_sel">
													<option>所有</option>
													<%
														for(T5122 type:tradeTypes) {
													%>
													<option value="<%=type.F01%>" <%if((type.F01+"").equals(request.getParameter("type"))) {%> selected="selected" <%}%>><%=type.F02%></option>
													<%
														}
													%>
												</select>
											</p>
											<p>
												<span>时间：</span> <input type="text" name="startPayTime" id="datepicker1" readonly="readonly" value="<%StringHelper.filterHTML(out, request.getParameter("startPayTime"));%>"
													class="yhgl_input date" />至 <input type="text" name="endPayTime" id="datepicker2" readonly="readonly" class="yhgl_input date"
													value="<%StringHelper.filterHTML(out, request.getParameter("endPayTime"));%>" />
											</p>
											<div class="clear"></div>
											<div class="mt10">
												<input name="search" type="submit" class="btn2 mr10" value="搜索" />
												<%
													if (dimengSession.isAccessableResource(ExportZJJygl.class)) {
												%>
												<a href="javascript:void(0)" onclick="showExport()" class="btn3 mr10"><span class="ico"></span>导出</a>
												<%
													}else{
												%>
												<span class="btn3 btn5 mr10"><span class="ico"></span>导出</span>
												<%
													}
												%>
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
									<%
										if(t6101_F03==T6101_F03.WLZH)
										{
									%>
									<td>结余</td>
									<%} %>
									<td>备注</td>
								</tr>
								<%
									FundsJYView[] records=result.getItems();
														if(records!=null)
														{
															int i=1;
															for(FundsJYView record:records)
															{
																if(record==null)
																{
																	continue;
																}
								%>
								<tr class="dhsbg">
									<td><%=i++%></td>
									<td><%=DateTimeParser.format(record.F05)%></td>
									<td>
										<%
											String tradetype="";
													for(T5122 type:tradeTypes) {
													if(record.F03==type.F01) {
														tradetype=type.F02;
														break;
													} }
										%> <%=tradetype%></td>
									<td><%=Formater.formatAmount(record.F06)%></td>
									<td><%=Formater.formatAmount(record.F07)%></td>
									<%
										if(t6101_F03==T6101_F03.WLZH)
										{
									%>
									<td><%=Formater.formatAmount(record.F08)%></td>
									<%} %>
									<td>
										<%
											StringHelper.filterHTML(out, record.F09);
										%>
									</td>
								</tr>
								<%
									}}else{
								%>
								<tr>
									<td colspan="7"></td>
								</tr>
								<%
									}
								%>
							</table>
							<%
								AbstractConsoleServlet.rendPagingResult(out, result);
							%>
							<div class="box2 clearfix"></div>
						</div>
					</form>
				</div>
			</div>
			<%@include file="/WEB-INF/include/left.jsp"%>
		</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<%@include file="/WEB-INF/include/datepicker.jsp"%>
	<script type="text/javascript">
		function showExport()
		{
			document.getElementById("searchForm").action ="<%=controller.getURI(request, ExportZJJygl.class)%>";
			$("#searchForm").submit();
			document.getElementById("searchForm").action ="<%=controller.getURI(request, ZJjyList.class)%>";
		}
		$(function() {
			$("#datepicker1").datepicker({
				inline: true,
				onSelect : function(selectedDate) {
                    $("#datepicker2").datepicker("option", "minDate", selectedDate);  }
			});
		    $('#datepicker1').datepicker('option', {dateFormat:'yy-mm-dd'});
		    $("#datepicker2").datepicker({inline: true});
		    $('#datepicker2').datepicker('option', {dateFormat:'yy-mm-dd'});
		    $("#datepicker1").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("startPayTime"));%>");
		    $("#datepicker2").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("endPayTime"));%>");
		    $("#datepicker2").datepicker('option', 'minDate',$("#datepicker1").datepicker().val());
		});
	</script>
</body>
</html>