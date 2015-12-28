<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.finance.czgl.ExportCzgl"%>
<%@page import="java.math.BigDecimal"%>
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
		BigDecimal czze = ObjectHelper.convert(request.getAttribute("czze"),
				BigDecimal.class);
		BigDecimal czsxf = ObjectHelper.convert(request.getAttribute("czsxf"),
		BigDecimal.class);
		PagingResult<UserRecharge> result = (PagingResult<UserRecharge>) request
				.getAttribute("result");
%>
<%
		CURRENT_CATEGORY = "CWGL";
			CURRENT_SUB_CATEGORY = "CZGL";
	%>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<form action="<%controller.getURI(request, CzglList.class);%>" method="post" name="form1" id="searchForm">
							<div class="box box1 mb15">
								<div class="atil">
									<h3>充值管理</h3>
								</div>
								<div class="con">
									<div class="clear"></div>
									<ul class="yhxq_li">
										<li>成功充值总额：<span class="blue"><%=Formater.formatAmount(czze)%></span>元
										</li>
									</ul>
									<ul class="yhxq_li">
										<li>成功充值手续费 ：<span class="blue"><%=Formater.formatAmount(czsxf)%></span>元
										</li>
									</ul>
									<ul class="yhxq_li">
										<li>更新时间 ：<span class="blue"><%=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date())%></span>
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
												<span>流水单号：</span>
												<input type="text" name=serialNumber value="<%StringHelper.filterHTML(out, request.getParameter("serialNumber")); %>" class="yhgl_input" />
											</p>
											<p>
												<span>用户名：</span>
												<input type="text" name="loginName" value="<%StringHelper.filterHTML(out, request.getParameter("loginName")); %>" class="yhgl_input" />
											</p>
											<P>
												<span>用户类型：</span>
												<select name="userType" class="yhgl_sel" >
														<option>全部</option>
														<%
															for (T6110_F06 userType : T6110_F06.values()) {
														%>
														<option value="<%=userType.name()%>" <%if (userType.name().equals(request.getParameter("userType"))){%> selected="selected" <%} %>><%=userType.getChineseName()%></option>
														<%
															}
														%>
												</select>
											</P>
											<P>
												<input name="search" type="submit" class="btn2" value="搜索" />
												<%if (dimengSession.isAccessableResource(ExportCzgl.class)) {%>
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
									<td>订单号</td>
									<td>用户名</td>
									<td>充值金额(元)</td>
									<td>应收手续费(元)</td>
									<td>实收手续费(元)</td>
									<td>用户类型</td>
									<td>充值时间</td>
									<td>支付公司代号</td>
									<td>流水单号</td>
									<!-- <td>操作</td> -->
								</tr>
								<%
									UserRecharge[] items = result.getItems();
										if (items != null) {
											int i=1;
											for (UserRecharge rechargeItem : items) {
												if (rechargeItem == null) {
													continue;
												}
								%>
								<tr class="dhsbg">
									<td><%=i++%></td>
									<td><%=rechargeItem.F01 %></td>
									<td>
										<%
											StringHelper.filterHTML(out, rechargeItem.userName);
										%>
									</td>
									<td><%=Formater.formatAmount(rechargeItem.F03)%></td>
									<td><%=Formater.formatAmount(rechargeItem.F04)%></td>
									<td><%=Formater.formatAmount(rechargeItem.F05)%></td>
									<td><%=rechargeItem.userType.getChineseName() %></td>
									<td><%=DateTimeParser.format(rechargeItem.createTime) %></td>
									<td><%=rechargeItem.F07%>
									</td>
									<td><%StringHelper.filterHTML(out, rechargeItem.F08);%></td>
									<%--<td> <a target="_blank" href="<%=configureProvider.format(URLVariable.PAY_CHECK) %>?o=<%=rechargeItem.F01 %>">去对账</a></td>--%>
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
	function showExport()
	{
		document.getElementById("searchForm").action ="<%=controller.getURI(request, ExportCzgl.class)%>";
		$("#searchForm").submit();
		document.getElementById("searchForm").action ="<%=controller.getURI(request, CzglList.class)%>";
	}
	$(function() {
		$("#datepicker1").datepicker({inline: true});
	    $('#datepicker1').datepicker('option', {dateFormat:'yy-mm-dd'});
	    $("#datepicker2").datepicker({inline: true});
	    $('#datepicker2').datepicker('option', {dateFormat:'yy-mm-dd'});
	    $("#datepicker1").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("startRechargeTime"));%>");
	    $("#datepicker2").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("endRechargeTime"));%>");
	});
	</script>
</body>
</html>
