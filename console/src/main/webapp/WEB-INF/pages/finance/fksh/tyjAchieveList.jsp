<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.TyjAchieveDetailList"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.TyjAchieveListExport"%>
<%@page import="com.dimeng.p2p.modules.bid.console.service.entity.ExpemonyAchieve"%>
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
		PagingResult<ExpemonyAchieve> result = (PagingResult<ExpemonyAchieve>) request
				.getAttribute("result");

BigDecimal sum1 = new BigDecimal(0);
BigDecimal sum2 = new BigDecimal(0);
BigDecimal sum3 = new BigDecimal(0);
String str1=request.getAttribute("sumcomeny").toString();
if(str1!=null){
	sum1 = new BigDecimal(str1);
}
String str2=request.getAttribute("transSumMoney").toString();
if(str2!=null){
	sum2 = new BigDecimal(str2);
}
String str3=request.getAttribute("suprsumcomeny").toString();
if(str3!=null){
	sum3 = new BigDecimal(str3);
}
%>
<%
CURRENT_CATEGORY = "CWGL";
CURRENT_SUB_CATEGORY = "TYJACHIEVENEW";
	%>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<form action="<%controller.getURI(request,TyjAchieveList.class);%>" method="post" name="form1" id="searchForm">
						   <input type="hidden" id="user_id" name="user_id" value=""/>
						    <input type="hidden" id="ass_account" name="ass_account" value=""/>
						     <input type="hidden" id="account_name" name="account_name" value=""/>
						      <input type="hidden" id="username" name="username" value=""/>
						       <input type="hidden" id="sumtyj" name="sumtyj" value=""/>
						        <input type="hidden" id="invemoney" name="invemoney" value=""/>
						         <input type="hidden" id="noinvemoney" name="noinvemoney" value=""/>
						          <input type="hidden" id="inveint" name="inveint" value=""/>
							<div class="box box1 mb15">
								<div class="atil">
									<h3>已领取体验金统计</h3>
								</div>
								<div class="con">
									<div class="clear"></div>
									<ul class="yhxq_li">
										<li>已获得体验金总金额：<span class="blue"><%=Formater.formatAmount(sum1) %></span>
										</li>
									</ul>
									<ul class="yhxq_li">
										<li>已使用体验金总数：<span class="blue"><%=Formater.formatAmount(sum2) %></span>
										</li>
									</ul>
									<ul class="yhxq_li">
										<li>未使用体验金总数：<span class="blue"><%=Formater.formatAmount(sum3) %></span>
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
												<span>姓名：</span>
												<input type="text" name="userName" value="<%StringHelper.filterHTML(out, request.getParameter("userName")); %>" class="yhgl_input" />
											</p>
											<p>
												<span>截止日期：</span>
												<input type="text" readonly="readonly" name="createTimeStart" id="datepicker1" class="yhgl_input date" />至
											    <input type="text" readonly="readonly" name="createTimeEnd" id="datepicker2" class="yhgl_input date" />
											</p>
											<P>
												<input name="search" type="submit" class="btn2" value="搜索" />
												<%if (dimengSession.isAccessableResource(TyjAchieveListExport.class)) {%>
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
									<td>截止日期</td>
									<td>资金账号</td>
									<td>用户名</td>
									<td>姓名</td>
									<td>获得体验金总数</td>
									<td>已使用体验金总数</td>
									<td>未使用体验金总数</td>
									<td>体验金利息收益(元)</td>
									<td>体验金对账单</td>
								</tr>
								<%
								
								ExpemonyAchieve[] items = result.getItems();
										if (items != null) {
											int i=1;
											for (ExpemonyAchieve excode: items) {
												if (excode == null) {
													continue;
												}
								%>
								<tr class="dhsbg">
									<td><%=i++%></td>
									<td><%=excode.expiryTime==null?"":DateTimeParser.format(excode.expiryTime,"yyyy-MM-dd") %></td>
									<td><%=excode.ass_account %></td>
									<td><%=excode.account_name %></td>
									<td><%=excode.username==null?"":excode.username %></td>
									<td><%=Formater.formatAmount(excode.sumtyj)%></td>
									<td><%=Formater.formatAmount(excode.invemoney)%></td>
									<td><%=Formater.formatAmount(excode.noinvemoney)%></td>
									<td><%=Formater.formatAmount(excode.inveint)%></td>
									<td><a href="javascript:void(0)" onclick="showInfo(<%=excode.user_id%>,'<%=excode.ass_account %>','<%=excode.account_name %>','<%=excode.username %>',
									<%=excode.sumtyj%>,<%=excode.invemoney%>,<%=excode.noinvemoney%>,<%=excode.inveint%>)">明细</a></td>
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
		document.getElementById("searchForm").action ="<%=controller.getURI(request, TyjAchieveListExport.class)%>";
		$("#searchForm").submit();
		document.getElementById("searchForm").action ="<%=controller.getURI(request, TyjAchieveList.class)%>";
	}
	// showInfo(2,W00000000002,zhengxin,郑鑫,1,000.00,1,000.00,0.00,3.33)
	function showInfo(user_id, ass_account, account_name, username, sumtyj, invemoney, noinvemoney, inveint){
		$("#user_id").val(user_id);
		$("#ass_account").val(ass_account);
		$("#account_name").val(account_name);
		$("#username").val(username);
		$("#sumtyj").val(sumtyj);
		$("#invemoney").val(invemoney);
		$("#noinvemoney").val(noinvemoney);
		$("#inveint").val(inveint);
		document.getElementById("searchForm").action ="<%=controller.getURI(request, TyjAchieveDetailList.class)%>";
		$("#searchForm").submit();
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
