<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.TyjInterestListExport"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.TyjInterestList"%>
<%@page import="com.dimeng.p2p.modules.bid.console.service.entity.ExpemonyInte"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.TyjshListExport"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.TyjshList"%>
<%@page import="com.dimeng.p2p.modules.bid.console.service.entity.ExpemoneyCode"%>
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
<%@page import="com.dimeng.p2p.console.servlets.bid.tyjgl.KldhList"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<%
		PagingResult<ExpemonyInte> result = (PagingResult<ExpemonyInte>) request
				.getAttribute("result");

BigDecimal sum1 = new BigDecimal(0);
BigDecimal sum2 = new BigDecimal(0);
String str1=request.getAttribute("sumcomeny").toString();
if(str1!=null){
	sum1 = new BigDecimal(str1);
}
String str2=request.getAttribute("sumtyint").toString();
if(str2!=null){
	sum2 = new BigDecimal(str2);
}
%>
<%
CURRENT_CATEGORY = "CWGL";
CURRENT_SUB_CATEGORY = "TYJINTERESTNEW";
	%>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<form action="<%controller.getURI(request,TyjInterestList.class);%>" method="post" name="form1" id="searchForm">
							<div class="box box1 mb15">
								<div class="atil">
									<h3>体验金利息</h3>
								</div>
								<div class="con">
									<div class="clear"></div>
									<ul class="yhxq_li">
										<li>投标的总金额：<span class="blue"><%=Formater.formatAmount(sum1) %></span>
										</li>
									</ul>
									<ul class="yhxq_li">
										<li>利息总金额 ：<span class="blue"><%=Formater.formatAmount(sum2) %></span>
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
												<span>投标姓名：</span>
												<input type="text" name="userName" value="<%StringHelper.filterHTML(out, request.getParameter("userName")); %>" class="yhgl_input" />
											</p>
											<p>
												<span>放款日期：</span>
												<input type="text" readonly="readonly" name="createTimeStart" id="datepicker1" class="yhgl_input date" />至
											    <input type="text" readonly="readonly" name="createTimeEnd" id="datepicker2" class="yhgl_input date" />
											</p>
											<p>
												<span>标的编号：</span>
												<input type="text" name="randNum" value="<%StringHelper.filterHTML(out, request.getParameter("randNum")); %>" class="yhgl_input" />
											</p>
											<P>
												<input name="search" type="submit" class="btn2" value="搜索" />
												<%if (dimengSession.isAccessableResource(TyjInterestListExport.class)) {%>
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
									<td>姓名</td>
									<td>标的号</td>
									<td>标的名称</td>
									<td>放款日期</td>
									<td>还款日期</td>
									<td>借款期限(天)</td>
									<td>项目规模(元)</td>
									<td>投标金额(元)</td>
									<td>年收化益(%)</td>
									<td>体验金利息收益(元)</td>
								</tr>
								<%
								
								ExpemonyInte[] items = result.getItems();
										if (items != null) {
											int i=1;
											for (ExpemonyInte excode: items) {
												if (excode == null) {
													continue;
												}
								%>
								<tr class="dhsbg">
									<td><%=i++%></td>
									<td><%=excode.ass_account %></td>
									<td><%=excode.account_name %></td>
									<td><%=excode.username %></td>
									<td><%=excode.id %></td>
									<td>
									   <%
										StringHelper.filterHTML(out,excode.title);
										%>
									</td>
									<td><%=excode.loantime==null?"":DateTimeParser.format(excode.loantime,"yyyy-MM-dd")%></td>
									<td><%=excode.repaymenttime==null?"":DateTimeParser.format(excode.repaymenttime,"yyyy-MM-dd")%></td>
									<td><%=excode.borrterm%></td>
									<td><%=Formater.formatAmount(excode.borrmoney)%></td>
									<td><%=Formater.formatAmount(excode.invemoney)%></td>
									<td><%=Formater.formatAmount(excode.borrint)%>%</td>
									<td><%=Formater.formatAmount(excode.inveint)%></td>
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
		document.getElementById("searchForm").action ="<%=controller.getURI(request, TyjInterestListExport.class)%>";
		$("#searchForm").submit();
		document.getElementById("searchForm").action ="<%=controller.getURI(request, TyjInterestList.class)%>";
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
