<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.Bank"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.Txgl"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.UserWithdrawals"%>
<%@page import="com.dimeng.util.Formater"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.txgl.Txcg"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.txgl.Shtg"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.txgl.Txsb"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.txgl.TxglView"%>
<%@page import="com.dimeng.p2p.common.enums.WithdrawStatus"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.txgl.ExportTxgl"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.txgl.Check"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
<%@include file="/WEB-INF/include/datepicker.jsp"%>
<style type="text/css">
	.yhgl_inputtext{ background:#fff; border:1px #d7dfe3 solid; height:23px; line-height:23px; width:175px;}
</style>
</head>
<%
		BigDecimal txz = ObjectHelper.convert(
				request.getAttribute("txz"), BigDecimal.class);
		BigDecimal txsxf = ObjectHelper.convert(
			request.getAttribute("txsxf"), BigDecimal.class);
		Bank[] banks = ObjectHelper.convertArray(
				request.getAttribute("banks"), Bank.class);
		PagingResult<UserWithdrawals> result = (PagingResult<UserWithdrawals>) request
				.getAttribute("result");
		int bankId = IntegerParser
				.parse(request.getParameter("bankId"));
		BigDecimal totalAmount=new BigDecimal(0);
		BigDecimal totalFee=new BigDecimal(0);
%>
<%
		CURRENT_CATEGORY = "CWGL";
			CURRENT_SUB_CATEGORY = "TXGL";
	%>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
				<form action="<%=controller.getURI(request, Txsb.class)%>" name="form1" method="post" id="searchForm">
					<div class="home_main">
						<div class="box box1 mb15">
							<div class="atil">
								<h3>提现管理</h3>
							</div>
						<div class="con">
								<div class="clear"></div>
								<ul class="yhxq_li">
									<li>提现总额 ：<span class="blue"><%=Formater.formatAmount(txz)%></span>元
									</li>
								</ul>
								<ul class="yhxq_li">
									<li>提现总手续费 ：<span class="blue"><%=Formater.formatAmount(txsxf)%></span>元
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
											<span>流水号:</span>
											<input type="text" class="yhgl_inputtext" name="lsh" value="<%StringHelper.filterQuoter(out, request.getParameter("lsh"));%>" />
										</p>
										<P>
											<span>用户名:</span>
											<input type="text" class="yhgl_inputtext" name="yhm" value="<%StringHelper.filterQuoter(out, request.getParameter("yhm"));%>" />
										</P>
										<P>
											<span>提现银行：</span>
											<select name="bankId" class="selt yhgl_sel" style="width: 100px" >
												<option value="">全部</option>
												<%
													for (Bank bank : banks) {
														if (bank == null) {
															continue;
														}
												%>
												<option value="<%=bank.id%>" <%if (bank.id == bankId) {%> selected="selected" <%}%>>
												<%StringHelper.filterHTML(out, bank.name);%>
												</option>
												<%
													}
												%>
											</select>
										</P>
										<P>
											<span>提现审核时间：</span>
											<input type="text" name="startExtractonTime" id="datepicker1" readonly="readonly" class="yhgl_input date" />至
											<input type="text" name="endExtractionTime" id="datepicker2" readonly="readonly" class="yhgl_input date" />
										</P>
										<P>
											<input name="search" type="submit" class="btn2" value="搜索" />
										</P>
								<div class="clear"></div>
							</div>
							</div>
							</div>
						</div>
						<div class="newsbox">
							<div class="til clearfix">
								<div class="Menubox">
									<ul>
										<li id="one1"><a href="<%=controller.getURI(request, TxglList.class)%>">未审核</a></li>
										<li id="one2"><a href="<%=controller.getURI(request, Shtg.class)%>">审核通过</a></li>
										<li id="one3"><a href="<%=controller.getURI(request, Txcg.class)%>">已提现</a></li>
										<li id="one5" style="border-right: 1px #d7dfe3 solid;"  class="hover">提现失败</li>
									</ul>
								</div>
								<div class="clear"></div>
								<div class="border p15 Men_bt no_table" id="con_one_1">
									<table width="100%" border="0" cellspacing="0" cellpadding="0" class="yhgl_table tc">
										<tr class="hsbg">
											<td>流水号</td>
											<td align="center">用户名</td>
											<td align="center">提现银行</td>
											<td align="center">所在支行</td>
											<td align="center">银行卡号</td>
											<td align="center">提现金额</td>
											<td align="center">手续费</td>
											<td align="center">是否到账</td>
											<td align="center">审核时间</td>
											<td align="center">审核人</td>
											<td align="center">操作</td>
										</tr>
										<%
										UserWithdrawals[] txglRecords = result.getItems();
											if (txglRecords != null&&txglRecords.length>0) {
												for (UserWithdrawals txglItem : txglRecords) {
													if (txglItem == null) {
														continue;
													}
													totalAmount=totalAmount.add(txglItem.F04);
													totalFee=totalFee.add(txglItem.F07);
									    %>
										<tr class="dhsbg">
											<td><%=txglItem.F01%></td>
											<td>
												<%StringHelper.filterHTML(out, txglItem.userName);%>
											</td>
											<td>
												<%StringHelper.filterHTML(out,txglItem.extractionBank);%>
											</td>
											<td>
												<%StringHelper.filterHTML(out, txglItem.subbranch);%>
											</td>
											<td>
												<%StringHelper.filterHTML(out, StringHelper.decode(txglItem.bankId));%>
											</td>
											<td><%=Formater.formatAmount(txglItem.F04)%></td>
											<td><%=Formater.formatAmount(txglItem.F07)%></td>
											<td><%=txglItem.F16.getChineseName() %></td>
											<td><%=Formater.formatDateTime(txglItem.F14==null?txglItem.F11:txglItem.F14)%></td>
											<td><%StringHelper.filterHTML(out, StringHelper.isEmpty(txglItem.txName)?txglItem.shName:txglItem.txName); %></td>
											<td align="center" class="blue">
											<%
											if (dimengSession.isAccessableResource(TxglView.class)) {
											%>
											<a href="<%=controller.getURI(request,TxglView.class)%>?id=<%=txglItem.F01%>">查看原因</a>
											<%}else{ %>
											<span class="gray6">查看原因</span>
											<%} %> 
											</td>
										</tr>
										<%
												}
											}else{
									    %>
									    <tr><td colspan="12" align="center">没有记录</td></tr>
									    <%} %>
									    <tr>
									    	<td colspan="12" align="left"><span style="padding-top: 5px">
										    	总计：提现金额 <span style="color: red;"><%=Formater.formatAmount(totalAmount) %></span>,
												手续费<span style="color: red;"><%=Formater.formatAmount(totalFee) %></span>,
												共<span style="color: red;"><%=txglRecords!=null?txglRecords.length:0 %></span>笔</span>
											</td>
									</tr>
									</table>
									
									<%AbstractFinanceServlet.rendPagingResult(out, result);%>
								</div>
							</div>
							<div class="clear"></div>
						</div>
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
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/txgl/withdrawals.js"></script>
	<%@include file="/WEB-INF/include/datepicker.jsp"%>
	<script type="text/javascript">
	$(function() {
		$("#datepicker1").datepicker({inline: true});
	    $('#datepicker1').datepicker('option', {dateFormat:'yy-mm-dd'});
	    $("#datepicker2").datepicker({inline: true});
	    $('#datepicker2').datepicker('option', {dateFormat:'yy-mm-dd'});
	    $("#datepicker1").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("startExtractonTime"));%>");
	    $("#datepicker2").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("endExtractionTime"));%>");
	});
	</script>
</body>
</html>